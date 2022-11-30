import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../base/dependencyinjection/locator.dart';
import '../../../base/extensions/scaffold_extension.dart';
import '../../../base/utils/constants/color_constants.dart';
import '../../../base/utils/constants/font_style.dart';
import '../../../base/utils/constants/image_constant.dart';
import '../../../base/utils/constants/size_constants.dart';
import '../../../base/utils/localization/localization.dart';
import '../../../base/utils/navigation.dart';
import '../../../base/utils/reusablemethods/reusable_ui_method.dart';
import '../modal/timeline_list_modal.dart';
import '../modal/work_list_modal.dart';

// ignore: must_be_immutable
class WorkDiary extends StatefulWidget {
  const WorkDiary({super.key});
  @override
  State<StatefulWidget> createState() => _WorkDiaryState();
}

class _WorkDiaryState extends State<WorkDiary> {
  bool isRoSelected = false;
  bool isBeaconSelected = false;
  bool isVehicleSelected = false;
  bool isCustomerSelected = false;
  bool isWorkSelected = false;
  List<WorkListModal> workList = [
    WorkListModal(
        id: "1",
        name: "Oil Change",
        backColor: ColorConstants.lovanderLightColor),
    WorkListModal(
        id: "2", name: "Oil Change", backColor: ColorConstants.blueLightColor),
    WorkListModal(
        id: "3", name: "Oil Change", backColor: ColorConstants.greenLightColor)
  ];
  List<TimelineModal> _timeLineList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _timeLineList = [
        TimelineModal(
            title: Localization.of(context)!.entry,
            time: "6:10 PM",
            hours: "2 hours",
            isInProgress: false,
            isShowImage: false,
            name: "Car Wash Bay"),
        TimelineModal(
            title: Localization.of(context)!.start,
            time: "8:10 PM",
            hours: "1 hours",
            isInProgress: true,
            isShowImage: true,
            name: "Brooklyn Simmons"),
        TimelineModal(
            title: Localization.of(context)!.hold,
            time: "9:10 PM",
            hours: "30 Min",
            isInProgress: false,
            isShowImage: false,
            name: "Pump Repairing"),
        TimelineModal(
            title: Localization.of(context)!.resume,
            time: "9:10 PM",
            hours: "1 hours",
            isInProgress: false,
            isShowImage: true,
            name: "Brooklyn Simmons"),
        TimelineModal(
            title: Localization.of(context)!.stop,
            time: "10:40 PM",
            hours: "1 hours",
            isInProgress: false,
            isShowImage: true,
            name: "Brooklyn Simmons"),
      ];
      setState(() {});
    });
  }

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
                  REdgeInsets.only(top: kToolbarHeight + SizeConstants.size18),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(ImageConstant.icAuthBack),
                      fit: BoxFit.fill)),
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        _qrDetailsWidget(context),
                        _timeLineWidget(context),
                      ],
                    ),
                  ),
                  _notificationWidget(context),
                ],
              ),
            );
          },
        )).userSelectionScaffold(
      context: context,
      isShowLeading: true,
      title: Localization.of(context)!.workDiary,
      backClick: () {
        locator<NavigationUtils>().pop(context);
      },
    );
  }

  Widget _notificationWidget(BuildContext context) => Align(
        alignment: Alignment.topRight,
        child: Container(
          alignment: Alignment.center,
          height: SizeConstants.size40,
          width: SizeConstants.size40,
          margin: REdgeInsets.only(right: SizeConstants.size24),
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                ColorConstants.secondaryColor.withOpacity(0.5),
                ColorConstants.primaryColor.withOpacity(0.5),
              ], tileMode: TileMode.clamp),
              shape: BoxShape.circle),
          child: Container(
            alignment: Alignment.center,
            height: SizeConstants.size32,
            width: SizeConstants.size32,
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  ColorConstants.secondaryColor,
                  ColorConstants.primaryColor,
                ], tileMode: TileMode.clamp),
                shape: BoxShape.circle),
            child: SvgPicture.asset(
              ImageConstant.icBell,
              width: SizeConstants.size17,
              height: SizeConstants.size19,
            ),
          ),
        ),
      );

  Widget _qrDetailsWidget(BuildContext context) => Container(
        padding: REdgeInsets.all(SizeConstants.size20),
        margin: REdgeInsets.only(top: SizeConstants.size22),
        decoration: BoxDecoration(color: ColorConstants.whiteColor, boxShadow: [
          BoxShadow(
              offset: const Offset(0, 1),
              blurRadius: SizeConstants.size2,
              spreadRadius: 1,
              color: ColorConstants.searchBorderColor)
        ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Localization.of(context)!.getNo("1"),
              style: FontStyle.helveticaMediumTextColor_14,
            ),
            Row(
              children: [
                _titleSubtitleWidget(Localization.of(context)!.serviceName,
                        "Engine oil change")
                    .paddingRight(SizeConstants.size5),
                _titleSubtitleWidget(
                    Localization.of(context)!.quantity, "5 Litre"),
              ],
            ).paddingTop(SizeConstants.size20),
            _titleSubtitleWidget(Localization.of(context)!.supervisorRemark,
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                    textStyle: FontStyle.helveticaRegularTextColor_12,
                    isFullWidth: true)
                .paddingTop(SizeConstants.size30),
            _titleSubtitleWidget(Localization.of(context)!.clientComment,
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                    textStyle: FontStyle.helveticaRegularTextColor_12,
                    isFullWidth: true)
                .paddingTop(SizeConstants.size30),
          ],
        ),
      );

  Widget _timeLineWidget(BuildContext context) => Container(
        padding: REdgeInsets.all(SizeConstants.size20),
        margin: REdgeInsets.only(top: SizeConstants.size10),
        decoration: BoxDecoration(color: ColorConstants.whiteColor, boxShadow: [
          BoxShadow(
              offset: const Offset(0, 1),
              blurRadius: SizeConstants.size2,
              spreadRadius: 1,
              color: ColorConstants.searchBorderColor)
        ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Localization.of(context)!.timeLine,
              style: FontStyle.helveticaMediumTextColor_14,
            ),
            Container(
              margin: REdgeInsets.only(top: SizeConstants.size12),
              padding: REdgeInsets.only(
                  top: SizeConstants.size10,
                  bottom: SizeConstants.size10,
                  left: SizeConstants.size20,
                  right: SizeConstants.size20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(SizeConstants.size10),
                  border: Border.all(
                      color: ColorConstants.timeLineBorderColor,
                      width: SizeConstants.size1),
                  color: ColorConstants.timeLineBackColor),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _timeLineSubtitleWidget(
                    Localization.of(context)!.totalHours,
                    "4h 30m",
                  ),
                  _timeLine(),
                  _timeLineSubtitleWidget(
                    Localization.of(context)!.idealHours,
                    "4h 30m",
                  ),
                  _timeLine(),
                  _timeLineSubtitleWidget(
                    Localization.of(context)!.workingHours,
                    "4h 30m",
                  ),
                ],
              ),
            ),
            _timeLineWorkList(context)
          ],
        ),
      );

  Widget _timeLine() => Container(
        width: SizeConstants.size1,
        height: SizeConstants.size31,
        color: ColorConstants.timeLineColor,
      );

  Widget _timeLineWorkList(BuildContext context) => ListView.builder(
        padding: REdgeInsets.only(
            top: SizeConstants.size27, bottom: SizeConstants.size20),
        itemBuilder: (context, index) {
          return _serviceTitleWidget(context, _timeLineList[index], index);
        },
        shrinkWrap: true,
        itemCount: _timeLineList.length,
        physics: const NeverScrollableScrollPhysics(),
      );

  Widget _titleSubtitleWidget(
    String title,
    String subTitle, {
    bool isFullWidth = false,
    bool isTimeLine = false,
    TextStyle? textStyle,
  }) =>
      SizedBox(
        width: isFullWidth
            ? double.maxFinite
            : isTimeLine
                ? (MediaQuery.of(context).size.width - 85) / 3
                : (MediaQuery.of(context).size.width - 47) / 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: FontStyle.helveticaRegularTextColorDes_12,
            ).paddingBottom(SizeConstants.size5),
            Text(
              subTitle,
              style: textStyle ?? FontStyle.helveticaMediumTextColor_12,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      );

  Widget _timeLineSubtitleWidget(
    String title,
    String subTitle, {
    TextStyle? textStyle,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: FontStyle.helveticaRegularTextColorDes_12,
          ).paddingBottom(SizeConstants.size5),
          Text(
            subTitle,
            style: textStyle ?? FontStyle.helveticaMediumTextColor_12,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      );

  Widget _serviceTitleWidget(
          BuildContext context, TimelineModal data, int index) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: SizeConstants.size60,
                child: Text(
                  data.time ?? "",
                  style: FontStyle.helveticaRegularTextColorDes_12,
                ),
              ),
              Container(
                margin: REdgeInsets.only(
                    left: SizeConstants.size16, right: SizeConstants.size18),
                width: SizeConstants.size16,
                height: SizeConstants.size16,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: ColorConstants.textColor,
                        width: SizeConstants.size2),
                    color: ColorConstants.whiteColor),
                child: data.isInProgress ?? false
                    ? Container(
                        width: SizeConstants.size7,
                        height: SizeConstants.size7,
                        padding: REdgeInsets.all(SizeConstants.size3),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(colors: [
                              ColorConstants.secondaryColor,
                              ColorConstants.primaryColor,
                            ])))
                    : Container(),
              ),
              Text(
                data.title ?? "",
                style: FontStyle.helveticaMediumTextColor_12,
              ),
            ],
          ),
          Stack(
            alignment: Alignment.centerLeft,
            children: [
              index < _timeLineList.length - 1
                  ? SvgPicture.asset(
                      index % 2 == 0
                          ? ImageConstant.icLineLightBlue
                          : ImageConstant.icLineDarkBlue,
                      height: index % 2 == 0
                          ? SizeConstants.size36
                          : SizeConstants.size50,
                      fit: BoxFit.scaleDown,
                    ).paddingOnly(
                      left: SizeConstants.size79,
                      top: index % 2 == 0
                          ? SizeConstants.size2
                          : SizeConstants.size0,
                      bottom: index % 2 == 0
                          ? SizeConstants.size2
                          : SizeConstants.size0)
                  : Container(
                      height: SizeConstants.size36,
                    ),
              Positioned(
                top: SizeConstants.size3,
                left: SizeConstants.size108,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Row(
                    children: [
                      if (data.isShowImage ?? false)
                        SvgPicture.asset(
                          ImageConstant.icRoUser,
                          width: SizeConstants.size12,
                          height: SizeConstants.size12,
                          fit: BoxFit.scaleDown,
                        ).paddingOnly(
                          right: SizeConstants.size5,
                        ),
                      Text(
                        data.name ?? "",
                        style: FontStyle.helveticaRegularTextColorDes_12,
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: index > _timeLineList.length - 1
                    ? Container(
                        padding: REdgeInsets.only(left: SizeConstants.size28),
                        child: Text(
                          data.hours ?? "",
                          style: FontStyle.helveticaRegularTextBlueColor_10,
                        ))
                    : Container(),
              ),
            ],
          ),
        ],
      );
}
