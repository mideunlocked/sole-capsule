import 'package:shared_preferences/shared_preferences.dart';

class SaveSharedPref {
  static Future<SharedPreferences> initSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs;
  }

  static Future<void> setThemeMode(bool themeMode) async {
    SharedPreferences prefs = await initSharedPref();

    await prefs.setBool('ThemeMode', themeMode);
  }

  static Future<bool> getThemeMode() async {
    SharedPreferences prefs = await initSharedPref();

    return prefs.getBool('ThemeMode') ?? true;
  }

  static Future<void> setBioAuth(bool enabled) async {
    SharedPreferences prefs = await initSharedPref();

    await prefs.setBool('bioAuth', enabled);
  }

  static Future<bool> getBioAuth() async {
    SharedPreferences prefs = await initSharedPref();

    return prefs.getBool('bioAuth') ?? true;
  }
}
