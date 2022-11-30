import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/constants/color_constants.dart';
import '../utils/constants/font_style.dart';
import '../utils/constants/image_constant.dart';
import '../utils/constants/size_constants.dart';
import '../utils/reusablemethods/reusable_ui_method.dart';

extension ScaffoldExtension on Widget {
  Scaffold commonScaffold(
      {BuildContext? context,
      String? appBarTitle,
      bool isCenterTitle = false,
      bool isBackVisible = true,
      bool isForComingSoon = false,
      bool isWhiteAppBar = false,
      bool isPrivacyPolicy = false}) {
    return Scaffold(
      backgroundColor: ColorConstants.whiteColor,
      appBar: commonAppBar(context!, appBarTitle!,
          isCenterTitle: isCenterTitle,
          isBackVisible: isBackVisible,
          isForComingSoon: isForComingSoon,
          isWhiteAppBar: isWhiteAppBar),
      body: commonSafeArea(this),
    );
  }

  Scaffold authContainerScaffold(
      {BuildContext? context, bool? resizeToAvoidBottomInset = true}) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      body: this,
    );
  }

  Scaffold userSelectionScaffold({
    GlobalKey<ScaffoldState>? key,
    BuildContext? context,
    String? title,
    bool? isShowLeading = false,
    bool? resizeToAvoidBottomInset = true,
    VoidCallback? backClick,
    List<Widget>? actions,
  }) {
    return Scaffold(
      key: key,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          title ?? "",
          style: FontStyle.helveticaMediumTextColor_16,
        ),
        centerTitle: true,
        elevation: SizeConstants.size0,
        leading: isShowLeading ?? false
            ? Image.asset(
                ImageConstant.icBackArrow,
                width: SizeConstants.size17,
                height: SizeConstants.size12,
              )
                .paddingOnly(
                    left: SizeConstants.size20.r, right: SizeConstants.size20.r)
                .onTap(() {
                backClick!();
              })
            : Container(),
        actions: actions,
        leadingWidth: SizeConstants.size60,
      ),
      body: this,
    );
  }

  Scaffold gredientScaffold({
    BuildContext? context,
    String? title,
    bool? isShowLeading = false,
    bool? resizeToAvoidBottomInset = true,
    VoidCallback? backClick,
    List<Widget>? actions,
  }) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          title ?? "",
          style: FontStyle.helveticaMediumWhiteColor_16,
        ),
        centerTitle: true,
        elevation: SizeConstants.size0,
        leading: isShowLeading ?? false
            ? Image.asset(
                ImageConstant.icBackArrow,
                width: SizeConstants.size17,
                height: SizeConstants.size12,
                color: ColorConstants.whiteColor,
              )
                .paddingOnly(
                    left: SizeConstants.size20.r, right: SizeConstants.size20.r)
                .onTap(() {
                backClick!();
              })
            : Container(),
        actions: actions,
        leadingWidth: SizeConstants.size60,
      ),
      body: this,
    );
  }

  // Consumer homeScaffold(
  //     {GlobalKey<ScaffoldState>? key,
  //     BuildContext? context,
  //     String? title,
  //     String? leadingImage,
  //     String? actionImage,
  //     bool? isShowLeading,
  //     VoidCallback? backClick}) {
  //   return Consumer<DashboardProvider>(
  //       builder: (context, dashboardProvider, _) => Scaffold(
  //             key: key,
  //             appBar: AppBar(
  //               title: Text(
  //                 dashboardProvider.dashboardScreenTypeVal ==
  //                             dashboardScreenType.markFence ||
  //                         dashboardProvider.dashboardScreenTypeVal ==
  //                             dashboardScreenType.startPolygon ||
  //                         dashboardProvider.dashboardScreenTypeVal ==
  //                             dashboardScreenType.markPolygonPoint ||
  //                         dashboardProvider.dashboardScreenTypeVal ==
  //                             dashboardScreenType.addPolygonDetails ||
  //                         dashboardProvider.dashboardScreenTypeVal ==
  //                             dashboardScreenType.addFencing ||
  //                         dashboardProvider.dashboardScreenTypeVal ==
  //                             dashboardScreenType.startFencingPolygon ||
  //                         dashboardProvider.dashboardScreenTypeVal ==
  //                             dashboardScreenType.markPolygonPointInner ||
  //                         dashboardProvider.dashboardScreenTypeVal ==
  //                             dashboardScreenType.addDepartmentDetails ||
  //                         dashboardProvider.dashboardScreenTypeVal ==
  //                             dashboardScreenType.fencingTester
  //                     ? Localization.of(context)!.fenceBuilderSingle
  //                     : Localization.of(context)!.dashboard,
  //                 style: FontStyle.helveticaMediumTextColor_16,
  //               ),
  //               centerTitle: true,
  //               elevation: SizeConstants.size0,
  //               flexibleSpace: Container(
  //                 decoration: const BoxDecoration(
  //                   gradient: LinearGradient(colors: [
  //                     ColorConstants.statusBarStartColor,
  //                     ColorConstants.statusBarEndColor,
  //                   ],
  //                       // begin: FractionalOffset(0.0, 0.0),
  //                       // end: FractionalOffset(1.0, 0.0),
  //                       stops: [
  //                         0.0,
  //                         1.0
  //                       ], tileMode: TileMode.clamp),
  //                 ),
  //               ),
  //               leading: dashboardProvider.dashboardScreenTypeVal ==
  //                           dashboardScreenType.markFence ||
  //                       dashboardProvider.dashboardScreenTypeVal ==
  //                           dashboardScreenType.startPolygon ||
  //                       dashboardProvider.dashboardScreenTypeVal ==
  //                           dashboardScreenType.markPolygonPoint ||
  //                       dashboardProvider.dashboardScreenTypeVal ==
  //                           dashboardScreenType.addPolygonDetails ||
  //                       dashboardProvider.dashboardScreenTypeVal ==
  //                           dashboardScreenType.addFencing ||
  //                       dashboardProvider.dashboardScreenTypeVal ==
  //                           dashboardScreenType.startFencingPolygon ||
  //                       dashboardProvider.dashboardScreenTypeVal ==
  //                           dashboardScreenType.markPolygonPointInner ||
  //                       dashboardProvider.dashboardScreenTypeVal ==
  //                           dashboardScreenType.addDepartmentDetails ||
  //                       dashboardProvider.dashboardScreenTypeVal ==
  //                           dashboardScreenType.fencingTester
  //                   ? Image.asset(
  //                       ImageConstant.icBackArrow,
  //                       width: SizeConstants.size17,
  //                       height: SizeConstants.size12,
  //                     )
  //                       .paddingOnly(
  //                           left: SizeConstants.size20.r,
  //                           right: SizeConstants.size20.r)
  //                       .onTap(() {
  //                       backClick!();
  //                     })
  //                   : Container(),
  //               leadingWidth: SizeConstants.size60,
  //               // brightness: Brightness.light,
  //             ),
  //             body: this,
  //           ));
  // }
}
