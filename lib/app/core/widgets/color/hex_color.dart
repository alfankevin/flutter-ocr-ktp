import 'package:flutter/material.dart';

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    RegExp regex = RegExp(r'[0-9a-fA-F]');
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6 && regex.hasMatch(hexColor)) {
      hexColor = 'FF$hexColor';
    } else {
      // default white color
      hexColor = 'FFFFFFFF';
    }
    return int.parse(hexColor, radix: 16);
  }
}
