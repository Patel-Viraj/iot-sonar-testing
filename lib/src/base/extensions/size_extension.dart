import 'package:flutter/material.dart';

extension SizeExtension on BuildContext {
  /// Returns same as MediaQuery.of(context)
  MediaQueryData get mq => MediaQuery.of(this);

  double get getHeight => mq.size.height;

  double get getWidth => mq.size.width;
}
