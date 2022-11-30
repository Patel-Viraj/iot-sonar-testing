import 'package:flutter/material.dart';

import 'base/extensions/scaffold_extension.dart';
import 'base/utils/localization/localization.dart';

class ComingSoonScreen extends StatelessWidget {
  const ComingSoonScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(Localization.of(context)!.comingSoon))
        .commonScaffold(
            context: context,
            appBarTitle: Localization.of(context)!.comingSoon,
            isCenterTitle: true,
            isBackVisible: false,
            isForComingSoon: true);
  }
}
