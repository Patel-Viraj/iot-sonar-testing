import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/color_constants.dart';
import '../constants/size_constants.dart';

SafeArea commonSafeArea(Widget child) => SafeArea(
      child: child,
    );

AppBar commonAppBar(BuildContext context, String title,
        {bool isCenterTitle = false,
        bool isBackVisible = true,
        bool isForComingSoon = false,
        bool isWhiteAppBar = false}) =>
    AppBar(
      title: Text(
        title,
        // style: FontStyle.poppinsRegularTextColorBlue_18,
      ),
      centerTitle: isCenterTitle,
      backgroundColor: ColorConstants.whiteColor,
      elevation: 0,
      // leading: isBackVisible
      //     ? IconButton(
      //   icon: const Icon(
      //     Icons.arrow_back_ios_new,
      //   ),
      //   onPressed: () {
      //     // locator<NavigationUtils>().pop(context);
      //   },
      //   color: ColorConstants.skipColor,
    );

setScreenSize(BuildContext context) => ScreenUtil.init(context,
    designSize: Size(SizeConstants.size375, SizeConstants.size665));
