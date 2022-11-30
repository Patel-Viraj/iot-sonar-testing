import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:front_office/src/base/utils/constants/app_constants.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../base/dependencyinjection/locator.dart';
import '../../../base/extensions/scaffold_extension.dart';
import '../../../base/utils/constants/color_constants.dart';
import '../../../base/utils/constants/font_style.dart';
import '../../../base/utils/constants/image_constant.dart';
import '../../../base/utils/constants/navigation_route_constants.dart';
import '../../../base/utils/constants/preference_key_constants.dart';
import '../../../base/utils/constants/size_constants.dart';
import '../../../base/utils/enum_utils.dart';
import '../../../base/utils/localization/localization.dart';
import '../../../base/utils/navigation.dart';
import '../../../base/utils/preference_utils.dart' as pref;
import '../../../base/utils/reusablemethods/reusable_ui_method.dart';

// ignore: must_be_immutable
class UserTypeSelection extends StatefulWidget {
  String? name;
  String? email;
  UserTypeSelection({super.key, this.name, this.email});
  @override
  State<StatefulWidget> createState() => _StateUserTypeSelection();
}

class _StateUserTypeSelection extends State<UserTypeSelection> {
  String name = "";
  String email = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      name = pref.getString(PreferenceKeyConstants.prefKeyName);
      email = pref.getString(PreferenceKeyConstants.prefKeyEmail);
      setState(() {});
    });
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
                      left: SizeConstants.size20,
                      right: SizeConstants.size20,
                      top: kToolbarHeight + SizeConstants.size36),
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(ImageConstant.icAuthBack),
                          fit: BoxFit.fill)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (name.isNotEmpty)
                        Text(
                          "Hi $name",
                          style: FontStyle.helveticaMediumTextColor_26,
                        ),
                      if (name.isNotEmpty)
                        SizedBox(
                          height: SizeConstants.size5,
                        ),
                      Text(
                        email,
                        style: FontStyle.helveticaRegularTextColor_16,
                      ).paddingOnly(bottom: SizeConstants.size30),
                      Flexible(
                          child: SingleChildScrollView(
                        child: Column(
                          children: [
                            _itemList(
                                firstWidget: _boxWidget(
                                        context,
                                        ColorConstants.inventoryColor,
                                        ColorConstants.inventorySecondaryColor,
                                        ImageConstant.icQrCode,
                                        Localization.of(context)!.qRCode,
                                        constraint,
                                        userType.qrCode)
                                    .paddingRight(SizeConstants.size24),
                                secondWidget: _boxWidget(
                                    context,
                                    ColorConstants.fenceColor,
                                    ColorConstants.fenceSecondoryColor,
                                    ImageConstant.icRoSearch,
                                    Localization.of(context)!.rOSearch,
                                    constraint,
                                    userType.roSearch)),
                            _itemList(
                                firstWidget: _boxWidget(
                                        context,
                                        ColorConstants
                                            .gatewayInstallerPrimaryColor,
                                        ColorConstants.textBlueColor,
                                        ImageConstant.icUnassignRo,
                                        Localization.of(context)!.unassignRO,
                                        constraint,
                                        userType.unassignRo)
                                    .paddingRight(SizeConstants.size24),
                                secondWidget: _boxWidget(
                                    context,
                                    ColorConstants.vendorFirstColor,
                                    ColorConstants.vendorSecondColor,
                                    ImageConstant.icAssignBeacon,
                                    Localization.of(context)!.assignBeacon,
                                    constraint,
                                    userType.assignBeacon)),
                            _itemList(
                                firstWidget: _boxWidget(
                                        context,
                                        ColorConstants.textColorDes,
                                        ColorConstants.qrBoxSecondColor,
                                        ImageConstant.icQrMagnify,
                                        Localization.of(context)!
                                            .qRCodeWithMagnifyingGlass,
                                        constraint,
                                        userType.qrWithMagnify)
                                    .paddingRight(SizeConstants.size24),
                                secondWidget: _boxWidget(
                                    context,
                                    ColorConstants.shipFirstColor,
                                    ColorConstants.shipSecondColor,
                                    ImageConstant.icDetectBeacon,
                                    Localization.of(context)!.detectBeacon,
                                    constraint,
                                    userType.detectBeacon)),
                          ],
                        ),
                      ))
                      // _boxWidget(
                      //     context,
                      //     ColorConstants.gatewayInstallerPrimaryColor,
                      //     ColorConstants.textBlueColor,
                      //     ImageConstant.icGatewayInstaller,
                      //     Localization.of(context)!.gatewayInstaller,
                      //     constraint,
                      //     userType.gatewayInstaller),
                    ],
                  ),
                );
              },
            ))
        .userSelectionScaffold(
            context: context,
            isShowLeading: false,
            title: Localization.of(context)!.dashboard);
  }

  Widget _itemList({Widget? firstWidget, Widget? secondWidget}) => Row(
        children: [firstWidget!, secondWidget!],
      ).paddingBottom(SizeConstants.size25);

  Widget _boxWidget(
          BuildContext context,
          Color firstColor,
          Color secondColor,
          String image,
          String title,
          BoxConstraints constraints,
          userType type) =>
      Container(
        width: (constraints.biggest.width -
                SizeConstants.size40.r -
                SizeConstants.size24) /
            2,
        height: SizeConstants.size160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SizeConstants.size20.r),
          gradient: LinearGradient(
              colors: [firstColor, secondColor],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              image,
              width: SizeConstants.size37,
              height: SizeConstants.size37,
            ).paddingBottom(SizeConstants.size26),
            Text(
              title,
              style: FontStyle.helveticaRegularWhite_14,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ).onTap(() {
        pref.setBool(PreferenceKeyConstants.prefKeyIsSelectUserType, true);
        if (type == userType.roSearch) {
          locator<NavigationUtils>().push(
              context, NavigationRouteConstants.routeRoSearch,
              arguments: {AppConstants.type: roSearchType.roSearch});
        } else if (type == userType.assignBeacon) {
          locator<NavigationUtils>().push(
              context, NavigationRouteConstants.routeRoSearch,
              arguments: {AppConstants.type: roSearchType.assignBeacon});
        } else if (type == userType.unassignRo) {
          locator<NavigationUtils>().push(
              context, NavigationRouteConstants.routeScanQR,
              arguments: {AppConstants.type: scanQRType.unassignRo});
        } else if (type == userType.detectBeacon) {
          locator<NavigationUtils>()
              .push(context, NavigationRouteConstants.routeDetectBeacon);
        }
        // else {
        //   locator<NavigationUtils>()
        //       .push(context, NavigationRouteConstants.routeGatewayInstaller);
        // }
      });
}
