import 'package:flutter/material.dart';

import 'color_constants.dart';
import 'size_constants.dart';

class FontStyle {
  static const TextStyle helveticaRegular = TextStyle(
      fontFamily: "Helvetica",
      fontWeight: SizeConstants.fontWeightMedium,
      color: ColorConstants.textFieldColor);
  static const TextStyle helveticaMedium = TextStyle(
      fontFamily: "Helvetica",
      fontWeight: SizeConstants.fontWeightSemiBold,
      color: ColorConstants.textFieldColor);
  static const TextStyle robotoRegular = TextStyle(
      fontFamily: "Roboto",
      fontWeight: SizeConstants.fontWeightRegular,
      color: ColorConstants.textFieldColor);

  //helvetica-regular
  static final helveticaRegularTextColor_32 = helveticaRegular.copyWith(
      fontSize: SizeConstants.fontSizeSp32, color: ColorConstants.textColor);
  static final poppinsRegularTextColor_16 =
      helveticaRegular.copyWith(fontSize: SizeConstants.fontSizeSp16);
  static final poppinsRegularTextColor_12 =
      helveticaRegular.copyWith(fontSize: SizeConstants.fontSizeSp12);
  static final poppinsRegularTextColor_13 =
      helveticaRegular.copyWith(fontSize: SizeConstants.fontSizeSp13);

  //regular-textColorDes
  static final helveticaRegularTextColorDes_16 = helveticaRegular.copyWith(
      fontSize: SizeConstants.fontSizeSp16, color: ColorConstants.textColorDes);
  static final helveticaRegularTextColorDes_12 = helveticaRegular.copyWith(
      fontSize: SizeConstants.fontSizeSp12, color: ColorConstants.textColorDes);
  static final helveticaRegularTextColorDes_10 = helveticaRegular.copyWith(
      fontSize: SizeConstants.fontSizeSp10, color: ColorConstants.textColorDes);

  //regular-textSearchColor
  static final helveticaRegularTextColorDes_14 = helveticaRegular.copyWith(
      fontSize: SizeConstants.fontSizeSp14,
      color: ColorConstants.textSearchColor);

  //regular-textBlueColor
  static final helveticaRegularTextBlueColor_10 = helveticaRegular.copyWith(
      fontSize: SizeConstants.fontSizeSp10,
      color: ColorConstants.textBlueColor);
  static final helveticaRegularTextBlueColor_12 = helveticaRegular.copyWith(
      fontSize: SizeConstants.fontSizeSp12,
      color: ColorConstants.textBlueColor);
  static final helveticaRegularTextBlueColor_14 = helveticaRegular.copyWith(
      fontSize: SizeConstants.fontSizeSp14,
      color: ColorConstants.textBlueColor);

  //regular-textGrayColor
  static final helveticaRegularTextGrayColor_14 = helveticaRegular.copyWith(
      fontSize: SizeConstants.fontSizeSp14,
      color: ColorConstants.textGrayColor);
  static final helveticaRegularTextGrayColor_12 = helveticaRegular.copyWith(
      fontSize: SizeConstants.fontSizeSp12,
      color: ColorConstants.textGrayColor);

  //regular-textColorHint
  static final helveticaRegularTextColorHint_16 = helveticaRegular.copyWith(
      fontSize: SizeConstants.fontSizeSp16,
      color: ColorConstants.textColorHint);

  //regular-textFieldColor
  static final helveticaRegularTextFieldColor_16 = helveticaRegular.copyWith(
      fontSize: SizeConstants.fontSizeSp16,
      color: ColorConstants.textFieldColor);

  //regular-textColor
  static final helveticaRegularTextColor_16 = helveticaRegular.copyWith(
      fontSize: SizeConstants.fontSizeSp16, color: ColorConstants.textColor);
  static final helveticaRegularTextColor_14 = helveticaRegular.copyWith(
      fontSize: SizeConstants.fontSizeSp14, color: ColorConstants.textColor);
  static final helveticaRegularTextColor_12 = helveticaRegular.copyWith(
      fontSize: SizeConstants.fontSizeSp12, color: ColorConstants.textColor);
  static final helveticaRegularTextColor_10 = helveticaRegular.copyWith(
      fontSize: SizeConstants.fontSizeSp10, color: ColorConstants.textColor);
  static final helveticaRegularTextColorUnderline_12 =
      helveticaRegular.copyWith(
          fontSize: SizeConstants.fontSizeSp12,
          color: ColorConstants.textColor,
          decoration: TextDecoration.underline,
          decorationColor: Colors.red,
          decorationThickness: 3);

  //regular-white
  static final helveticaRegularWhite_16 = helveticaRegular.copyWith(
      fontSize: SizeConstants.fontSizeSp16, color: ColorConstants.whiteColor);
  static final helveticaRegularWhite_14 = helveticaRegular.copyWith(
      fontSize: SizeConstants.fontSizeSp14, color: ColorConstants.whiteColor);
  static final helveticaRegularWhite_12 = helveticaRegular.copyWith(
      fontSize: SizeConstants.fontSizeSp12, color: ColorConstants.whiteColor);
  static final helveticaRegularWhite_10 = helveticaRegular.copyWith(
      fontSize: SizeConstants.fontSizeSp10, color: ColorConstants.whiteColor);

  //regular-green
  static final helveticaRegularGreen_16 = helveticaRegular.copyWith(
      fontSize: SizeConstants.fontSizeSp16,
      color: ColorConstants.greenPopUpColor);
  static final helveticaRegularGreen_10 = helveticaRegular.copyWith(
      fontSize: SizeConstants.fontSizeSp10,
      color: ColorConstants.textGreenColor);

  static final helveticaRegularRed_10 = helveticaRegular.copyWith(
      fontSize: SizeConstants.fontSizeSp10, color: ColorConstants.textRedColor);

  //regulat-red
  static final helveticaRegularRedColor_12 = helveticaRegular.copyWith(
      fontSize: SizeConstants.fontSizeSp12,
      color: ColorConstants.polygonRedColor);

  //regulat-lavendorColor
  static final helveticaRegulartextLavendorColorColor_12 =
      helveticaRegular.copyWith(
          fontSize: SizeConstants.fontSizeSp12,
          color: ColorConstants.textLavendorColor);

  //medium-textColor
  static final helveticaMediumTextColor_12 = helveticaMedium.copyWith(
      fontSize: SizeConstants.fontSizeSp12, color: ColorConstants.textColor);
  static final helveticaMediumTextColor_14 = helveticaMedium.copyWith(
      fontSize: SizeConstants.fontSizeSp14, color: ColorConstants.textColor);
  static final helveticaMediumTextColor_16 = helveticaMedium.copyWith(
      fontSize: SizeConstants.fontSizeSp16, color: ColorConstants.textColor);
  static final helveticaMediumTextColor_26 = helveticaMedium.copyWith(
      fontSize: SizeConstants.fontSizeSp26, color: ColorConstants.textColor);
  static final helveticaMediumTextColor_30 = helveticaMedium.copyWith(
      fontSize: SizeConstants.fontSizeSp30, color: ColorConstants.textColor);
  static final helveticaMediumTextColor_32 = helveticaMedium.copyWith(
      fontSize: SizeConstants.fontSizeSp32, color: ColorConstants.textColor);

  static final helveticaMediumWhiteColor_16 = helveticaMedium.copyWith(
      fontSize: SizeConstants.fontSizeSp16, color: ColorConstants.whiteColor);
  static final helveticaMediumWhiteColor_20 = helveticaMedium.copyWith(
      fontSize: SizeConstants.fontSizeSp20, color: ColorConstants.whiteColor);
  //medium-textBlue
  static final helveticaMediumBlueColor_12 = helveticaMedium.copyWith(
      fontSize: SizeConstants.fontSizeSp12,
      color: ColorConstants.textBlueColor);
  static final helveticaMediumBlueColor_14 = helveticaMedium.copyWith(
      fontSize: SizeConstants.fontSizeSp14,
      color: ColorConstants.textBlueColor);

  //medium-textFieldColor
  static final helveticaMediumTextFieldColor_16 = helveticaMedium.copyWith(
      fontSize: SizeConstants.fontSizeSp16,
      color: ColorConstants.textFieldColor);

  //medium-textColor
  static final helveticaMediumLavendorColorColor_12 = helveticaMedium.copyWith(
      fontSize: SizeConstants.fontSizeSp12,
      color: ColorConstants.textLavendorColor);
  //roboto-regular
  static final robotoRegularTextFieldColor_14 =
      robotoRegular.copyWith(fontSize: SizeConstants.fontSizeSp14);
}
