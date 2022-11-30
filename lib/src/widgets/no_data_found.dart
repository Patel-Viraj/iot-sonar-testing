import 'package:flutter/material.dart';
import 'package:front_office/src/base/utils/constants/font_style.dart';
import 'package:nb_utils/nb_utils.dart';

import '../base/utils/constants/size_constants.dart';

class NoDataWidget extends StatelessWidget {
  final String? image;
  final String? title;
  const NoDataWidget({super.key, this.image, this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(image ?? ""),
        Text(
          title ?? "",
          style: FontStyle.helveticaRegularTextColor_14,
        ).paddingTop(SizeConstants.size20)
      ],
    ).paddingOnly(left: SizeConstants.size20, right: SizeConstants.size20);
  }
}
