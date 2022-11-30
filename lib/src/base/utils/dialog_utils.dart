import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import 'constants/color_constants.dart';
import 'constants/size_constants.dart';
import 'localization/localization.dart';

Future<bool?> displayToast(String message) {
  return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: ColorConstants.secondaryColor,
      textColor: ColorConstants.whiteColor,
      fontSize: SizeConstants.fontSizeSp14);
}

Future<bool?> displayToastCenter(String message) {
  return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 2,
      backgroundColor: ColorConstants.greenPopUpColor,
      textColor: ColorConstants.whiteColor,
      fontSize: SizeConstants.fontSizeSp14);
}

void showOkCancelAlertDialog({
  BuildContext? context,
  String? message,
  String? okButtonTitle,
  String? cancelButtonTitle,
  Function? cancelButtonAction,
  Function? okButtonAction,
  bool isCancelEnable = true,
}) {
  showDialog(
    barrierDismissible: isCancelEnable,
    context: context!,
    useRootNavigator: false,
    builder: (context) {
      if (Platform.isIOS) {
        return _showOkCancelCupertinoAlertDialog(
            context,
            message,
            okButtonTitle,
            cancelButtonTitle,
            okButtonAction,
            isCancelEnable,
            cancelButtonAction);
      } else {
        return _showOkCancelMaterialAlertDialog(
            context,
            message!,
            okButtonTitle!,
            cancelButtonTitle!,
            okButtonAction!,
            isCancelEnable,
            cancelButtonAction!);
      }
    },
  );
}

void showAlertDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (context) {
      if (Platform.isIOS) {
        return _showCupertinoAlertDialog(context, message);
      } else {
        return _showMaterialAlertDialog(context, message);
      }
    },
  );
}

CupertinoAlertDialog _showCupertinoAlertDialog(
    BuildContext context, String message) {
  return CupertinoAlertDialog(
    title: Text(Localization.of(context)!.appName),
    content: Text(message),
    actions: _actions(context),
  );
}

AlertDialog _showMaterialAlertDialog(BuildContext context, String message) {
  return AlertDialog(
    title: Text(Localization.of(context)!.appName),
    content: Text(message),
    actions: _actions(context),
  );
}

AlertDialog _showOkCancelMaterialAlertDialog(
    BuildContext context,
    String message,
    String okButtonTitle,
    String cancelButtonTitle,
    Function okButtonAction,
    bool isCancelEnable,
    Function cancelButtonAction) {
  return AlertDialog(
      title: Text(Localization.of(context)!.appName),
      content: Text(message),
      actions: isCancelEnable
          ? _okCancelActions(
              context: context,
              okButtonTitle: okButtonTitle,
              cancelButtonTitle: cancelButtonTitle,
              okButtonAction: okButtonAction,
              isCancelEnable: isCancelEnable,
              cancelButtonAction: cancelButtonAction,
            )
          : _okAction(
              context: context,
              okButtonAction: okButtonAction,
              okButtonTitle: okButtonTitle));
}

CupertinoAlertDialog _showOkCancelCupertinoAlertDialog(
  BuildContext? context,
  String? message,
  String? okButtonTitle,
  String? cancelButtonTitle,
  Function? okButtonAction,
  bool isCancelEnable,
  Function? cancelButtonAction,
) {
  return CupertinoAlertDialog(
      title: Text(Localization.of(context!)!.appName),
      content: Text(message!),
      actions: isCancelEnable
          ? _okCancelActions(
              context: context,
              okButtonTitle: okButtonTitle!,
              cancelButtonTitle: cancelButtonTitle!,
              okButtonAction: okButtonAction!,
              isCancelEnable: isCancelEnable,
              cancelButtonAction: cancelButtonAction!,
            )
          : _okAction(
              context: context,
              okButtonAction: okButtonAction,
              okButtonTitle: okButtonTitle));
}

List<Widget> _actions(BuildContext context) {
  return <Widget>[
    Platform.isIOS
        ? CupertinoDialogAction(
            child: Text(Localization.of(context)!.ok),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        : TextButton(
            child: Text(Localization.of(context)!.ok),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
  ];
}

List<Widget> _okCancelActions({
  BuildContext? context,
  String? okButtonTitle,
  String? cancelButtonTitle,
  Function? okButtonAction,
  bool? isCancelEnable,
  Function? cancelButtonAction,
}) {
  return <Widget>[
    Platform.isIOS
        ? CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: cancelButtonAction == null
                ? () {
                    Navigator.of(context!).pop();
                  }
                : () {
                    Navigator.of(context!).pop();
                    cancelButtonAction();
                  },
            child: Text(cancelButtonTitle!),
          )
        : TextButton(
            onPressed: cancelButtonAction == null
                ? () {
                    Navigator.of(context!).pop();
                  }
                : () {
                    Navigator.of(context!).pop();
                    cancelButtonAction();
                  },
            child: Text(cancelButtonTitle!),
          ),
    Platform.isIOS
        ? CupertinoDialogAction(
            child: Text(okButtonTitle!),
            onPressed: () {
              Navigator.of(context!).pop();
              okButtonAction!();
            },
          )
        : TextButton(
            child: Text(okButtonTitle!),
            onPressed: () {
              Navigator.of(context!).pop();
              okButtonAction!();
            },
          ),
  ];
}

List<Widget> _okAction(
    {BuildContext? context, String? okButtonTitle, Function? okButtonAction}) {
  return <Widget>[
    Platform.isIOS
        ? CupertinoDialogAction(
            child: Text(okButtonTitle!),
            onPressed: () {
              Navigator.of(context!).pop();
              okButtonAction!();
            },
          )
        : TextButton(
            child: Text(okButtonTitle!),
            onPressed: () {
              Navigator.of(context!).pop();
              okButtonAction!();
            },
          ),
  ];
}

SnackBar displaySnackBar({String? message}) {
  return SnackBar(
    content: Text(
      message!,
      style:
          TextStyle(color: Colors.white, fontSize: SizeConstants.fontSizeSp14),
    ),
    duration: const Duration(seconds: 2),
    backgroundColor: ColorConstants.primaryColor,
  );
}
