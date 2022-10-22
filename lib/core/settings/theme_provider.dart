import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tcc_flutter_boilerplate/core/services/shared_preferences_service.dart';

const Color m3BaseColor = Color(0xff6750a4);
const List<Color> colorOptions = [
  m3BaseColor,
  Colors.blue,
  Colors.teal,
  Colors.green,
  Colors.yellow,
  Colors.orange,
  Colors.pink
];
const List<String> colorText = <String>[
  "M3 Baseline",
  "Blue",
  "Teal",
  "Green",
  "Yellow",
  "Orange",
  "Pink",
];

class DarkThemeProvider with ChangeNotifier {
  final SharedPreferencesService _preferencesService =
      SharedPreferencesService();
  bool _darkTheme = false;
  bool _useMaterial3 = true;
  int _colorSelected = 2;
  late ThemeData _themeData;
  late Color _dynamicColor;

  DarkThemeProvider() {
    _dynamicColor = colorOptions[_colorSelected];
    _themeData = _updateThemes(_dynamicColor, _useMaterial3, _darkTheme);
  }

  static const _themeMode = "THEME_MODE";

  ThemeData get themeData => _themeData;
  bool get darkTheme => _darkTheme;

  set darkTheme(bool value) {
    _darkTheme = value;
    _preferencesService.setData(_themeMode, value);
    themeData = _updateThemes(_dynamicColor, _useMaterial3, _darkTheme);
    notifyListeners();
  }

  set useMaterial3(bool value) {
    _useMaterial3 = value;
    themeData = _updateThemes(_dynamicColor, _useMaterial3, _darkTheme);
    notifyListeners();
  }

  set colorSelected(int value) {
    _colorSelected = value;
    _dynamicColor = colorOptions[_colorSelected];
    themeData =
        _updateThemes(colorOptions[_colorSelected], _useMaterial3, _darkTheme);
    notifyListeners();
  }

  set themeData(ThemeData value) {
    _themeData = value;
    notifyListeners();
  }

  Future<void> getThemeData() {
    return _preferencesService.getData(_themeMode).then((value) {
      darkTheme = value == '' ? false : value;
      themeData =
          _updateThemes(colorOptions[_colorSelected], _useMaterial3, darkTheme);
    });
    // Color dynamicColor = await _getDynamicColorPallette();
  }

  ThemeData _updateThemes(Color color, bool useMaterial3, bool darkTheme) {
    return ThemeData(
      colorSchemeSeed: color,
      useMaterial3: useMaterial3,
      brightness: darkTheme ? Brightness.dark : Brightness.light,
    );
  }

  // Future<dynamic> _getDynamicColorPallette() {
  //   try {
  //     return DynamicColorPlugin.getCorePalette()
  //         .then((corePallet) => corePallet?.primary);
  //   } on PlatformException {
  //     return Future.value(null);
  //   }
  // }
}
