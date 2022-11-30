import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../base/dependencyinjection/locator.dart';
import '../../../base/extensions/scaffold_extension.dart';
import '../../../base/utils/constants/app_constants.dart';
import '../../../base/utils/constants/color_constants.dart';
import '../../../base/utils/constants/image_constant.dart';
import '../../../base/utils/constants/size_constants.dart';
import '../../../base/utils/enum_utils.dart';
import '../../../base/utils/localization/localization.dart';
import '../../../base/utils/navigation.dart';
import '../../../base/utils/reusablemethods/reusable_ui_method.dart';
import '../../../widgets/custome_pop_up.dart';

// ignore: must_be_immutable
class ScanQR extends StatefulWidget {
  scanQRType? type;
  ScanQR({super.key, this.type});
  @override
  State<StatefulWidget> createState() => _ScanQRState();
}

class _ScanQRState extends State<ScanQR> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  bool isFlashOn = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      setState(() {
        if (result == null && scanData.code != null) {
          result = scanData;
          var data =
              scanData.code!.substring(0, scanData.code!.length - 1).split(",");
          String serialNumber = data.last.split(":").last;
          String uuIdNumber = data.first.split(":").last;
          debugPrint(
              "result..........$serialNumber....$uuIdNumber........$result");
          CustomPopUp.showCustomeDialog(context,
              isCustomText: true,
              subTitle: "($serialNumber)",
              title: widget.type == scanQRType.unassignRo
                  ? Localization.of(context)!.unassignBeaconMsg
                  : Localization.of(context)!.getBeaconMsg,
              okText: Localization.of(context)!.confirm,
              cancelText: Localization.of(context)!.cancel, okAction: () {
            locator<NavigationUtils>().pop(context, args: {
              AppConstants.serialNumbar: serialNumber,
              AppConstants.uuIdNumber: uuIdNumber,
              AppConstants.type: widget.type
            });
          }, cancelAction: () {
            locator<NavigationUtils>().pop(context);
          },
              isCancel: true,
              isOk: true,
              image: SvgPicture.asset(
                ImageConstant.icAssignBeacon,
                color: ColorConstants.textColor,
              ).paddingOnly(
                  bottom: SizeConstants.size24, top: SizeConstants.size30));
        }
      });
    });
    setState(() {
      this.controller!.resumeCamera();
    });
  }

  void offFlash() async {
    if (isFlashOn) {
      await controller!.toggleFlash();
      isFlashOn = false;
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setScreenSize(context);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          child: Container(
            height: SizeConstants.size1.sh,
            width: SizeConstants.size1.sw,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(ImageConstant.icAuthBack),
                    fit: BoxFit.fill)),
            child: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      flex: 5,
                      child: _buildQrView(context),
                    )
                  ],
                ),
                SvgPicture.asset(ImageConstant.icCancel)
                    .paddingOnly(
                        top: SizeConstants.size40, left: SizeConstants.size24)
                    .onTap(() {
                  locator<NavigationUtils>().pop(context);
                }),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: FutureBuilder(
                    future: controller?.getFlashStatus(),
                    builder: (context, snapshot) {
                      debugPrint("value.....${snapshot.data}");
                      isFlashOn = snapshot.data ?? false;
                      return SvgPicture.asset(snapshot.data ?? false
                          ? ImageConstant.icFlashOn
                          : ImageConstant.icFlash);
                    },
                  ).paddingOnly(bottom: SizeConstants.size40).onTap(() async {
                    await controller?.toggleFlash();
                    setState(() {});
                  }),
                ),
              ],
            ),
          ),
        )).authContainerScaffold(context: context);
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : SizeConstants.size194;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: ColorConstants.whiteColor,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          overlayColor: Colors.black.withOpacity(0.6),
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    debugPrint('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }
}
