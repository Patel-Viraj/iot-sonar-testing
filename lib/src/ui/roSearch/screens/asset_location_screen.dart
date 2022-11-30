import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:front_office/src/base/utils/navigation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../base/dependencyinjection/locator.dart';
import '../../../base/extensions/scaffold_extension.dart';
import '../../../base/utils/constants/color_constants.dart';
import '../../../base/utils/constants/font_style.dart';
import '../../../base/utils/constants/image_constant.dart';
import '../../../base/utils/constants/navigation_route_constants.dart';
import '../../../base/utils/constants/size_constants.dart';
import '../../../base/utils/enum_utils.dart';
import '../../../base/utils/localization/localization.dart';
import '../../../base/utils/reusablemethods/reusable_ui_method.dart';
import '../../../widgets/custom_button.dart';

// ignore: must_be_immutable
class AssetLocation extends StatefulWidget {
  roSearchType? mType;
  AssetLocation({super.key, this.mType});
  @override
  State<StatefulWidget> createState() => _AssetLocationState();
}

class _AssetLocationState extends State<AssetLocation> {
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
  final CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();
  late PersistentBottomSheetController _directionControllerBottomSheet;

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
          onTap: () {
            _showInfoWindow(_keyLatLng.target, false);
          }));
      _markers.add(Marker(
          icon: customIcon,
          markerId: const MarkerId('2'),
          position: _carLatLng.target,
          onTap: () {
            _showInfoWindow(_carLatLng.target, true);
          }));
      setState(() {});
    });
  }

  void _showInfoWindow(LatLng target, bool isCar) {
    debugPrint("show window.........");
    _customInfoWindowController.addInfoWindow!(
        Container(
          padding: REdgeInsets.all(SizeConstants.size12),
          decoration: BoxDecoration(
              color: ColorConstants.whiteColor,
              borderRadius: BorderRadius.circular(SizeConstants.size6)),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: SizeConstants.size22,
                    height: SizeConstants.size22,
                    margin: REdgeInsets.only(right: SizeConstants.size12),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorConstants.timeLineBorderColor),
                    child: SvgPicture.asset(
                      ImageConstant.icKeyLocation,
                      width: SizeConstants.size12,
                      height: SizeConstants.size9,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isCar
                            ? Localization.of(context)!.carDetails
                            : Localization.of(context)!.keyDetails,
                        style: FontStyle.helveticaMediumTextColor_12,
                      ).paddingBottom(SizeConstants.size5.r),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            ImageConstant.icLocation,
                            width: SizeConstants.size7,
                            height: SizeConstants.size9,
                            fit: BoxFit.scaleDown,
                          ).paddingRight(SizeConstants.size4),
                          Text(
                            "0.5 km",
                            style: FontStyle.helveticaRegularTextColor_10,
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
              Container(
                margin: REdgeInsets.only(
                    top: SizeConstants.size9, bottom: SizeConstants.size7),
                height: SizeConstants.size1,
                width: 120,
                color: ColorConstants.timeLineBorderColor,
              ),
              Row(
                children: [
                  Text(
                    Localization.of(context)!.iDNumber,
                    style: FontStyle.helveticaRegularTextColorDes_10,
                  ),
                  Text(
                    "#123 456",
                    style: FontStyle.helveticaRegularTextColor_10,
                  ),
                ],
              )
            ],
          ),
        ),
        target);
  }

  @override
  Widget build(BuildContext context) {
    setScreenSize(context);
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: LayoutBuilder(
          builder: (context, constraint) {
            return Container(
                height: SizeConstants.size1.sh,
                width: SizeConstants.size1.sw,
                padding: REdgeInsets.only(
                    top: kToolbarHeight + SizeConstants.size36),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(ImageConstant.icAuthBack),
                        fit: BoxFit.fill)),
                child: Stack(
                  children: [
                    _map(context),
                    CustomInfoWindow(
                      controller: _customInfoWindowController,
                      height: SizeConstants.size90,
                      width: SizeConstants.size150,
                      offset: 50,
                    ),
                  ],
                ));
          },
        )).userSelectionScaffold(
        key: _key,
        context: context,
        isShowLeading: true,
        title: Localization.of(context)!.assetLocation,
        backClick: () {
          locator<NavigationUtils>().pop(context);
        });
  }

  Widget _map(BuildContext context) => GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _keyLatLng,
        zoomControlsEnabled: true,
        mapToolbarEnabled: false,
        onMapCreated: (GoogleMapController controller) {
          // _controller.complete(controller);
          _customInfoWindowController.googleMapController = controller;
        },
        onTap: (LatLng latLng) {
          _customInfoWindowController.hideInfoWindow!();
          _addDepartmentBottomSheet(context);
        },
        onCameraMove: (position) {
          _customInfoWindowController.onCameraMove!();
        },
        markers: Set<Marker>.of(_markers),
      );

  _addDepartmentBottomSheet(BuildContext context) {
    _directionControllerBottomSheet = _key.currentState!.showBottomSheet(
      (context) {
        return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                  child: Container(
                alignment: Alignment.center,
                height: SizeConstants.size2,
                width: SizeConstants.size60,
                color: ColorConstants.textFieldLineColor,
                margin: REdgeInsets.only(
                    top: SizeConstants.size12, bottom: SizeConstants.size28),
              )),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: SizeConstants.size36,
                    height: SizeConstants.size36,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorConstants.carBackColor),
                    child: SvgPicture.asset(
                      ImageConstant.icCar,
                      width: SizeConstants.size18,
                      height: SizeConstants.size14,
                      fit: BoxFit.scaleDown,
                    ),
                  ).paddingRight(SizeConstants.size14),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                  const Spacer(),
                  SvgPicture.asset(
                    ImageConstant.icLocation,
                    width: SizeConstants.size9.r,
                    height: SizeConstants.size12.r,
                  ).paddingOnly(
                      right: SizeConstants.size5, top: SizeConstants.size1),
                  Text(
                    "5 Km",
                    style: FontStyle.helveticaRegularTextColor_12,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              CustomButton(
                childView: Text(
                  Localization.of(context)!.startDirections,
                  style: FontStyle.helveticaRegularWhite_16,
                ),
                onButtonTap: () {
                  locator<NavigationUtils>()
                      .push(context, NavigationRouteConstants.routeARMapScreen);
                },
                imageWidget: SvgPicture.asset(
                  ImageConstant.icTrafficSign,
                  width: SizeConstants.size20,
                  height: SizeConstants.size20,
                  fit: BoxFit.scaleDown,
                ).paddingRight(SizeConstants.size10),
                buttonHeight: SizeConstants.size40,
                primaryColor: ColorConstants.primaryColor,
                primaryTextColor: ColorConstants.whiteColor,
                buttonShape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(SizeConstants.size18.r)),
                labelSize: SizeConstants.fontSizeSp18,
              ).paddingOnly(
                  bottom: SizeConstants.size50, top: SizeConstants.size30)
            ]).paddingOnly(
            left: SizeConstants.size20, right: SizeConstants.size20);
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
