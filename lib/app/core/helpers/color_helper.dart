import 'dart:math';

import 'package:flutter/material.dart';

class ColorHelper {
  static Color get randomColor {
    var r = Random();
    return Color.fromRGBO(r.nextInt(256), r.nextInt(256), r.nextInt(256), 1);
  }
}
