import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front_office/src/base/utils/constants/app_constants.dart';
import 'package:front_office/src/base/utils/preference_utils.dart';
import 'package:front_office/src/ui/home/screens/user_type_selection_screen.dart';
import 'package:front_office/src/ui/scanQR/screens/scan_qr_screen.dart';
import 'package:front_office/src/ui/signIn/screens/sign_in_screen.dart';

import '../../coming_soon_screen.dart';
import '../../ui/detectBeacon/screens/detect_beacon_screen.dart';
import '../../ui/roSearch/screens/active_line_screen.dart';
import '../../ui/roSearch/screens/ar_map_screen.dart';
import '../../ui/roSearch/screens/asset_location_screen.dart';
import '../../ui/roSearch/screens/ro_search_screen.dart';
import '../../ui/roSearch/screens/ro_service_details_screen.dart';
import '../../ui/roSearch/screens/work_diary_screen.dart';
import 'constants/navigation_route_constants.dart';
import 'constants/preference_key_constants.dart';

class NavigationUtils {
  Route<dynamic> generateRoute(RouteSettings settings) {
    Map<String, dynamic>? args = settings.arguments as Map<String, dynamic>?;
    switch (settings.name) {
      case NavigationRouteConstants.routeLogin:
        return _mainRoute(const SignIn(), settings);
      case NavigationRouteConstants.routeUserSelection:
        return _mainRoute(
            UserTypeSelection(
              name: getString(PreferenceKeyConstants.prefKeyName),
              email: getString(PreferenceKeyConstants.prefKeyEmail),
            ),
            settings);
      case NavigationRouteConstants.routeRoSearch:
        return _mainRoute(
            RoSearch(
              mType: args![AppConstants.type],
            ),
            settings);
      case NavigationRouteConstants.routeRoServiceDetails:
        return _mainRoute(
            RoServiceDetails(
              mType: args![AppConstants.type],
            ),
            settings);
      case NavigationRouteConstants.routeWorkDiary:
        return _mainRoute(const WorkDiary(), settings);
      case NavigationRouteConstants.routeAssetLocation:
        return _mainRoute(
            AssetLocation(
              mType: args![AppConstants.type],
            ),
            settings);
      case NavigationRouteConstants.routeScanQR:
        return _mainRoute(
            ScanQR(
              type: args![AppConstants.type],
            ),
            settings);
      case NavigationRouteConstants.routeDetectBeacon:
        return _mainRoute(const DetectBeacon(), settings);
      case NavigationRouteConstants.routeActiveLine:
        return _mainRoute(const ActiveLine(), settings);
      case NavigationRouteConstants.routeARMapScreen:
        return _mainRoute(const ARMapScreen(), settings);
      default:
        return _errorRoute(" Coming soon...");
    }
  }

  Route<dynamic> _mainRoute(Widget screen, RouteSettings settings) =>
      Platform.isIOS
          ? CupertinoPageRoute(builder: (_) => screen, settings: settings)
          : MaterialPageRoute(builder: (_) => screen, settings: settings);

  Route<dynamic> _errorRoute(String message) => Platform.isIOS
      ? CupertinoPageRoute(builder: (_) => const ComingSoonScreen())
      : MaterialPageRoute(builder: (_) => const ComingSoonScreen());

  void pushReplacement(BuildContext context, String routeName,
      {Object? arguments}) {
    Navigator.of(context).pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> push(BuildContext context, String routeName,
      {Object? arguments, bool isRootNavigator = false}) {
    return Navigator.of(context, rootNavigator: isRootNavigator)
        .pushNamed(routeName, arguments: arguments);
  }

  void pop(BuildContext context, {dynamic args, bool isRootNavigator = false}) {
    Navigator.of(context, rootNavigator: isRootNavigator).pop(args);
  }

  void popUntil(BuildContext context, String routeName,
      {dynamic args, bool isRootNavigator = false}) {
    Navigator.of(context).popUntil(ModalRoute.withName(routeName));
  }

  Future<dynamic> pushAndRemoveUntil(BuildContext context, String routeName,
      {Object? arguments, bool isRootNavigator = false}) {
    return Navigator.of(context, rootNavigator: isRootNavigator)
        .pushNamedAndRemoveUntil(routeName, (route) => false,
            arguments: arguments);
  }

  Future<dynamic> popPushAndRemoveUntil(BuildContext context, String routeName,
      {Object? arguments, bool isRootNavigator = false}) {
    return Navigator.of(context, rootNavigator: isRootNavigator)
        .popAndPushNamed(routeName, arguments: arguments);
  }
}
