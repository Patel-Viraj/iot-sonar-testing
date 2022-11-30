import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';

import '../base/utils/constants/color_constants.dart';
import '../base/utils/constants/font_style.dart';
import '../base/utils/constants/image_constant.dart';
import '../base/utils/constants/size_constants.dart';
import '../base/utils/localization/localization.dart';

/// Using this widget you can customize primary textField as per requirement of Ui/Ux

/// hint : To set text for hint
/// label : To set text for label
/// initialText : To set initialText which will render once textField render.
/// enabled : To set enable/disable textField
/// isObscureText : To give protection based privacy of value in textField
/// readOnly : To give only read permission for textField
/// enableInteractiveSelection : To give permission for copy/paste/select all toolbar options to perform
/// isOutLineField : To render outline or underline input textField based on
/// this boolean variable
/// isCounterVisible : To show/hide counter text
/// focusNode : To set focus
/// textInputType : To set input type for particular textField
/// prefixIcon : To set Icon on left side of textField
/// suffixIcon : To set Icon on right side of textField
/// maxLength : To restrict user for input words based on count of characters
/// maxLines : To restrict user for input numbers of lines.
/// textInputAction : To set input action for particular textField
/// textInputFormatter : To set validation based on input of user
/// controller : To set controller
/// validateFunction : Define validation to inform user for invalid or empty
/// value
/// onPrefixIconClick : Tap event for prefix Icon which render of left side of
/// textField
/// onSuffixIconClick :Tap event for prefix Icon which render of left side of
/// textField
/// onFieldSubmitted :Tap event once user click on done or next button in
/// keyboard
/// onChanged : To get callback when user typing
/// onTap : Tap event for textField
/// capitalization : To set capitalization of textField value
/// textDirection : To give direction ltr or rtl of value in textField
/// textAlign : To give alignment of text in textField
/// contentSpace : To give overall padding of content in textField
/// valueTextStyle : To set text style of value in textField

class CustomSearchTextField extends StatelessWidget {
  final String hint;
  final String label;
  final String? initialText;
  final bool enabled;
  final bool isObscureText;
  final bool readOnly;
  final bool enableInteractiveSelection;
  final bool isOutLineField;
  final bool isCounterVisible;
  final FocusNode focusNode;
  final TextInputType? textInputType;
  final String? prefixIcon;
  final String? suffixIcon;
  final int? maxLength;
  final int maxLines;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? textInputFormatter;
  final TextEditingController? controller;
  final Function? validateFunction;
  final Function? onPrefixIconClick;
  final Function? onSuffixIconClick;
  final Function? onFieldSubmitted;
  final Function(String)? onChanged;
  final Function? onTap;
  final TextCapitalization capitalization;
  final TextDirection textDirection;
  final TextAlign textAlign;
  final EdgeInsetsGeometry? contentSpace;
  final TextStyle? valueTextStyle;
  final TextStyle? valueHintTextStyle;
  final Function(bool)? onTapObscure;
  final bool? isShowText;
  final bool? isDense;
  final Color? backgroundColor;
  final Color? cursorColor;
  final Color? focusedBorderColor;
  final Color? enabledBorderColor;
  final double? lineHeight;

  CustomSearchTextField(
      {Key? key,
      required this.hint,
      required this.label,
      required this.focusNode,
      required this.controller,
      this.initialText,
      this.enabled = true,
      this.isObscureText = false,
      this.readOnly = false,
      this.enableInteractiveSelection = true,
      this.isOutLineField = true,
      this.isCounterVisible = false,
      this.isDense = false,
      this.textInputType,
      this.prefixIcon,
      this.suffixIcon,
      this.focusedBorderColor,
      this.enabledBorderColor,
      this.lineHeight = 3,
      this.maxLength,
      this.maxLines = 1,
      this.textInputAction,
      this.textInputFormatter,
      this.validateFunction,
      this.onPrefixIconClick,
      this.onSuffixIconClick,
      this.onFieldSubmitted,
      this.onChanged,
      this.onTap,
      this.isShowText,
      this.capitalization = TextCapitalization.none,
      this.textDirection = TextDirection.ltr,
      this.textAlign = TextAlign.start,
      this.contentSpace = EdgeInsets.zero,
      this.backgroundColor = ColorConstants.whiteColor,
      this.cursorColor = ColorConstants.primaryColor,
      this.onTapObscure,
      this.valueTextStyle,
      this.valueHintTextStyle})
      : super(key: key);

  final ValueNotifier<String> _counter = ValueNotifier<String>("0");

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _counter,
      builder: (context, String counter, _) => Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(SizeConstants.size12.r),
            border: Border.all(color: ColorConstants.searchBorderColor)),
        child: TextFormField(
          controller: controller,
          textInputAction: textInputAction,
          maxLength: maxLength,
          maxLines: maxLines,
          focusNode: focusNode,
          enabled: enabled,
          initialValue: initialText,
          textCapitalization: capitalization,
          style: valueTextStyle,
          textDirection: textDirection,
          textAlign: textAlign,
          cursorColor: cursorColor,
          obscuringCharacter: '*',
          toolbarOptions: const ToolbarOptions(
              copy: true, cut: true, paste: true, selectAll: true),
          enableInteractiveSelection: enableInteractiveSelection,
          decoration: _textInputDecoration(context, counter),
          readOnly: readOnly,
          inputFormatters: textInputFormatter,
          keyboardType: textInputType,
          obscureText: isObscureText ? isShowText! : false,
          onChanged: (value) {
            if (onChanged != null) onChanged!(value);
          },
          onTap: _onFieldTap,
          onFieldSubmitted: _onValueSubmitted,
          validator: (value) {
            return validateFunction!(value);
          },
        ),
      ),
    );
  }

  InputDecoration _textInputDecoration(BuildContext context, String counter) =>
      InputDecoration(
        errorMaxLines: 4,
        hintText: hint,
        hintStyle: valueHintTextStyle ?? FontStyle.helveticaRegularTextColor_14,
        filled: true,
        fillColor: ColorConstants.whiteColor,
        prefixIcon: _prefixIconView(context),
        suffixIcon: _suffixIconView(context),
        isDense: isDense,
        contentPadding: REdgeInsets.only(
            left: SizeConstants.size12.r,
            right: SizeConstants.size0,
            top: SizeConstants.size14,
            bottom: SizeConstants.size0),
        border: _borderView(Colors.transparent, 0),
        focusedBorder: _borderView(ColorConstants.primaryColor, 0),
        enabledBorder: _borderView(ColorConstants.primaryColor, 0),
        errorStyle: FontStyle.helveticaRegularRedColor_12,
        focusedErrorBorder: _borderView(Colors.transparent, 0),
        errorBorder: _borderView(ColorConstants.redPopUpColor, 0),
        // errorText:
      );

  InputBorder _borderView(Color borderColor, double width) =>
      UnderlineInputBorder(
          borderRadius: BorderRadius.circular(SizeConstants.size12.r),
          borderSide: BorderSide(
              color: borderColor, width: width, style: BorderStyle.none));

  Widget? _prefixIconView(BuildContext context) => prefixIcon != null
      ? SvgPicture.asset(prefixIcon!,
              semanticsLabel: Localization.of(context)!.signIn,
              width: SizeConstants.size18.w,
              height: SizeConstants.size17.h,
              fit: BoxFit.scaleDown)
          .paddingLeft(SizeConstants.size10)
          .paddingRight(SizeConstants.size17.r)
          .onTap(() {
          if (onPrefixIconClick != null) onPrefixIconClick!();
        })
      : isObscureText
          ? _passwordIconView()
          : null;

  Widget? _suffixIconView(BuildContext context) => suffixIcon != null
      ? SvgPicture.asset(suffixIcon!,
              semanticsLabel: Localization.of(context)!.signIn,
              width: SizeConstants.size24.r,
              height: SizeConstants.size24.r,
              fit: BoxFit.scaleDown)
          .onTap(() {
          if (onSuffixIconClick != null) onSuffixIconClick!();
        })
      : null;

  _passwordIconView() => SvgPicture.asset(
              isShowText! ? ImageConstant.icEye : ImageConstant.icEyeDisable,
              width: SizeConstants.size18.w,
              height: SizeConstants.size17.h,
              fit: BoxFit.scaleDown)
          .paddingRight(SizeConstants.size17.r)
          .onTap(() {
        onTapObscure!(!isShowText!);
      });

  Set<void> _onValueSubmitted(String value) =>
      onFieldSubmitted != null ? {onFieldSubmitted!(value)} : {};

  void _onFieldTap() => onTap;
}
