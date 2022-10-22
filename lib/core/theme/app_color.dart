import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AppColor {
  static const int primaryValue = 0xFFF57757;
  static const int secondaryValue = 0xFF416270;

  static Color primaryColor = const Color(primaryValue);
  static Color secondaryColor = const Color(secondaryValue);
  static Color white = const Color(0xFFFFFFFF);
  static Color black = const Color(0xFF000000);
  static Color blackGrey = const Color.fromARGB(255, 39, 39, 39);
  static Color backgroundBlack = const Color.fromARGB(255, 37, 37, 37);
  static Color backgroundWhite = const Color.fromARGB(255, 255, 255, 255);
  static Color backgroundGray = const Color.fromARGB(255, 240, 240, 240);

  static const MaterialColor primarySwatch =
      MaterialColor(primaryValue, <int, Color>{
    50: Color(0xFFFEEFEB),
    100: Color(0xFFFCD6CD),
    200: Color(0xFFFABBAB),
    300: Color(0xFFF8A089),
    400: Color(0xFFF78B70),
    500: Color(primaryValue),
    600: Color(0xFFF46F4F),
    700: Color(0xFFF26446),
    800: Color(0xFFF05A3C),
    900: Color(0xFFEE472C),
  });

  static const MaterialColor secondarySwatch =
      MaterialColor(secondaryValue, <int, Color>{
    50: Color(0xFFE8ECEE),
    100: Color(0xFFC6D0D4),
    200: Color(0xFFA0B1B8),
    300: Color(0xFF7A919B),
    400: Color(0xFF5E7A85),
    500: Color(secondaryValue),
    600: Color(0xFF3B5A68),
    700: Color(0xFF32505D),
    800: Color(0xFF2A4653),
    900: Color(0xFF1C3441),
  });
}
