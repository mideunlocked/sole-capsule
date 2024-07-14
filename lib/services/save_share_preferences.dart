import 'package:shared_preferences/shared_preferences.dart';

class SaveSharedPref {
  Future<SharedPreferences> initSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs;
  }

  Future<void> setThemeMode(bool themeMode) async {
    SharedPreferences prefs = await initSharedPref();

    await prefs.setBool('ThemeMode', themeMode);
  }

  Future<bool> getThemeMode() async {
    SharedPreferences prefs = await initSharedPref();

    return prefs.getBool('ThemeMode') ?? true;
  }
}
