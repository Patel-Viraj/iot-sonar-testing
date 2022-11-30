import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';

import '../base/utils/constants/color_constants.dart';
import '../base/utils/constants/font_style.dart';
import '../base/utils/constants/size_constants.dart';

/// Using this widget you can implement Custom dropdown as per requirement of Ui/Ux

/// borderRadius : To set border radius of dropdown parent view
/// borderThickness :  To set border thickness of dropdown parent view
/// borderColor : To set color for border of dropdown parent view
/// backGroundColor : To set background color of dropdown parent view
/// dropDownBackGroundColor : To set background color of dropdown child view
/// boxWidth : To set width of dropdown parent view
/// boxHeight : To set height of dropdown parent view
/// boxPadding : To set padding of dropdown parent view
/// dropDownHeight : To set height of dropdown child view
/// dropDownBorderRadius : To set border radius of dropdown child view
/// textStyle : To set style of text
/// hintStyle : To set style of hint text
/// hintText : To set hint
/// items : List of items to select
/// iconColor : To set color of dropdown icon

//ignore: must_be_immutable
class CustomDropDown extends StatefulWidget {
  final double? borderRadius;
  final double? borderThickness;
  final Color? borderColor;
  final Color? backGroundColor;
  final Color? dropDownBackGroundColor;
  final double? boxWidth;
  final double? boxHeight;
  final double? boxPadding;
  final double? dropDownHeight;
  final double? dropDownBorderRadius;
  final double? dropDownBottomPadding;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  String? hintText;
  final List<String>? items;
  // final List<String>? searchItems;
  final Color? iconColor;
  Function(String)? selectedTextCallback;
  final bool isValidationMsgVisible;
  final bool isSelected;
  final String? validationMsg;
  Function(bool)? onTapCallback;

  CustomDropDown(
      {Key? key,
      @required this.items,
      // @required this.searchItems,
      this.borderRadius = 0.0,
      this.borderThickness = 0.0,
      this.borderColor = Colors.transparent,
      this.backGroundColor = Colors.white,
      this.boxHeight = 40.0,
      this.boxWidth,
      this.boxPadding = 0.0,
      this.hintStyle = const TextStyle(fontSize: 18, color: Colors.black),
      this.textStyle = const TextStyle(fontSize: 16, color: Colors.grey),
      this.dropDownBackGroundColor = Colors.white,
      this.dropDownBorderRadius = 10.0,
      this.dropDownBottomPadding = 0.0,
      this.dropDownHeight = 200,
      this.iconColor = Colors.black,
      this.hintText = "Select",
      @required this.selectedTextCallback,
      this.isValidationMsgVisible = false,
      this.isSelected = false,
      this.onTapCallback,
      this.validationMsg = "Enter data"})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown>
    with SingleTickerProviderStateMixin {
  OverlayEntry? _sticky;
  final GlobalKey _stickyKey = GlobalKey();
  bool _isVisible = false;
  final _scrollController = ScrollController();
  OverlayState? overlay;

  @override
  void initState() {
    if (_sticky != null) {
      _sticky!.remove();
      _sticky = null;
    }
    super.initState();
  }

  @override
  void dispose() {
    if (_sticky != null) _sticky!.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Container(
                  key: _stickyKey,
                  alignment: Alignment.bottomCenter,
                  width: widget.boxWidth ?? MediaQuery.of(context).size.width,
                  height: widget.boxHeight,
                  padding: EdgeInsets.all(widget.boxPadding!),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(widget.borderRadius!),
                    border: Border.all(
                        color: widget.borderColor!,
                        width: widget.borderThickness!),
                    color: widget.backGroundColor,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.hintText!,
                            style: widget.textStyle,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Icon(
                            _isVisible
                                ? Icons.keyboard_arrow_up_sharp
                                : Icons.keyboard_arrow_down_sharp,
                            color: widget.iconColor,
                          )
                        ],
                      ),
                      Container(
                        margin: REdgeInsets.only(top: SizeConstants.size8.r),
                        height: SizeConstants.size1,
                        color: widget.isSelected
                            ? ColorConstants.textColor
                            : ColorConstants.lineColor,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
            _onDropdownTap(context);
          },
        ),
        if (widget.isValidationMsgVisible)
          Padding(
            padding: EdgeInsets.only(
                right: SizeConstants.size8,
                top: SizeConstants.size8,
                bottom: SizeConstants.size8),
            child: Text(widget.validationMsg!,
                style: FontStyle.helveticaRegularRedColor_12),
          )
      ],
    );
  }

  _onDropdownTap(BuildContext context) {
    if (_isVisible) {
      _sticky!.remove();
      _sticky = null;
      _isVisible = false;
      setState(() {});
      widget.onTapCallback!(false);
    } else {
      _sticky = OverlayEntry(
        builder: (context) => stickyBuilder(context),
      );
      Overlay.of(context)!.insert(_sticky!);
      _isVisible = true;
      setState(() {});
      widget.onTapCallback!(true);
    }
  }

  //widget for dropdown menu
  Widget stickyBuilder(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.transparent,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
          _isVisible = false;
          _sticky!.remove();
          _sticky = null;
          widget.onTapCallback!(false);
        },
        child: Stack(
          children: [
            AnimatedBuilder(
              animation: _scrollController,
              builder: (context, Widget? child) {
                final keyContext = _stickyKey.currentContext;
                if (keyContext != null) {
                  final box = keyContext.findRenderObject() as RenderBox;
                  final pos = box.localToGlobal(Offset.zero);
                  return Positioned(
                    top: pos.dy + box.size.height + SizeConstants.size10,
                    left: pos.dx,
                    right: pos.dx,
                    bottom: widget.dropDownBottomPadding,
                    child: Material(
                      borderRadius:
                          BorderRadius.circular(widget.dropDownBorderRadius!),
                      color: widget.dropDownBackGroundColor,
                      shadowColor: Colors.green,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(SizeConstants.size9),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ],
                            color: ColorConstants.whiteColor),
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            return InkWell(
                              highlightColor: ColorConstants.secondaryColor
                                  .withOpacity(0.3),
                              onTap: () {
                                setState(() {
                                  widget.hintText =
                                      widget.items![index].toString();
                                  widget
                                      .selectedTextCallback!(widget.hintText!);
                                  _isVisible = false;
                                  _sticky!.remove();
                                  _sticky = null;
                                });
                                widget.onTapCallback!(false);
                              },
                              child: Container(
                                color: Colors.transparent,
                                margin: EdgeInsets.only(
                                  left: SizeConstants.size20,
                                  right: SizeConstants.size20,
                                ),
                                padding: REdgeInsets.only(
                                    top: SizeConstants.size10.r),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // SizedBox(
                                    //   height: 10,
                                    // ),
                                    Text(
                                      widget.items![index],
                                      style: widget.textStyle,
                                    ),
                                    Divider(
                                      height: SizeConstants.size5,
                                      color: ColorConstants.lineColor,
                                    ).paddingOnly(top: SizeConstants.size10)
                                  ],
                                ),
                              ),
                            );
                          },
                          shrinkWrap: true,
                          itemCount: widget.items!.length,
                        ),
                      ),
                    ),
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
