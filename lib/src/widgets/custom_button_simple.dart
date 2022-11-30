import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';

import '../base/utils/constants/app_constants.dart';
import '../base/utils/constants/color_constants.dart';
import '../base/utils/constants/size_constants.dart';

/// Using this widget you can customize primary button as per requirement of Ui/Ux

/// onButtonTap : Tap event for button
/// onButtonLongTap : Long Tap event for button
/// focusNode : To set focus
/// primaryColor : To set background color of  button
/// primaryTextColor : To set color of text in  button
/// shadowColor : To set color of shadow when elevation is there
/// elevation : To elevate primary button for better user experience
/// labelSize : To set fontSize of text in  button
/// edgeInsetsPadding : To give some padding in button
/// borderSide : To give border to button
/// childView : To render child view in button
/// buttonShape : To give shape of button

class CustomButtonSimple extends StatelessWidget {
  final VoidCallback onButtonTap;
  final VoidCallback? onButtonLongTap;
  final FocusNode? focusNode;
  final Color? primaryColor;
  final Color? primaryTextColor;
  final Color? shadowColor;
  final Color? backgroundColor;
  final double? elevation;
  final double labelSize;
  final EdgeInsetsGeometry? edgeInsetsPadding;
  final BorderSide? borderSide;
  final Widget? childView;
  final Widget? imageWidget;
  final OutlinedBorder? buttonShape;
  final TextStyle? style;
  final double? buttonHeight;
  final double? buttonWidth;
  final bool isDisable;
  final bool isRightImagePos;

  const CustomButtonSimple(
      {Key? key,
      required this.childView,
      required this.onButtonTap,
      this.onButtonLongTap,
      this.imageWidget,
      this.focusNode,
      this.primaryColor,
      this.primaryTextColor,
      this.backgroundColor,
      this.shadowColor,
      this.elevation,
      this.edgeInsetsPadding,
      this.borderSide,
      this.style,
      this.buttonHeight,
      this.buttonWidth,
      this.isRightImagePos = false,
      this.labelSize = 20,
      this.buttonShape,
      this.isDisable = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: buttonHeight ?? AppConstants.buttonHeight,
      width: buttonWidth ?? SizeConstants.size1.sw,
      decoration: BoxDecoration(
          color: backgroundColor ?? ColorConstants.textColor,
          borderRadius: BorderRadius.circular(SizeConstants.size80)),
      child: imageWidget == null
          ? Center(
              child: childView,
            )
          : Row(
              mainAxisAlignment: isRightImagePos
                  ? MainAxisAlignment.spaceBetween
                  : MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                !isRightImagePos
                    ? imageWidget ?? Container()
                    : Container(
                        width: SizeConstants.size30,
                      ),
                childView ?? Container(),
                if (isRightImagePos) imageWidget ?? Container()
              ],
            ),
    ).onTap(() {
      onButtonTap();
    });
  }
}
