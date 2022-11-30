import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppConstants {
  static const List<String> imageExtensions = ['jpg', 'png', 'jpeg', 'gif'];
  static const List<String> fileExtensions = ["pdf", "doc", "docx"];
  static const List<String> allowedImageExtensions = ["png", "jpg", "jpeg"];
  static const String paramM4aExtension = "m4a";
  static const int splashTime = 5;
  static const int socialErrorCode = 301;
  static const int unauthorisedErrorCode = 401;
  static const int errorCode404 = 404;
  static const int errorCode400 = 400;
  static const int errorCode500 = 500;
  static const int errorCode302 = 302;
  static const String validEmailRegex =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  static const String validPasswordRegex =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~%]).{8,32}$';
  static const String validMobileRegex = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  static double buttonHeight = 50.0.r;
  static String iOSBundleId = "com.shyftauto";
  static String androidPackageId = "com.shyftauto";
  static String emailLoginLink = "https://shyftautouat.page.link/verify";
  static String lot = "Lot";
  static String building = "Building";
  static String parking = "Parking";
  static String indoorLocation = "Indoor Location";
  static String selectPolygonType = "Select Polygon Type";
  static String selectProduct = "Select Product";
  static String serialNumbar = "serialNumbar";
  static String uuIdNumber = "uuIdNumber";
  static String name = "name";
  static String email = "email";
  static String type = "type";
}
