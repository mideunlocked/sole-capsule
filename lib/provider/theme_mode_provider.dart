import 'package:flutter/material.dart';

import '../helpers/save_share_preferences.dart';
import '../helpers/themes.dart';

class ThemeModeProvider with ChangeNotifier {
  bool _isLight = true;
  bool get isLight => _isLight;

  ThemeData _themeMode = AppThemes.lightMode;
  ThemeData get themeMode => _themeMode;

  void setInitThemeMode() async {
    SaveSharedPref sharedPref = SaveSharedPref();

    _isLight = await sharedPref.getThemeMode();

    if (_isLight == true) {
      _themeMode = AppThemes.lightMode;
    } else {
      _themeMode = AppThemes.darkMode;
    }

    notifyListeners();
  }

  void toggleThemeMode() async {
    _isLight = !_isLight;

    notifyListeners();

    SaveSharedPref sharedPref = SaveSharedPref();

    if (_isLight == true) {
      _themeMode = AppThemes.lightMode;
      await sharedPref.setThemeMode(true);
      setInitThemeMode();
    } else {
      _themeMode = AppThemes.darkMode;
      await sharedPref.setThemeMode(false);
      setInitThemeMode();
    }

    notifyListeners();
  }

  void resetThemeMode() async {
    _isLight = true;
    _themeMode = AppThemes.lightMode;

    SaveSharedPref sharedPref = SaveSharedPref();

    await sharedPref.setThemeMode(true);
    setInitThemeMode();

    notifyListeners();
  }
}
