import 'package:flutter/material.dart';
import 'package:notes_app/theme/theme.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = lightmode;

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkMode;

  set themeData(ThemeData themeData) {
    _themeData = themeData;

    notifyListeners();
  }

  void toggleTheme() {
    if (themeData == lightmode) {
      themeData = darkMode;
    } else {
      themeData = lightmode;
    }
  }
}
