import 'package:flutter/material.dart';

extension ColorToHex on Color {
  String toHex({bool leadingHashSign = true}) {
    return '${leadingHashSign ? '#' : ''}'
        '${(alpha.toRadixString(16).padLeft(2, '0'))}'
        '${(red.toRadixString(16).padLeft(2, '0'))}'
        '${(green.toRadixString(16).padLeft(2, '0'))}'
        '${(blue.toRadixString(16).padLeft(2, '0'))}';
  }
}

extension HexToColor on String {
  Color toColor() {
    String hex = replaceAll('#', '');
    if (hex.length == 6) hex = 'FF$hex';
    return Color(int.parse(hex, radix: 16));
  }
}
