import 'package:flutter/material.dart';

class BackgroundColorSelector {
  static MaterialColor selector(String color) {
    switch (color) {
      case 'amber':
        return Colors.amber;
      case 'blue':
        return Colors.blue;
      case 'green':
        return Colors.green;
      case 'purple':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }
}
