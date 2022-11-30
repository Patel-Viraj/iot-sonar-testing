import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:front_office/src/base/utils/constants/app_constants.dart';
import 'package:front_office/src/base/utils/enum_utils.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../base/dependencyinjection/locator.dart';
import '../../../base/extensions/scaffold_extension.dart';
import '../../../base/utils/constants/color_constants.dart';
import '../../../base/utils/constants/font_style.dart';
import '../../../base/utils/constants/image_constant.dart';
import '../../../base/utils/constants/navigation_route_constants.dart';
import '../../../base/utils/constants/size_constants.dart';
import '../../../base/utils/localization/localization.dart';
import '../../../base/utils/navigation.dart';
import '../../../base/utils/reusablemethods/reusable_ui_method.dart';

// ignore: must_be_immutable
class DetectBeacon extends StatefulWidget {
  const DetectBeacon({
    super.key,
  });
  @override
  State<StatefulWidget> createState() => _DetectBeaconState();
}

class _DetectBeaconState extends State<DetectBeacon> {
  @override
  Widget build(BuildContext context) {
    setScreenSize(context);
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: LayoutBuilder(
          builder: (context, constraint) {
            return Container(
              height: SizeConstants.size1.sh,
              width: SizeConstants.size1.sw,
              padding:
                  REdgeInsets.only(top: kToolbarHeight + SizeConstants.size26),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(ImageConstant.icAuthBack),
                      fit: BoxFit.fill)),
              child: Column(
                children: [Flexible(child: _listWidget(context))],
              ),
            );
          },
        )).userSelectionScaffold(
      context: context,
      isShowLeading: true,
      title: Localization.of(context)!.detectBeacon,
      backClick: () {
        locator<NavigationUtils>().pop(context);
      },
    );
  }

  Widget _listWidget(BuildContext context) => ListView.builder(
        padding: REdgeInsets.only(
            top: SizeConstants.size10, bottom: SizeConstants.size80),
        itemBuilder: (context, index) {
          return _listItem(context, index);
        },
        shrinkWrap: true,
        itemCount: 15,
      );

  Widget _listItem(BuildContext context, int index) => Container(
        width: double.maxFinite,
        height: SizeConstants.size138.r,
        margin: REdgeInsets.only(
            left: SizeConstants.size20,
            right: SizeConstants.size20,
            top: SizeConstants.size5,
            bottom: SizeConstants.size5),
        decoration: BoxDecoration(
          color: ColorConstants.whiteColor,
          borderRadius: BorderRadius.circular(SizeConstants.size15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: double.maxFinite,
                  width: SizeConstants.size10,
                  decoration: BoxDecoration(
                      color: ColorConstants.blueLineColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(SizeConstants.size15),
                          bottomLeft: Radius.circular(SizeConstants.size15))),
                ),
                Flexible(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          ImageConstant.icBeacone,
                          width: SizeConstants.size40,
                          height: SizeConstants.size40,
                          fit: BoxFit.scaleDown,
                        ).paddingRight(SizeConstants.size15),
                        Text(
                          "#123 456",
                          style: FontStyle.helveticaMediumTextColor_14,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ).paddingBottom(SizeConstants.size20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _titleSubtitleWidget(Localization.of(context)!.rONumber,
                                "123 456 789 0")
                            .paddingRight(SizeConstants.size70),
                        _titleSubtitleWidget(
                            Localization.of(context)!.distance, "100 Meter"),
                      ],
                    ).paddingOnly(right: SizeConstants.size20),
                  ],
                ).paddingLeft(SizeConstants.size18)),
              ],
            ).paddingRight(SizeConstants.size15),
            Align(
              alignment: Alignment.bottomRight,
              child: SvgPicture.asset(
                ImageConstant.icCarGray,
                width: SizeConstants.size76,
                height: SizeConstants.size59,
                fit: BoxFit.scaleDown,
              ),
            )
          ],
        ),
      ).onTap(() {
        locator<NavigationUtils>().push(
            context, NavigationRouteConstants.routeRoServiceDetails,
            arguments: {AppConstants.type: roSearchType.detectBeacon});
      });

  Widget _titleSubtitleWidget(String title, String subTitle) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: FontStyle.helveticaRegularTextColorDes_12,
          ).paddingBottom(SizeConstants.size5),
          Text(
            subTitle,
            style: FontStyle.helveticaMediumTextColor_12,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      );
}
