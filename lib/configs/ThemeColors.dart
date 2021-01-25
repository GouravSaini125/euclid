import 'package:flutter/material.dart';

class ThemeColors {
  ThemeColors._();

  static const Color bg = Color(0xFFEFF3F6);
  static Color main = Colors.blue[900];

  static const Color shadowDark = Color.fromRGBO(0, 0, 0, 0.15);
  static const Color shadowLight = Colors.white;
  static Color shadowColored =
      Color.fromRGBO(main.red, main.green, main.blue, 0.5);

  static List<Color> gradient = [Color(0xFF396afc), Color(0xFF2948ff)];
  static List<Color> gradient1 = [Color(0xFF11998e), Color(0xFF38ef7d)];
  static List<Color> gradient2 = [Color(0xFFff9966), Color(0xFFff5e62)];
  static List<Color> gradient3 = [Color(0xFF00d2ff), Color(0xFF3a7bd5)];

  static List<Color> color = [
    Color(0xFFff6337),
    Color(0xFF46b3e6),
    Color(0xFFffdc34),
    Color(0xFF6decb9),
    Color(0xFFff9966),
    Color(0xFF5ca0d3),
    Color(0xFFff6337),
    Color(0xFF46b3e6)
  ];

  static List<List<Color>> gradientsList = [
    gradient,
    gradient1,
    gradient2,
    gradient3
  ];
}
