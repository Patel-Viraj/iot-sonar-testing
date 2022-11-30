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

class CustomButton extends StatelessWidget {
  final VoidCallback onButtonTap;
  final VoidCallback? onButtonLongTap;
  final FocusNode? focusNode;
  final Color? primaryColor;
  final Color? primaryTextColor;
  final Color? shadowColor;
  final double? elevation;
  final double labelSize;
  final EdgeInsetsGeometry? edgeInsetsPadding;
  final BorderSide? borderSide;
  final Widget? childView;
  final OutlinedBorder? buttonShape;
  final TextStyle? style;
  final double? buttonHeight;
  final double? buttonWidth;
  final bool isDisable;
  final Widget? imageWidget;

  const CustomButton(
      {Key? key,
      required this.childView,
      required this.onButtonTap,
      this.onButtonLongTap,
      this.focusNode,
      this.imageWidget,
      this.primaryColor,
      this.primaryTextColor,
      this.shadowColor,
      this.elevation,
      this.edgeInsetsPadding,
      this.borderSide,
      this.style,
      this.buttonHeight,
      this.buttonWidth,
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
          gradient: const LinearGradient(colors: [
            ColorConstants.secondaryColor,
            ColorConstants.primaryColor,
          ],
              // begin: FractionalOffset(0.0, 0.0),
              // end: FractionalOffset(1.0, 0.0),
              stops: [
                0.0,
                1.0
              ], tileMode: TileMode.clamp),
          borderRadius: BorderRadius.circular(SizeConstants.size80)),
      child: imageWidget == null
          ? Center(
              child: childView,
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [imageWidget ?? Container(), childView ?? Container()],
            ),
    ).onTap(() {
      onButtonTap();
    });
  }
}
