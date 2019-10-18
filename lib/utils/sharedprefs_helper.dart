import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  static SharedPrefsHelper _instance = SharedPrefsHelper.internal();

  SharedPrefsHelper.internal();

  factory SharedPrefsHelper() => _instance;
  static SharedPreferences _prefsInstance;

  static Future<void> init() async {
    _prefsInstance = await SharedPreferences.getInstance();
  }

  static String getString(String key) {
    return _prefsInstance.getString(key) ?? "";
  }

  static Future<bool> setString(String key, String value) async {
    return _prefsInstance?.setString(key, value);
  }

  static int getInt(String key) {
    return _prefsInstance.getInt(key) ?? 0;
  }

  static Future<bool> setInt(String key, int value) async {
    return _prefsInstance?.setInt(key, value);
  }

  static void dispose() {
    _prefsInstance = null;
    _instance = null;
  }
}
