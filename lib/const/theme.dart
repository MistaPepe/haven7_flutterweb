import 'package:flutter/material.dart';

enum MyColors {
  blue,
  green,
  red;

  Color get color {
    switch (this) {
      case MyColors.blue:
        return Colors.blue;
      case MyColors.green:
        return Colors.green;
      case MyColors.red:
        return Colors.red;
    }
  }
}