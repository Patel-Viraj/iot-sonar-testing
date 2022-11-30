import 'dart:io';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../../../base/extensions/scaffold_extension.dart';
import '../../../base/extensions/size_extension.dart';
import '../../../base/provider/login_provider.dart';
import '../../../base/utils/constants/color_constants.dart';
import '../../../base/utils/constants/font_style.dart';
import '../../../base/utils/constants/image_constant.dart';
import '../../../base/utils/constants/size_constants.dart';
import '../../../base/utils/dialog_utils.dart';
import '../../../base/utils/enum_utils.dart';
import '../../../base/utils/localization/localization.dart';
import '../../../base/utils/progress_dialog.dart';
import '../../../base/utils/reusablemethods/reusable_ui_method.dart';
import '../../../base/utils/social_login.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_textfield.dart';
import '../../../widgets/custome_pop_up.dart';
import '../model/res_social_login_model.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});
  @override
  State<StatefulWidget> createState() => _StateSignIn();
}

class _StateSignIn extends State<SignIn> with WidgetsBindingObserver {
  final TextEditingController emailController = TextEditingController();
  final FocusNode emailFocus = FocusNode();
  LoginProvider? loginProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    loginProvider = context.read<LoginProvider>();
    initDyanamicLink();
  }

  @override
  void dispose() {
    loginProvider!.clear();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  initDyanamicLink() async {
    if (Platform.isIOS) {
      FirebaseDynamicLinks.instance.onLink
          .listen((PendingDynamicLinkData dynamicLink) async {
        debugPrint('FirebaseDynamicLinks onLink..........$dynamicLink');
        if (dynamicLink.link != null) {
          loginProvider!.handleLink(context, dynamicLink.link);
        }
      }).onError((e) {
        debugPrint('onLinkError');
        debugPrint(e.message);
      });
    }
    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    debugPrint('FirebaseDynamicLinks..........$data');
    if (data?.link != null) {
      // ignore: use_build_context_synchronously
      loginProvider!.handleLink(context, data!.link);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    debugPrint('didChangeAppLifecycleState..........$state');
    if (Platform.isIOS && state == AppLifecycleState.resumed) {
      // initDyanamicLink();
    }
  }

  @override
  Widget build(BuildContext context) {
    setScreenSize(context);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      // statusBarBrightness: Brightness.light,
    ));
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          height: SizeConstants.size1.sh,
          width: SizeConstants.size1.sw,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(ImageConstant.icAuthBack),
                  fit: BoxFit.fill)),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                locImage(),
                textSignIn(),
                textDes(),
                _getEmailTextField(context),
                _errorTextNormalLogin(context),
                _loginButton(context),
                _circularProgress(context),
                _orWidget(context),
                _googleLogin(context),
                _appleLogin(context),
              ],
            ),
          ),
        )).authContainerScaffold(context: context);
  }

  Widget _errorTextNormalLogin(BuildContext context) => Consumer<LoginProvider>(
      builder: (context, loginProvider, _) => loginProvider.isEmailError
          ? _errorText(context, loginProvider.emailErrorMsg ?? "")
          : Container());

  Widget _errorText(BuildContext context, String msg) => Row(
        children: [
          Expanded(
            child: RPadding(
              padding: REdgeInsets.only(
                  left: SizeConstants.size20,
                  right: SizeConstants.size20,
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

  Widget locImage() => Padding(
        padding: REdgeInsets.only(
            top: SizeConstants.size43 + context.mq.padding.top,
            left: SizeConstants.size20),
        child: Image.asset(
          ImageConstant.icAuthLocation,
          width: SizeConstants.size50.r,
          height: SizeConstants.size58.r,
        ),
      );

  Widget textSignIn() => Text(
        Localization.of(context)!.signIn,
        style: FontStyle.helveticaRegularTextColor_32,
      ).paddingOnly(left: SizeConstants.size20.r, top: SizeConstants.size60.r);

  Widget textDes() => Text(
        Localization.of(context)!.enterCredentials,
        style: FontStyle.helveticaRegularTextColorDes_16,
      ).paddingOnly(
          left: SizeConstants.size20.r,
          right: SizeConstants.size20.r,
          top: SizeConstants.size16.r);

  Widget _getEmailTextField(BuildContext context) => Consumer<LoginProvider>(
      builder: (context, loginProvider, _) => CustomTextField(
            controller: loginProvider.emailController,
            focusNode: loginProvider.emailFocus,
            onFieldSubmitted: (_) {
              loginProvider.emailFocus.unfocus();
            },
            valueTextStyle: FontStyle.helveticaRegularTextFieldColor_16,
            textInputType: TextInputType.emailAddress,
            hint: Localization.of(context)!.userNameCaps,
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

  Widget _loginButton(BuildContext context) => Consumer<LoginProvider>(
      builder: (context, loginProvider, _) => loginProvider.isLoginClick ??
              false
          ? Container()
          : CustomButton(
              childView: Text(
                Localization.of(context)!.login,
                style: FontStyle.helveticaRegularWhite_16,
              ),
              onButtonTap: () {
                loginProvider.onLoginButtonTap(context, socialLogin.normal);
              },
              primaryColor: ColorConstants.primaryColor,
              primaryTextColor: ColorConstants.whiteColor,
              buttonShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(SizeConstants.size18.r)),
              labelSize: SizeConstants.fontSizeSp18,
            ).paddingOnly(
              left: SizeConstants.size20.r,
              right: SizeConstants.size20.r,
              top: SizeConstants.size30.r));

  Widget _circularProgress(BuildContext context) => Consumer<LoginProvider>(
      builder: (context, loginProvider, _) =>
          !(loginProvider.isLoginClick ?? true)
              ? Container()
              : loginProvider.isEmailError
                  ? Container()
                  : Center(
                      child: Container(
                        width: SizeConstants.size56.r,
                        height: SizeConstants.size56.r,
                        margin: REdgeInsets.only(
                            left: SizeConstants.size20,
                            right: SizeConstants.size20,
                            top: SizeConstants.size30),
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(colors: [
                              ColorConstants.secondaryColor,
                              ColorConstants.primaryColor,
                            ],
                                // begin: FractionalOffset(0.0, 0.0),
                                // end: FractionalOffset(1.0, 0.0),
                                stops: [
                                  0.0,
                                  1.0
                                ], tileMode: TileMode.clamp),
                            borderRadius:
                                BorderRadius.circular(SizeConstants.size80)),
                        child: const Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                ColorConstants.whiteColor),
                          ),
                        ),
                      ),
                    ));

  Widget _orWidget(BuildContext context) => Consumer<LoginProvider>(
      builder: (context, loginProvider, _) =>
          loginProvider.isLoginClick ?? false
              ? Container()
              : Flexible(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: SizeConstants.size2.r,
                        width: SizeConstants.size125.r,
                        color: ColorConstants.textFieldLineColor,
                      ),
                      Text(
                        Localization.of(context)!.or,
                        style: FontStyle.robotoRegularTextFieldColor_14,
                      ),
                      Container(
                        height: SizeConstants.size2.r,
                        width: SizeConstants.size125.r,
                        color: ColorConstants.textFieldLineColor,
                      )
                    ],
                  ).paddingOnly(
                      left: SizeConstants.size20.r,
                      right: SizeConstants.size20.r,
                      top: SizeConstants.size34.r),
                ));

  Widget _googleLogin(BuildContext context) => Consumer<LoginProvider>(
      builder: (context, loginProvider, _) => loginProvider.isLoginClick ??
              false
          ? Container()
          : Container(
              height: SizeConstants.size50.r,
              margin: REdgeInsets.only(
                  left: SizeConstants.size20,
                  right: SizeConstants.size20,
                  top: SizeConstants.size34),
              decoration: BoxDecoration(
                  color: ColorConstants.whiteColor,
                  borderRadius: BorderRadius.circular(SizeConstants.size80.r),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: SizeConstants.size1,
                        spreadRadius: SizeConstants.size1,
                        offset: const Offset(0, 3),
                        color: ColorConstants.lineColor)
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    ImageConstant.icGoogle,
                    width: SizeConstants.size24.r,
                    height: SizeConstants.size24.r,
                    fit: BoxFit.scaleDown,
                  ),
                  Text(
                    Localization.of(context)!.loginWithGoogle,
                    style: FontStyle.helveticaMediumTextFieldColor_16,
                  ).paddingLeft(SizeConstants.size20)
                ],
              ),
            ).onTap(() async {
              ProgressDialogUtils.showProgressDialog(context);
              await initGoogleLogin(context).then((value) {
                ProgressDialogUtils.dismissProgressDialog();
                loginProvider.onLoginButtonTap(context, socialLogin.google,
                    socialModel: value);
              }).catchError((dynamic e) {
                ProgressDialogUtils.dismissProgressDialog();
                if (e is SocialModel) {
                  debugPrint("${e.error}");
                  showAlertDialog(context, e.error!);
                }
              });
            }));

  Widget _appleLogin(BuildContext context) => Consumer<LoginProvider>(
      builder: (context, loginProvider, _) => loginProvider.isLoginClick ??
              false
          ? Container()
          : Container(
              height: SizeConstants.size50.r,
              margin: REdgeInsets.only(
                  left: SizeConstants.size20,
                  right: SizeConstants.size20,
                  top: SizeConstants.size20,
                  bottom: SizeConstants.size30),
              decoration: BoxDecoration(
                  color: ColorConstants.whiteColor,
                  borderRadius: BorderRadius.circular(SizeConstants.size80.r),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: SizeConstants.size1,
                        spreadRadius: SizeConstants.size1,
                        offset: const Offset(0, 3),
                        color: ColorConstants.lineColor)
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    ImageConstant.icApple,
                    width: SizeConstants.size24.r,
                    height: SizeConstants.size24.r,
                    fit: BoxFit.scaleDown,
                  ),
                  Text(
                    Localization.of(context)!.loginWithApple,
                    style: FontStyle.helveticaMediumTextFieldColor_16,
                  ).paddingLeft(SizeConstants.size20)
                ],
              ),
            ).onTap(() async {
              ProgressDialogUtils.showProgressDialog(context);
              await initiateSignInWithApple(context).then((value) {
                ProgressDialogUtils.dismissProgressDialog();
                if (value.email?.isNotEmpty ?? false) {
                  debugPrint("initiateSignInWithApple if...........");
                  // loginProvider.onLoginButtonTap(context, socialLogin.apple,
                  //     socialModel: value);
                } else {
                  debugPrint("initiateSignInWithApple else............");
                  CustomPopUp.showCustomeDialogTextField(context,
                      title: "",
                      okText: Localization.of(context)!.ok,
                      cancelText: Localization.of(context)!.cancel,
                      okAction: () {
                    // loginProvider.setLoginClick();
                    loginProvider.onAppleLoginVerifyEmail(context,
                        socialModel: value);
                  }, cancelAction: () {
                    loginProvider.clear();
                  },
                      isCancel: true,
                      isOk: true,
                      isPop: false,
                      image: SvgPicture.asset(
                        ImageConstant.icCheckGreen,
                      ).paddingOnly(
                          bottom: SizeConstants.size24,
                          top: SizeConstants.size30));
                }
              }).catchError((dynamic e) {
                ProgressDialogUtils.dismissProgressDialog();
                if (e is SocialModel) {
                  showAlertDialog(context, e.error!);
                }
              });
            }));
}
