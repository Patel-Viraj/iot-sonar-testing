// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// import '../../ui/auth/signIn/model/res_social_login_model.dart';
// import '../dependencyinjection/locator.dart';
// import '../utils/constants/app_constants.dart';
// import '../utils/constants/navigation_route_constants.dart';
// import '../utils/constants/preference_key_constants.dart';
// import '../utils/dialog_utils.dart';
// import '../utils/enum_utils.dart';
// import '../utils/localization/localization.dart';
// import '../utils/navigation.dart';
// import '../utils/preference_utils.dart';
// import '../utils/reusablemethods/validation_methods.dart';
//
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:front_office/src/base/utils/preference_utils.dart';

import '../../ui/signIn/model/res_social_login_model.dart';
import '../dependencyinjection/locator.dart';
import '../utils/constants/app_constants.dart';
import '../utils/constants/navigation_route_constants.dart';
import '../utils/constants/preference_key_constants.dart';
import '../utils/dialog_utils.dart';
import '../utils/enum_utils.dart';
import '../utils/localization/localization.dart';
import '../utils/navigation.dart';
import '../utils/reusablemethods/validation_methods.dart';

class LoginProvider extends ChangeNotifier {
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isEmailError = false;
  bool _isEmailErrorApple = false;
  bool _isLogin = true;
  bool _isLoginClick = false;
  bool _isObscurePassword = false;
  bool _isSelected = false;
  String? _emailErrorMsg = "";

  bool get isEmailError => _isEmailError;
  bool get isEmailErrorApple => _isEmailErrorApple;
  String? get emailErrorMsg => _emailErrorMsg;
  bool? get isLoginClick => _isLoginClick;
  bool get isObscurePassword => _isObscurePassword;
  bool get isSelected => _isSelected;

  void changeObscure() {
    _isObscurePassword = !_isObscurePassword;
    notifyListeners();
  }

  void changeCheckSelected() {
    _isSelected = !_isSelected;
    notifyListeners();
  }

  void setLoginClick(bool value) {
    _isLoginClick = value;
    notifyListeners();
  }

  void changeEmail(
      {required BuildContext context, required String? mText}) async {
    String? msg = ValidationMethods.isValidEmail(context, mText!);
    debugPrint("msg......$msg");
    _isEmailError = msg == null ? false : true;
    _emailErrorMsg = msg;
    _isLogin = !_isEmailError;
    notifyListeners();
  }

  void changeEmailApple(
      {required BuildContext context, required String? mText}) async {
    String? msg = ValidationMethods.isValidEmail(context, mText!);
    _isEmailErrorApple = msg == null ? false : true;
    _emailErrorMsg = msg;
    _isLogin = !_isEmailErrorApple;
    notifyListeners();
  }

  void clear() {
    _isEmailError = false;
    _isLoginClick = false;
    _isEmailErrorApple = false;
    _emailErrorMsg = "";
    emailController.text = "";
    // notifyListeners();
  }

  void onLoginButtonTap(BuildContext context, socialLogin type,
      {SocialModel? socialModel}) async {
    if (type == socialLogin.normal) {
      changeEmail(context: context, mText: emailController.text.trim());
      if (_isLogin) {
        if (await _checkEmailExist(context, emailController.text.trim())) {
          debugPrint("initiateSignInWithApple onLoginButtonTap...........");
          setLoginClick(true);
          FocusScope.of(context).unfocus();
          _signInWithEmailAndLink(context, type);
        }
      }
    } else if (type == socialLogin.apple) {
      if (await _checkEmailExist(context, socialModel?.email ?? "")) {
        debugPrint("initiateSignInWithApple onLoginButtonTap...........");
        final credential = OAuthProvider('apple.com').credential(
          idToken: socialModel?.idToken,
          accessToken: socialModel?.accessToken,
        );
        await FirebaseAuth.instance.signInWithCredential(credential);
        setData(socialModel?.fullName ?? "", socialModel?.email ?? "");
        // ignore: use_build_context_synchronously
        locator<NavigationUtils>().pushAndRemoveUntil(
            context, NavigationRouteConstants.routeUserSelection);
      }
    } else {
      if (await _checkEmailExist(context, socialModel?.email ?? "")) {
        AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: socialModel!.accessToken,
          idToken: socialModel.idToken,
        );
        debugPrint("after credential..........$credential");
        UserCredential authResult =
            await FirebaseAuth.instance.signInWithCredential(credential);
        User? user = authResult.user;
        setData(user?.displayName ?? "", user?.email ?? "");
        // ignore: use_build_context_synchronously
        locator<NavigationUtils>().pushAndRemoveUntil(
            context, NavigationRouteConstants.routeUserSelection);
      }
    }
  }

  setData(String name, String email) {
    setBool(PreferenceKeyConstants.prefKeyIsLogin, true);
    setString(PreferenceKeyConstants.prefKeyName, name);
    setString(PreferenceKeyConstants.prefKeyEmail, email);
  }

  void onAppleLoginVerifyEmail(BuildContext context,
      {SocialModel? socialModel}) async {
    changeEmailApple(context: context, mText: emailController.text.trim());
    if (_isLogin) {
      FocusScope.of(context).unfocus();
      if (await _checkEmailExist(context, emailController.text.trim())) {
        _signInWithEmailAndLink(context, socialLogin.apple);
      }
    }
  }

  Future<void> _signInWithEmailAndLink(
      BuildContext context, socialLogin type) async {
    FirebaseAuth.instance
        .sendSignInLinkToEmail(
            email: emailController.text.trim(),
            actionCodeSettings: ActionCodeSettings(
              url: AppConstants.emailLoginLink,
              handleCodeInApp: true,
              iOSBundleId: AppConstants.iOSBundleId,
              androidPackageName: AppConstants.androidPackageId,
              androidInstallApp: true,
              androidMinimumVersion: "12",
            ))
        .catchError((onError) {
      debugPrint('Error sending email verification $onError');
      displayToast(onError.toString());
      setLoginClick(false);
    }).then((value) {
      setString(PreferenceKeyConstants.prefKeyEnteredEmail,
          emailController.text.trim());
      setString(PreferenceKeyConstants.prefKeyLoginType,
          type == socialLogin.apple ? "A" : "N");
      displayToast(Localization.of(context)!.emailVerificationSentSuccessfully);
      setLoginClick(false);
    });
  }

  handleLink(BuildContext context, Uri emailLink) async {
    // Confirm the link is a sign-in with email link.
    debugPrint(
        'handleLink!!!!!!!${FirebaseAuth.instance.isSignInWithEmailLink(emailLink.toString())}');
    if (FirebaseAuth.instance.isSignInWithEmailLink(emailLink.toString())) {
      try {
        final userCredential = await FirebaseAuth.instance.signInWithEmailLink(
            email: getString(PreferenceKeyConstants.prefKeyEnteredEmail),
            emailLink: emailLink.toString());
        debugPrint(
            'Successfully signed in with email link!!!!!!!!!${userCredential.user?.displayName}.........${userCredential.user?.email}');
        setBool(PreferenceKeyConstants.prefKeyIsLogin, true);
        setString(PreferenceKeyConstants.prefKeyName,
            userCredential.user?.displayName ?? "");
        setString(PreferenceKeyConstants.prefKeyEmail,
            userCredential.user?.email ?? "");
        // ignore: use_build_context_synchronously
        locator<NavigationUtils>().pushAndRemoveUntil(
            context, NavigationRouteConstants.routeUserSelection,
            arguments: {
              AppConstants.name: userCredential.user?.displayName,
              AppConstants.email: userCredential.user?.email
            });
      } catch (error) {
        debugPrint('Error signed in with email link!......$error');
        displayToast(error.toString());
      }
    }
  }

  Future<bool> _checkEmailExist(BuildContext context, String email) async {
    try {
      final list =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      debugPrint("list..........$list");
      if (list.isNotEmpty) {
        return true;
      } else {
        // ignore: use_build_context_synchronously
        displayToast(Localization.of(context)!.emailDoesNotExist);
        return false;
      }
    } catch (error) {
      debugPrint("error..........$error");
      displayToast(Localization.of(context)!.emailDoesNotExist);
      return false;
    }
  }
}
