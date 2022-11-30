import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:front_office/src/base/dependencyinjection/locator.dart';
import 'package:front_office/src/base/firebase/firebase_options.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import 'src/base/provider/login_provider.dart';
import 'src/base/utils/constants/navigation_route_constants.dart';
import 'src/base/utils/constants/preference_key_constants.dart';
import 'src/base/utils/localization/localization.dart';
import 'src/base/utils/navigation.dart';
import 'src/base/utils/preference_utils.dart' as pref;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialize();
  await pref.init();
  if (Platform.isAndroid) {
    await Firebase.initializeApp(
      // name: Platform.isIOS ? "shyft-auto-uat" : "",
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } else {
    await Firebase.initializeApp(
      name: "shyft-auto-uat",
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  await ScreenUtil.ensureScreenSize();
  setupLocator();
  initializeDateFormatting();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => LoginProvider()),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            appBarTheme: const AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness:
                    Brightness.dark, // For Android (dark icons)
                statusBarBrightness: Brightness.light, // For iOS (dark icons)
              ),
            ),
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: pref.getBool(PreferenceKeyConstants.prefKeyIsLogin)
              ? NavigationRouteConstants.routeUserSelection
              : NavigationRouteConstants.routeLogin,
          onGenerateRoute: locator<NavigationUtils>().generateRoute,
          localizationsDelegates: const [
            MyLocalizationsDelegate(),
            DefaultMaterialLocalizations.delegate,
            DefaultWidgetsLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''),
          ],
        ));
  }
}
