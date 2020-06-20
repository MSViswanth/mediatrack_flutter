import 'package:flutter/material.dart';

enum theme {
  light,
  dark,
}

class SettingsProvider with ChangeNotifier {
  ThemeData _themeData;
  String _userName = 'User';
  bool _themeisdark = false;

  setUserName(String userName) {
    if (userName != null) _userName = userName;
    notifyListeners();
  }

  getUserName() => _userName;

  getTheme() => _themeData;
  setTheme(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  getThemeisDark() => _themeisdark;
  setThemeisDark() {
    if (_themeData == ThemeData.dark()) {
      _themeisdark = true;
    } else {
      _themeisdark = false;
    }
    notifyListeners();
  }

  switchTheme(value) {
    if (value) {
      _themeData = ThemeData.dark();
      setThemeisDark();
    } else {
      _themeData = ThemeData.light();
      setThemeisDark();
    }
    notifyListeners();
  }
}
