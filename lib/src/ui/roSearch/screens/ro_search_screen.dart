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
import '../../../widgets/custom_bouncer.dart';
import '../../../widgets/custom_search_textfield.dart';

// ignore: must_be_immutable
class RoSearch extends StatefulWidget {
  roSearchType? mType;
  RoSearch({super.key, this.mType});
  @override
  State<StatefulWidget> createState() => _RoSearchState();
}

class _RoSearchState extends State<RoSearch> {
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocus = FocusNode();
  final _debouncer = Debouncer();

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
                children: [
                  _searchWidget(context),
                  Flexible(child: _listWidget(context))
                ],
              ),
            );
          },
        )).userSelectionScaffold(
      context: context,
      isShowLeading: true,
      title: widget.mType == roSearchType.roSearch
          ? Localization.of(context)!.rOSearch
          : Localization.of(context)!.assignBeacon,
      backClick: () {
        locator<NavigationUtils>().pop(context);
      },
    );
  }

  Widget _searchWidget(BuildContext context) => Container(
        margin: REdgeInsets.only(
            top: SizeConstants.size10,
            left: SizeConstants.size20,
            right: SizeConstants.size20),
        child: CustomSearchTextField(
          controller: searchController,
          focusNode: searchFocus,
          onFieldSubmitted: (_) {},
          valueTextStyle: FontStyle.helveticaRegularTextColor_14,
          valueHintTextStyle: FontStyle.helveticaRegularTextColorDes_14,
          textInputType: TextInputType.text,
          hint: Localization.of(context)!.enterTheROStockCustomer,
          textInputAction: TextInputAction.done,
          enabledBorderColor: ColorConstants.lineColor,
          focusedBorderColor: ColorConstants.textColor,
          textAlign: TextAlign.start,
          lineHeight: SizeConstants.size1,
          isDense: true,
          suffixIcon: ImageConstant.icClose,
          cursorColor: ColorConstants.primaryColor,
          onChanged: (value) {
            _debouncer.run(() {
              onSearchClick();
            });
          },
          label: "",
          maxLines: 1,
          prefixIcon: ImageConstant.icSearch,
          onSuffixIconClick: (() async {
            searchController.text = "";
            setState(() {});
          }),
          contentSpace: REdgeInsets.only(
              left: SizeConstants.size12,
              right: SizeConstants.size0,
              top: SizeConstants.size14,
              bottom: SizeConstants.size0),
        ),
      );

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
        height: SizeConstants.size160,
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
                    Text(
                      "Cameron Williamson",
                      style: FontStyle.helveticaMediumTextColor_14,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ).paddingBottom(SizeConstants.size14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _titleSubtitleWidget(Localization.of(context)!.rONumber,
                            "123 456 789 0"),
                        _titleSubtitleWidget(
                            Localization.of(context)!.vehicleName,
                            "Toyota Corolla Cross"),
                      ],
                    ).paddingOnly(
                        right: SizeConstants.size20,
                        bottom: SizeConstants.size14),
                    _titleSubtitleWidget(
                        Localization.of(context)!.vINNumber, "A 193985"),
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
            arguments: {AppConstants.type: widget.mType});
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

  void onSearchClick() {
    searchFocus.unfocus();
    if (searchController.text.isNotEmpty) {
      // isSearch = true;
      // _callAPi(isSearch);
    }
  }
}
