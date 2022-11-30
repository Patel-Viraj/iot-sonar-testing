import 'package:flutter/material.dart';
import 'package:html/parser.dart';

import '../utils/constants/color_constants.dart';

extension StringExtension on String {
  String getInitials() => isNotEmpty
      ? trim().split(' ').map((e) => e[0]).take(1).join().toUpperCase()
      : '';

  Color hexToColor() => isEmpty
      ? ColorConstants.secondaryColor
      : Color(int.parse(replaceAll('#', "0xff")));

  String getContentFromHtml() =>
      parse(parse(this).body!.text).documentElement!.text;

  String twoDigits() => toString().padLeft(2, '0');

  String getHm() {
    final time = split(":");
    return "${time[0].twoDigits()}:${time[1].twoDigits()}";
  }

  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

extension ColorExtension on Color {
  String colorToHex() => "#${value.toRadixString(16).substring(2)}";
}

extension IntExtension on int {
  String twoDigits() => toString().padLeft(2, '0');
}
