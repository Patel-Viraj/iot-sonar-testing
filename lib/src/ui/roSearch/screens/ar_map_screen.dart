import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../base/dependencyinjection/locator.dart';
import '../../../base/utils/constants/color_constants.dart';
import '../../../base/utils/constants/font_style.dart';
import '../../../base/utils/constants/image_constant.dart';
import '../../../base/utils/constants/navigation_route_constants.dart';
import '../../../base/utils/constants/size_constants.dart';
import '../../../base/utils/localization/localization.dart';
import '../../../base/utils/navigation.dart';
import '../../../base/utils/reusablemethods/reusable_ui_method.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_button_simple.dart';

// ignore: must_be_immutable
class ARMapScreen extends StatefulWidget {
  const ARMapScreen({super.key});
  @override
  State<StatefulWidget> createState() => _ARMapScreenState();
}

class _ARMapScreenState extends State<ARMapScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  static const CameraPosition _carLatLng = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 16,
  );
  static const CameraPosition _keyLatLng = CameraPosition(
    target: LatLng(37.4257759, -122.0872893),
    zoom: 16,
  );
  final List<Marker> _markers = <Marker>[];
  PersistentBottomSheetController? _directionControllerBottomSheet;
  bool isShowPopUp = false;
  final String _msg = "keep moving towards the Main Building location.";
  final Color _popUpBackColor = ColorConstants.arPopUpGreenColor;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      BitmapDescriptor customIcon = await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(
              size: Size(SizeConstants.size47, SizeConstants.size47)),
          ImageConstant.icMarker);
      _markers.add(Marker(
        icon: customIcon,
        markerId: const MarkerId('1'),
        position: _keyLatLng.target,
      ));
      _markers.add(Marker(
        icon: customIcon,
        markerId: const MarkerId('2'),
        position: _carLatLng.target,
      ));
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    setScreenSize(context);
    return Scaffold(
      key: _key,
      body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: LayoutBuilder(
            builder: (context, constraint) {
              return Container(
                  height: SizeConstants.size1.sh,
                  width: SizeConstants.size1.sw,
                  // padding: REdgeInsets.only(
                  //     top: kToolbarHeight + SizeConstants.size36),
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(ImageConstant.icAuthBack),
                          fit: BoxFit.fill)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                          child: Stack(
                        children: [
                          if (isShowPopUp)
                            _popUp(context, _popUpBackColor, _msg)
                        ],
                      )),
                      _map(context),
                    ],
                  ));
            },
          )),
    );
  }

  Widget _popUp(BuildContext context, Color backColor, String text) => Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          // width: double.maxFinite,
          alignment: Alignment.center,
          height: SizeConstants.size40,
          margin: REdgeInsets.only(
              left: SizeConstants.size24,
              right: SizeConstants.size24,
              bottom: SizeConstants.size20),
          padding: REdgeInsets.only(
              left: SizeConstants.size20,
              right: SizeConstants.size20,
              top: SizeConstants.size10,
              bottom: SizeConstants.size10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(SizeConstants.size6),
              color: backColor.withOpacity(0.7)),
          child: Text(
            text,
            style: FontStyle.helveticaRegularWhite_12,
          ),
        ),
      );

  Widget _map(BuildContext context) => SizedBox(
        height: SizeConstants.size270,
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _keyLatLng,
          zoomControlsEnabled: true,
          mapToolbarEnabled: false,
          onMapCreated: (GoogleMapController controller) {
            // _controller.complete(controller);
          },
          onTap: (LatLng latLng) {
            debugPrint("print............");
            _addDepartmentBottomSheet(context);
          },
          onCameraMove: (position) {},
          markers: Set<Marker>.of(_markers),
        ),
      );

  _addDepartmentBottomSheet(BuildContext context) {
    _directionControllerBottomSheet = _key.currentState!.showBottomSheet(
      (context) {
        return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: SizeConstants.size30,
                    height: SizeConstants.size30,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: ColorConstants.timeLineColor,
                            width: SizeConstants.size2)),
                    child: Icon(
                      Icons.close_rounded,
                      size: SizeConstants.size20,
                    ),
                  ).paddingRight(SizeConstants.size14).onTap(() {
                    locator<NavigationUtils>().pop(context);
                  }),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            "4 min",
                            style: FontStyle.helveticaMediumBlueColor_14,
                          ),
                          Text(
                            "(5 km)",
                            style: FontStyle.helveticaMediumTextColor_14,
                          ),
                        ],
                      ).paddingBottom(SizeConstants.size3),
                      Row(
                        children: [
                          Text(
                            Localization.of(context)!.iDNumber,
                            style: FontStyle.helveticaRegularTextColorDes_12,
                          ),
                          Text(
                            "#123 456",
                            style: FontStyle.helveticaRegularTextColor_12,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    width: SizeConstants.size30,
                    height: SizeConstants.size30,
                  )
                ],
              ),
              CustomButton(
                childView: Text(
                  Localization.of(context)!.finish,
                  style: FontStyle.helveticaRegularWhite_16,
                ),
                onButtonTap: () {
                  locator<NavigationUtils>().popUntil(
                      context, NavigationRouteConstants.routeAssetLocation);
                },
                buttonHeight: SizeConstants.size40,
                primaryColor: ColorConstants.primaryColor,
                primaryTextColor: ColorConstants.whiteColor,
                buttonShape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(SizeConstants.size18.r)),
                labelSize: SizeConstants.fontSizeSp18,
              ).paddingOnly(
                  bottom: SizeConstants.size20, top: SizeConstants.size30),
              CustomButtonSimple(
                childView: Text(
                  Localization.of(context)!.findCarKey,
                  style: FontStyle.helveticaRegularWhite_16,
                ),
                onButtonTap: () {},
                isRightImagePos: true,
                imageWidget: SvgPicture.asset(
                  ImageConstant.icFindCarKey,
                  width: SizeConstants.size30,
                  height: SizeConstants.size30,
                  fit: BoxFit.scaleDown,
                ).paddingRight(SizeConstants.size20),
                buttonHeight: SizeConstants.size40,
                primaryColor: ColorConstants.primaryColor,
                primaryTextColor: ColorConstants.whiteColor,
                buttonShape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(SizeConstants.size18.r)),
                labelSize: SizeConstants.fontSizeSp18,
              ).paddingBottom(SizeConstants.size15)
            ]).paddingOnly(
            left: SizeConstants.size20,
            right: SizeConstants.size20,
            top: SizeConstants.size15,
            bottom: SizeConstants.size15);
      },
      enableDrag: false,
      elevation: SizeConstants.size10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SizeConstants.size10),
      ),
      backgroundColor: ColorConstants.whiteColor,
    );
  }
}
