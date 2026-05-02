import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static final _sharedPrefs = SharedPreferencesAsync();

  static Future<void> setData(String key, dynamic value) async {
    if (value is int) {
      await _sharedPrefs.setInt(key, value);
    } else if (value is double) {
      await _sharedPrefs.setDouble(key, value);
    } else if (value is bool) {
      await _sharedPrefs.setBool(key, value);
    } else if (value is String) {
      await _sharedPrefs.setString(key, value);
    } else if (value is List<String>) {
      await _sharedPrefs.setStringList(key, value);
    } else {
      throw 'The value type (${value.runtimeType}) is incompatible';
    }
  }

  static Future<int?> getInt(String key) async {
    return await _sharedPrefs.getInt(key);
  }

  static Future<double?> getDouble(String key) async {
    return await _sharedPrefs.getDouble(key);
  }

  static Future<bool?> getBool(String key) async {
    return await _sharedPrefs.getBool(key);
  }

  static Future<String?> getString(String key) async {
    return await _sharedPrefs.getString(key);
  }

  static Future<List<String>?> getStringList(String key) async {
    return await _sharedPrefs.getStringList(key);
  }

  static Future<void> removeData(String key) async {
    await _sharedPrefs.remove(key);
  }
}
