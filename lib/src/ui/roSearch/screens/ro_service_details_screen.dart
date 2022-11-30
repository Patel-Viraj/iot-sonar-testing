import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../base/dependencyinjection/locator.dart';
import '../../../base/extensions/scaffold_extension.dart';
import '../../../base/utils/constants/app_constants.dart';
import '../../../base/utils/constants/color_constants.dart';
import '../../../base/utils/constants/font_style.dart';
import '../../../base/utils/constants/image_constant.dart';
import '../../../base/utils/constants/navigation_route_constants.dart';
import '../../../base/utils/constants/size_constants.dart';
import '../../../base/utils/enum_utils.dart';
import '../../../base/utils/localization/localization.dart';
import '../../../base/utils/navigation.dart';
import '../../../base/utils/reusablemethods/reusable_ui_method.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_button_simple.dart';
import '../modal/work_list_modal.dart';

// ignore: must_be_immutable
class RoServiceDetails extends StatefulWidget {
  roSearchType? mType;
  RoServiceDetails({super.key, this.mType});
  @override
  State<StatefulWidget> createState() => _RoServiceDetailsState();
}

class _RoServiceDetailsState extends State<RoServiceDetails> {
  bool isRoSelected = true;
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
                  REdgeInsets.only(top: kToolbarHeight + SizeConstants.size36),
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
                        if (widget.mType != roSearchType.assignBeacon)
                          _beaconDetailsWidget(context),
                        _vehicleDetailsWidget(context),
                        _customerDetailsWidget(context),
                        _workDetailsWidget(context),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (widget.mType == roSearchType.assignBeacon)
                          _assignKeyBeaconButton(context),
                        _bottomButton(context),
                      ],
                    ).paddingOnly(
                        bottom: SizeConstants.size20,
                        left: SizeConstants.size20.r,
                        right: SizeConstants.size20.r,
                        top: SizeConstants.size30.r),
                  )
                ],
              ),
            );
          },
        )).userSelectionScaffold(
      context: context,
      isShowLeading: true,
      title: Localization.of(context)!.rOServiceDetails,
      backClick: () {
        locator<NavigationUtils>().pop(context);
      },
    );
  }

  Widget _bottomButton(BuildContext context) => CustomButton(
        childView: Text(
          widget.mType == roSearchType.roSearch ||
                  widget.mType == roSearchType.detectBeacon
              ? Localization.of(context)!.viewAssetLocation
              : Localization.of(context)!.assignCarBeacon,
          style: FontStyle.helveticaRegularWhite_16,
        ),
        onButtonTap: () {
          if (widget.mType == roSearchType.roSearch ||
              widget.mType == roSearchType.detectBeacon) {
            locator<NavigationUtils>().push(
                context, NavigationRouteConstants.routeAssetLocation,
                arguments: {AppConstants.type: widget.mType});
          } else {
            locator<NavigationUtils>().push(
                context, NavigationRouteConstants.routeScanQR,
                arguments: {AppConstants.type: scanQRType.carBeacon});
          }
        },
        primaryColor: ColorConstants.primaryColor,
        primaryTextColor: ColorConstants.whiteColor,
        buttonShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(SizeConstants.size18.r)),
        labelSize: SizeConstants.fontSizeSp18,
      );

  Widget _assignKeyBeaconButton(BuildContext context) => CustomButtonSimple(
        childView: Text(
          Localization.of(context)!.assignKeyBeacon,
          style: FontStyle.helveticaRegularWhite_16,
        ),
        onButtonTap: () {
          locator<NavigationUtils>().push(
              context, NavigationRouteConstants.routeScanQR,
              arguments: {AppConstants.type: scanQRType.carBeacon});
        },
        primaryColor: ColorConstants.primaryColor,
        primaryTextColor: ColorConstants.whiteColor,
        buttonShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(SizeConstants.size18.r)),
        labelSize: SizeConstants.fontSizeSp18,
      ).paddingBottom(SizeConstants.size15);

  Widget _qrDetailsWidget(BuildContext context) => Container(
        padding: REdgeInsets.all(SizeConstants.size20),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  Localization.of(context)!.rODetail,
                  style: FontStyle.helveticaMediumTextColor_14,
                ),
                SvgPicture.asset(
                  isRoSelected
                      ? ImageConstant.icArrowDown
                      : ImageConstant.icArrowRight,
                  color: ColorConstants.textColor,
                  width: SizeConstants.size10,
                  height: SizeConstants.size14,
                  fit: BoxFit.scaleDown,
                )
              ],
            ).onTap(() {
              isRoSelected = !isRoSelected;
              setState(() {});
            }),
            if (isRoSelected)
              Row(
                children: [
                  _titleSubtitleWidget(Localization.of(context)!.rONumber,
                          "123 456 789 0", ImageConstant.icRoNumber)
                      .paddingRight(SizeConstants.size5),
                  _titleSubtitleWidget(Localization.of(context)!.rOByUserName,
                      "Jane Cooper", ImageConstant.icRoUser),
                ],
              ).paddingTop(SizeConstants.size20),
            if (isRoSelected)
              _titleSubtitleWidget(Localization.of(context)!.rODateTime,
                      "02 Nov 2022 I 11:30 AM", ImageConstant.icRoCalander)
                  .paddingTop(SizeConstants.size14),
          ],
        ),
      );

  Widget _beaconDetailsWidget(BuildContext context) => Container(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  Localization.of(context)!.beaconDetails,
                  style: FontStyle.helveticaMediumTextColor_14,
                ),
                SvgPicture.asset(
                  isBeaconSelected
                      ? ImageConstant.icArrowDown
                      : ImageConstant.icArrowRight,
                  color: ColorConstants.textColor,
                  width: SizeConstants.size10,
                  height: SizeConstants.size14,
                  fit: BoxFit.scaleDown,
                )
              ],
            ).onTap(() {
              isBeaconSelected = !isBeaconSelected;
              setState(() {});
            }),
            if (isBeaconSelected)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _titleSubtitleWidget(Localization.of(context)!.keyBeaconID,
                          "#123 456", ImageConstant.icKey,
                          isAssing: true,
                          assingTitle: Localization.of(context)!.assign,
                          textStyle: FontStyle.helveticaRegularGreen_10,
                          backCOlor: ColorConstants.availableBackColor)
                      .paddingRight(SizeConstants.size5),
                  _titleSubtitleWidget(Localization.of(context)!.carBeaconID,
                      "#987 654", ImageConstant.icCar,
                      isAssing: true,
                      assingTitle: Localization.of(context)!.unassign,
                      textStyle: FontStyle.helveticaRegularRed_10,
                      backCOlor: ColorConstants.unassingBackColor),
                ],
              ).paddingTop(SizeConstants.size20),
          ],
        ),
      );

  Widget _vehicleDetailsWidget(BuildContext context) => Container(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  Localization.of(context)!.vehicleDetails,
                  style: FontStyle.helveticaMediumTextColor_14,
                ),
                SvgPicture.asset(
                  isVehicleSelected
                      ? ImageConstant.icArrowDown
                      : ImageConstant.icArrowRight,
                  color: ColorConstants.textColor,
                  width: SizeConstants.size10,
                  height: SizeConstants.size14,
                  fit: BoxFit.scaleDown,
                )
              ],
            ).onTap(() {
              isVehicleSelected = !isVehicleSelected;
              setState(() {});
            }),
            if (isVehicleSelected)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _titleSubtitleWidget(
                    Localization.of(context)!.manufacturerName,
                    "Toyota",
                    ImageConstant.icManufacture,
                  ).paddingRight(SizeConstants.size5),
                  _titleSubtitleWidget(
                    Localization.of(context)!.makerYear,
                    "2015",
                    ImageConstant.icRoCalander,
                  ),
                ],
              ).paddingTop(SizeConstants.size20),
            if (isVehicleSelected)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _titleSubtitleWidget(
                    Localization.of(context)!.model,
                    "Corolla Cross",
                    ImageConstant.icVvehicleCar,
                  ).paddingRight(SizeConstants.size5),
                  _titleSubtitleWidget(
                    Localization.of(context)!.colour,
                    "White",
                    ImageConstant.icColor,
                  ),
                ],
              ).paddingTop(SizeConstants.size20),
            if (isVehicleSelected)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _titleSubtitleWidget(
                    Localization.of(context)!.fuelType,
                    "Petrol",
                    ImageConstant.icFuel,
                  ).paddingRight(SizeConstants.size5),
                  _titleSubtitleWidget(
                    Localization.of(context)!.vINNumber,
                    "A 193985",
                    ImageConstant.icVinNumber,
                  ),
                ],
              ).paddingTop(SizeConstants.size20),
            if (isVehicleSelected)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _titleSubtitleWidget(
                    Localization.of(context)!.currentMeterReading,
                    "25600",
                    ImageConstant.icDiometer,
                  ).paddingRight(SizeConstants.size5),
                  _titleSubtitleWidget(
                    Localization.of(context)!.lastServiceReading,
                    "10562",
                    ImageConstant.icDiometer,
                  ),
                ],
              ).paddingTop(SizeConstants.size20),
          ],
        ),
      );

  Widget _customerDetailsWidget(BuildContext context) => Container(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  Localization.of(context)!.customerDetail,
                  style: FontStyle.helveticaMediumTextColor_14,
                ),
                SvgPicture.asset(
                  isCustomerSelected
                      ? ImageConstant.icArrowDown
                      : ImageConstant.icArrowRight,
                  color: ColorConstants.textColor,
                  width: SizeConstants.size10,
                  height: SizeConstants.size14,
                  fit: BoxFit.scaleDown,
                )
              ],
            ).onTap(() {
              isCustomerSelected = !isCustomerSelected;
              setState(() {});
            }),
            if (isCustomerSelected)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _titleSubtitleWidget(
                    Localization.of(context)!.firstName,
                    "Guy",
                    ImageConstant.icRoUser,
                  ).paddingRight(SizeConstants.size5),
                  _titleSubtitleWidget(
                    Localization.of(context)!.lastName,
                    "Hawkins",
                    ImageConstant.icRoUser,
                  ),
                ],
              ).paddingTop(SizeConstants.size20),
            if (isCustomerSelected)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _titleSubtitleWidget(
                    Localization.of(context)!.emailID,
                    "guy123@gmail.com",
                    ImageConstant.icRoMail,
                  ).paddingRight(SizeConstants.size5),
                  _titleSubtitleWidget(
                    Localization.of(context)!.mobileNumber,
                    "987 654 3210",
                    ImageConstant.icMobile,
                  ),
                ],
              ).paddingTop(SizeConstants.size20),
            if (isCustomerSelected)
              _titleSubtitleWidget(
                Localization.of(context)!.address,
                "Lorem Ipsum is simply D12 East Road.",
                ImageConstant.icRoLocation,
              )
                  .paddingRight(SizeConstants.size5)
                  .paddingTop(SizeConstants.size20),
          ],
        ),
      );

  Widget _workDetailsWidget(BuildContext context) => Container(
        padding: REdgeInsets.all(SizeConstants.size20),
        margin: REdgeInsets.only(
            top: SizeConstants.size10, bottom: SizeConstants.size90),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.mType == roSearchType.detectBeacon
                      ? Localization.of(context)!.activeLine
                      : Localization.of(context)!.workDiary,
                  style: FontStyle.helveticaMediumTextColor_14,
                ),
                SvgPicture.asset(
                  isWorkSelected
                      ? ImageConstant.icArrowDown
                      : ImageConstant.icArrowRight,
                  color: ColorConstants.textColor,
                  width: SizeConstants.size10,
                  height: SizeConstants.size14,
                  fit: BoxFit.scaleDown,
                )
              ],
            ).onTap(() {
              isWorkSelected = !isWorkSelected;
              setState(() {});
            }),
            if (isWorkSelected)
              ListView.builder(
                padding: REdgeInsets.only(top: SizeConstants.size20),
                itemBuilder: (context, index) {
                  return Container(
                    width: double.maxFinite,
                    margin: REdgeInsets.only(bottom: SizeConstants.size10),
                    padding: REdgeInsets.only(
                        left: SizeConstants.size24,
                        right: SizeConstants.size24,
                        top: SizeConstants.size16,
                        bottom: SizeConstants.size16),
                    decoration: BoxDecoration(
                        color: workList[index].backColor,
                        borderRadius:
                            BorderRadius.circular(SizeConstants.size10)),
                    child: Row(
                      children: [
                        Text(
                          workList[index].id ?? "",
                          style: FontStyle.helveticaMediumTextColor_30,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Localization.of(context)!.serviceName,
                              style: FontStyle.helveticaRegularTextColorDes_12,
                            ),
                            Text(
                              workList[index].name ?? "",
                              style: FontStyle.helveticaMediumTextColor_12,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ).paddingLeft(SizeConstants.size24),
                        const Spacer(),
                        if (widget.mType == roSearchType.detectBeacon)
                          _lableWidget(
                              context,
                              Localization.of(context)!.completed,
                              FontStyle.helveticaRegularGreen_10),
                        SvgPicture.asset(
                          ImageConstant.icArrowGray,
                          fit: BoxFit.scaleDown,
                          width: SizeConstants.size15.r,
                          height: SizeConstants.size12.r,
                        )
                      ],
                    ),
                  ).onTap(() {
                    if (widget.mType == roSearchType.detectBeacon) {
                      locator<NavigationUtils>().push(
                          context, NavigationRouteConstants.routeActiveLine);
                    } else {
                      locator<NavigationUtils>().push(
                          context, NavigationRouteConstants.routeWorkDiary);
                    }
                  });
                },
                shrinkWrap: true,
                itemCount: workList.length,
                physics: const NeverScrollableScrollPhysics(),
              ),
          ],
        ),
      );

  Widget _titleSubtitleWidget(String title, String subTitle, String image,
          {bool isAssing = false,
          TextStyle? textStyle,
          Color? backCOlor,
          String? assingTitle}) =>
      SizedBox(
        width: (MediaQuery.of(context).size.width - 47) / 2,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              image,
              width: SizeConstants.size14,
              height: SizeConstants.size14,
              fit: BoxFit.scaleDown,
            ).paddingRight(SizeConstants.size14),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: FontStyle.helveticaRegularTextColorDes_12,
                  ).paddingBottom(SizeConstants.size5),
                  Text(
                    subTitle,
                    style: FontStyle.helveticaMediumTextColor_12,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (isAssing)
                    Container(
                        margin: REdgeInsets.only(top: SizeConstants.size13),
                        padding: REdgeInsets.only(
                          top: SizeConstants.size5,
                          bottom: SizeConstants.size5,
                          left: SizeConstants.size13,
                          right: SizeConstants.size13,
                        ),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(SizeConstants.size10),
                            color: backCOlor),
                        child: Text(
                          assingTitle ?? "",
                          style: textStyle ?? FontStyle.helveticaRegularRed_10,
                        ))
                ],
              ),
            )
          ],
        ),
      );

  Widget _lableWidget(BuildContext context, String title, TextStyle style) =>
      Container(
        margin: REdgeInsets.only(right: SizeConstants.size10),
        padding: REdgeInsets.only(
            top: SizeConstants.size3,
            bottom: SizeConstants.size3,
            right: SizeConstants.size10,
            left: SizeConstants.size10),
        decoration: BoxDecoration(
            color: ColorConstants.whiteColor,
            borderRadius: BorderRadius.circular(SizeConstants.size10)),
        child: Text(
          title,
          style: style,
        ),
      );
}
