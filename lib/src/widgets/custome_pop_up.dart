import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:front_office/src/base/utils/constants/font_style.dart';
import 'package:front_office/src/widgets/custom_text.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../base/dependencyinjection/locator.dart';
import '../base/provider/login_provider.dart';
import '../base/utils/constants/color_constants.dart';
import '../base/utils/constants/image_constant.dart';
import '../base/utils/constants/size_constants.dart';
import '../base/utils/localization/localization.dart';
import '../base/utils/navigation.dart';
import 'custom_button.dart';
import 'custom_button_simple.dart';
import 'custom_textfield.dart';

class CustomPopUp {
  static final CustomPopUp _instance = CustomPopUp.internal();
  static bool isLoading = false;

  CustomPopUp.internal();

  factory CustomPopUp() => _instance;

  static BuildContext? _context;

  static void dismissProgressDialog() {
    if (isLoading) {
      Navigator.of(_context!).pop();
      isLoading = false;
    }
  }

  static void showCustomeDialog(BuildContext? context,
      {String? title,
      String? okText,
      String? cancelText,
      String? subTitle,
      bool? isCancel = true,
      bool? isOk = true,
      VoidCallback? okAction,
      VoidCallback? cancelAction,
      Widget? image,
      Widget? closeIcon,
      Color backGroundColor = ColorConstants.whiteColor,
      Color? okButtonBackgroundColor,
      bool isPop = true,
      bool isCustomText = false,
      TextStyle? style}) async {
    _context = context;
    isLoading = true;
    await showDialog(
        context: _context!,
        barrierDismissible: false,
        useRootNavigator: false,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async => isPop,
            child: SimpleDialog(
              elevation: 0.0,
              // backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(SizeConstants.size10),
              ),
              alignment: Alignment.center,
              contentPadding: EdgeInsets.zero,
              insetPadding: REdgeInsets.only(
                  left: SizeConstants.size20, right: SizeConstants.size20),
              children: <Widget>[
                Container(
                  child: Container(
                    width: double.maxFinite,
                    padding: REdgeInsets.only(
                        left: SizeConstants.size20,
                        right: SizeConstants.size20,
                        top: image == null
                            ? SizeConstants.size30
                            : SizeConstants.size0,
                        bottom: SizeConstants.size30),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(SizeConstants.size10.r),
                        color: backGroundColor),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (closeIcon != null)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [closeIcon],
                          ),
                        if (image != null) image,
                        isCustomText
                            ? CustomText(
                                title: title,
                                subTitle: subTitle,
                                callback: () {},
                              )
                            : Text(
                                title!,
                                style: style ??
                                    FontStyle.helveticaRegularTextColor_12,
                                textAlign: TextAlign.center,
                              ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            if (isCancel!)
                              CustomButtonSimple(
                                childView: Text(
                                  cancelText ?? "",
                                  style: okButtonBackgroundColor == null
                                      ? FontStyle.helveticaRegularWhite_16
                                      : FontStyle.helveticaRegularGreen_16,
                                ),
                                buttonHeight: SizeConstants.size40,
                                buttonWidth: SizeConstants.size90,
                                onButtonTap: () {
                                  locator<NavigationUtils>().pop(context);
                                  cancelAction!();
                                },
                                backgroundColor: okButtonBackgroundColor,
                                primaryColor: ColorConstants.primaryColor,
                                primaryTextColor: ColorConstants.whiteColor,
                                buttonShape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        SizeConstants.size18.r)),
                                labelSize: SizeConstants.fontSizeSp18,
                              ).paddingTop(SizeConstants.size40.r),
                            if (isOk!)
                              CustomButton(
                                childView: Text(
                                  okText ?? "",
                                  style: FontStyle.helveticaRegularWhite_16,
                                ),
                                onButtonTap: () {
                                  locator<NavigationUtils>().pop(context);
                                  okAction!();
                                },
                                buttonHeight: SizeConstants.size40,
                                buttonWidth: SizeConstants.size90,
                                primaryColor: ColorConstants.primaryColor,
                                primaryTextColor: ColorConstants.whiteColor,
                                buttonShape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        SizeConstants.size18.r)),
                                labelSize: SizeConstants.fontSizeSp18,
                              ).paddingTop(SizeConstants.size40.r),
                          ],
                        )
                      ],
                    ),
                  ).onTap(() {}),
                )
              ],
            ),
          );
        });
  }

  static void showCustomeDialogTextField(BuildContext? context,
      {String? title,
      String? okText,
      String? cancelText,
      bool? isCancel = true,
      bool? isOk = true,
      VoidCallback? okAction,
      VoidCallback? cancelAction,
      Widget? image,
      Widget? closeIcon,
      Color backGroundColor = ColorConstants.whiteColor,
      Color okButtonBackgroundColor = ColorConstants.textColor,
      bool isPop = true,
      TextStyle? style}) async {
    _context = context;
    isLoading = true;
    await showDialog(
        context: _context!,
        barrierDismissible: false,
        useRootNavigator: false,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async => isPop,
            child: SimpleDialog(
              elevation: 0.0,
              // backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(SizeConstants.size10),
              ),
              alignment: Alignment.center,
              contentPadding: EdgeInsets.zero,
              insetPadding: REdgeInsets.only(
                  left: SizeConstants.size20, right: SizeConstants.size20),
              children: <Widget>[
                Container(
                  child: Container(
                    width: double.maxFinite,
                    padding: REdgeInsets.only(
                        left: SizeConstants.size20,
                        right: SizeConstants.size20,
                        top: image == null
                            ? SizeConstants.size30
                            : SizeConstants.size0,
                        bottom: SizeConstants.size30),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(SizeConstants.size10.r),
                        color: backGroundColor),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _getEmailTextField(context),
                        _errorTextAppleLogin(context),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            if (isCancel!)
                              CustomButton(
                                childView: Text(
                                  cancelText ?? "",
                                  style: FontStyle.helveticaRegularWhite_16,
                                ),
                                onButtonTap: () {
                                  locator<NavigationUtils>().pop(context);
                                  cancelAction!();
                                },
                                buttonHeight: SizeConstants.size40,
                                buttonWidth: SizeConstants.size90,
                                primaryColor: ColorConstants.primaryColor,
                                primaryTextColor: ColorConstants.whiteColor,
                                buttonShape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        SizeConstants.size18.r)),
                                labelSize: SizeConstants.fontSizeSp18,
                              ).paddingTop(SizeConstants.size40.r),
                            if (isOk!)
                              CustomButtonSimple(
                                childView: Text(
                                  okText ?? "",
                                  style: FontStyle.helveticaRegularWhite_16,
                                ),
                                buttonHeight: SizeConstants.size40,
                                buttonWidth: SizeConstants.size90,
                                onButtonTap: () {
                                  locator<NavigationUtils>().pop(context);
                                  okAction!();
                                },
                                backgroundColor: okButtonBackgroundColor,
                                primaryColor: ColorConstants.primaryColor,
                                primaryTextColor: ColorConstants.whiteColor,
                                buttonShape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        SizeConstants.size18.r)),
                                labelSize: SizeConstants.fontSizeSp18,
                              ).paddingTop(SizeConstants.size40.r)
                          ],
                        )
                      ],
                    ),
                  ).onTap(() {}),
                )
              ],
            ),
          );
        });
  }

  static Widget _getEmailTextField(BuildContext context) =>
      Consumer<LoginProvider>(
          builder: (context, loginProvider, _) => CustomTextField(
                controller: loginProvider.emailController,
                focusNode: loginProvider.emailFocus,
                onFieldSubmitted: (_) {
                  loginProvider.emailFocus.unfocus();
                },
                valueTextStyle: FontStyle.helveticaRegularTextFieldColor_16,
                textInputType: TextInputType.emailAddress,
                hint: Localization.of(context)!.email,
                textInputAction: TextInputAction.done,
                prefixIcon: ImageConstant.icMail,
                onChanged: (value) {
                  // loginProvider!.changeEmail(context: context, mText: value);
                },
                label: "",
                contentSpace: REdgeInsets.only(
                    left: SizeConstants.size27,
                    right: SizeConstants.size15,
                    top: SizeConstants.size18,
                    bottom: SizeConstants.size18),
              ).paddingOnly(
                  left: SizeConstants.size20.r,
                  right: SizeConstants.size20.r,
                  top: SizeConstants.size27.r));

  static Widget _errorTextAppleLogin(BuildContext context) =>
      Consumer<LoginProvider>(
          builder: (context, loginProvider, _) =>
              loginProvider.isEmailErrorApple
                  ? _errorText(context, loginProvider.emailErrorMsg ?? "")
                  : Container());

  static Widget _errorText(BuildContext context, String msg) => Row(
        children: [
          Expanded(
            child: RPadding(
              padding: REdgeInsets.only(
                  left: SizeConstants.size59,
                  right: SizeConstants.size59,
                  top: SizeConstants.size10),
              child: Text(
                msg,
                style: FontStyle.helveticaRegularRedColor_12,
                overflow: TextOverflow.visible,
              ),
            ),
          )
        ],
      );

  static void showCustomeBLEDialog(BuildContext? context,
      {String? serialNumber,
      String? uuIdNumber,
      String? batteryPercent,
      VoidCallback? cancelAction,
      Color backGroundColor = ColorConstants.whiteColor,
      TextStyle? style}) async {
    _context = context;
    isLoading = true;
    await showDialog(
        context: _context!,
        barrierDismissible: false,
        useRootNavigator: false,
        builder: (context) {
          return SimpleDialog(
            elevation: 0.0,
            // backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(SizeConstants.size10),
            ),
            alignment: Alignment.center,
            contentPadding: EdgeInsets.zero,
            insetPadding: REdgeInsets.only(
                left: SizeConstants.size20, right: SizeConstants.size20),
            children: <Widget>[
              Container(
                child: Container(
                  width: double.maxFinite,
                  padding: REdgeInsets.only(
                      left: SizeConstants.size20,
                      right: SizeConstants.size8,
                      top: SizeConstants.size8,
                      bottom: SizeConstants.size20),
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(SizeConstants.size10.r),
                      color: backGroundColor),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SvgPicture.asset(
                        ImageConstant.icCancel,
                        color: ColorConstants.textFieldLineColor,
                      ).onTap(() {
                        locator<NavigationUtils>().pop(context);
                      }),
                      Row(
                        children: [
                          Image.asset(
                            ImageConstant.icBleCircle,
                            width: SizeConstants.size70,
                            height: SizeConstants.size70,
                          ).paddingRight(SizeConstants.size20.r),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: REdgeInsets.only(
                                      top: SizeConstants.size5,
                                      bottom: SizeConstants.size5,
                                      left: SizeConstants.size7,
                                      right: SizeConstants.size7,
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            SizeConstants.size10),
                                        color: ColorConstants.batteryColor),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                            ImageConstant.icBattery),
                                        Text(
                                          batteryPercent ?? "",
                                          style: FontStyle
                                              .helveticaRegularTextColor_10,
                                        ).paddingLeft(SizeConstants.size7)
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: REdgeInsets.only(
                                        left: SizeConstants.size10),
                                    padding: REdgeInsets.only(
                                      top: SizeConstants.size5,
                                      bottom: SizeConstants.size5,
                                      left: SizeConstants.size7,
                                      right: SizeConstants.size7,
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            SizeConstants.size10),
                                        color: ColorConstants.nearByYouColor),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                            ImageConstant.icLocation),
                                        Text(
                                          Localization.of(context)!.nearByYou,
                                          style: FontStyle
                                              .helveticaRegularTextColor_10,
                                        ).paddingLeft(SizeConstants.size7)
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _titleSubtitleWidget(
                                          context,
                                          Localization.of(context)!
                                              .serialNumber,
                                          serialNumber ?? "",
                                          subTitleStyle: FontStyle
                                              .helveticaMediumTextColor_12)
                                      .paddingRight(SizeConstants.size30),
                                  _titleSubtitleWidget(
                                      context,
                                      Localization.of(context)!.uuIdNumber,
                                      uuIdNumber ?? "",
                                      subTitleStyle:
                                          FontStyle.helveticaMediumTextColor_12)
                                ],
                              ).paddingTop(SizeConstants.size14)
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ).onTap(() {}),
              )
            ],
          );
        });
  }

  static Widget _titleSubtitleWidget(
          BuildContext context, String title, String subTitle,
          {TextStyle? titleStyle, TextStyle? subTitleStyle}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: titleStyle ?? FontStyle.helveticaRegularTextColorDes_12,
          ).paddingBottom(SizeConstants.size5),
          Text(
            subTitle,
            style: subTitleStyle ?? FontStyle.helveticaMediumTextColor_14,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      );
}
