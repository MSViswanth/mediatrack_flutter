import 'package:flutter/material.dart';

enum AppTheme { White, Dark, LightGreen, DarkGreen }

/// Returns enum value name without enum class name.
String enumName(AppTheme anyEnum) {
  return anyEnum.toString().split('.')[1];
}

final appThemeData = {
  AppTheme.White: ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.purple,
  ),
  AppTheme.Dark: ThemeData(
    brightness: Brightness.dark,
  ),
  AppTheme.LightGreen: ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.lightGreen,
  ),
  AppTheme.DarkGreen: ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.green,
  )
};

class SettingsProvider with ChangeNotifier {
  ThemeData _themeData;
  String _userName = 'User';

  setUserName(String userName) {
    if (userName != null) _userName = userName;
    notifyListeners();
  }

  getUserName() => _userName;

  /// Use this method on UI to get selected theme.
  ThemeData get themeData {
    if (_themeData == null) {
      _themeData = appThemeData[AppTheme.White];
    }
    return _themeData;
  }

  /// Sets theme and notifies listeners about change.
  setTheme(AppTheme theme) async {
    _themeData = appThemeData[theme];

    // Here we notify listeners that theme changed
    // so UI have to be rebuild
    notifyListeners();
  }
}
