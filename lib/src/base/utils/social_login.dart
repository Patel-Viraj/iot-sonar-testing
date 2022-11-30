import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../ui/signIn/model/res_social_login_model.dart';
import 'enum_utils.dart';

Future<SocialModel?> initGoogleLogin(BuildContext contex) async {
  SocialModel userModel;
  try {
    var _googleSignIn = GoogleSignIn();
    if (await _googleSignIn.isSignedIn()) {
      await _googleSignIn.disconnect();
    }
    var googleUser = await _googleSignIn.signIn();
    if (googleUser != null) {
      var googleAuth = await googleUser.authentication;
      debugPrint("before credential..........");

      var firstName = "", lastName = "";
      var fullName = googleUser.displayName ?? "";
      var splitName = googleUser.displayName!.split(" ") ?? [];
      if (splitName.isNotEmpty) {
        if (splitName[0].isNotEmpty) {
          firstName = splitName[0].trim();
        } else {
          firstName = fullName;
        }
        if (splitName.length >= 2 && splitName[1].isNotEmpty) {
          lastName = splitName[1].trim();
        }
      } else {
        firstName = fullName;
      }
      userModel = SocialModel(
          fullName: fullName,
          firstName: firstName,
          lastName: lastName,
          email: googleUser.email,
          id: googleUser.id,
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
          status: 200,
          platform: socialLogin.google);
      return userModel;
    } else {
      throw "error";
    }
  } on Exception catch (e) {
    if (e is PlatformException) {
      throw SocialModel(status: 500, error: e.message!);
    } else {
      throw SocialModel(status: 500, error: e.toString());
    }
  }
}

Future<SocialModel> initiateSignInWithApple(BuildContext context) async {
  if (await SignInWithApple.isAvailable()) {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ]);
      return SocialModel(
          id: credential.userIdentifier,
          email: credential.email ?? "",
          fullName: "${credential.givenName} ${credential.familyName}",
          firstName: credential.givenName ?? "",
          lastName: credential.familyName ?? "",
          platform: socialLogin.apple,
          accessToken: credential.authorizationCode,
          idToken: credential.identityToken,
          appleUserToken: credential.userIdentifier,
          status: 200);
    } catch (e) {
      if (e.toString().contains("SignInWithAppleAuthorizationError")) {
        int start = e.toString().indexOf("(") + 1;
        int end = e.toString().indexOf(",");
        if (e
            .toString()
            .substring(start, end)
            .contains("AuthorizationErrorCode.canceled")) {
        } else {
          throw SocialModel(error: "Not able to sign in.", status: 500);
        }
      } else {
        throw SocialModel(error: "Not able to sign in.", status: 500);
      }
      throw "Not able to sign in.";
    }
  } else {
    throw SocialModel(error: "Not able to sign in.", status: 500);
  }
}
