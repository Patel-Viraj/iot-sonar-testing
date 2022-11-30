import 'package:flutter/cupertino.dart';
import 'package:front_office/src/base/utils/constants/font_style.dart';
import 'package:nb_utils/nb_utils.dart';

// ignore: must_be_immutable
class CustomText extends StatelessWidget {
  String? title;
  String? subTitle;
  VoidCallback? callback;

  CustomText({super.key, this.title, this.subTitle, this.callback});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        // text: title,
        style: FontStyle.helveticaRegularTextColor_12,
        children: <TextSpan>[
          TextSpan(text: title, style: FontStyle.helveticaRegularTextColor_12),
          TextSpan(
              text: subTitle,
              style: FontStyle.helveticaRegularTextBlueColor_12),
          TextSpan(text: ".", style: FontStyle.helveticaRegularTextColor_12),
        ],
      ),
    ).onTap(() {
      callback!();
    });
  }
}
