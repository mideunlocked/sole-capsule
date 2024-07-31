import 'package:flutter/material.dart';

import '../services/save_share_preferences.dart';
import '../helpers/themes.dart';

class ThemeModeProvider with ChangeNotifier {
  bool _isLight = true;
  bool get isLight => _isLight;

  ThemeData _themeMode = AppThemes.lightMode;
  ThemeData get themeMode => _themeMode;

  void setInitThemeMode() async {
    _isLight = await SaveSharedPref.getThemeMode();

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

    if (_isLight == true) {
      _themeMode = AppThemes.lightMode;
      await SaveSharedPref.setThemeMode(true);
      setInitThemeMode();
    } else {
      _themeMode = AppThemes.darkMode;
      await SaveSharedPref.setThemeMode(false);
      setInitThemeMode();
    }

    notifyListeners();
  }

  void resetThemeMode() async {
    _isLight = true;
    _themeMode = AppThemes.lightMode;

    await SaveSharedPref.setThemeMode(true);
    setInitThemeMode();

    notifyListeners();
  }
}
