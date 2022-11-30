import 'package:flutter/material.dart';

import 'constants/color_constants.dart';

class ProgressDialogUtils {
  static final ProgressDialogUtils _instance = ProgressDialogUtils.internal();
  static bool isLoading = false;

  ProgressDialogUtils.internal();

  factory ProgressDialogUtils() => _instance;

  static BuildContext? _context;

  static void dismissProgressDialog() {
    if (isLoading) {
      Navigator.of(_context!).pop();
      isLoading = false;
    }
  }

  static void showProgressDialog(BuildContext? context) async {
    _context = context;
    isLoading = true;
    await showDialog(
        context: _context!,
        barrierDismissible: false,
        useRootNavigator: false,
        builder: (context) {
          return const SimpleDialog(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            children: <Widget>[
              Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      ColorConstants.primaryColor),
                ),
              )
            ],
          );
        });
  }
}
