import 'package:flutter/material.dart';

import '../constants/app_constants.dart';
import '../localization/localization.dart';

class ValidationMethods {
  static bool isEmailValid(String value) =>
      (!RegExp(AppConstants.validEmailRegex).hasMatch(value)) ? true : false;

  static String? isValidEmail(BuildContext context, String value) {
    if (value.isEmpty) {
      return Localization.of(context)!.msgEnterAddress;
    } else if (ValidationMethods.isEmailValid(value)) {
      return Localization.of(context)!.msgEnterValidAddress;
    } else {
      return null;
    }
  }

  static String? isEmpty(BuildContext context, String value, String message) =>
      value.trim().isEmpty ? message : null;

  static String? isLessThan3Char(
          BuildContext context, String value, String message) =>
      value.trim().length < 3 ? message : null;
}
