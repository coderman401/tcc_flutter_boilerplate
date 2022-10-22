import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static final SharedPreferencesService _sharedPreferencesService =
      SharedPreferencesService._internal();

  factory SharedPreferencesService() {
    return _sharedPreferencesService;
  }

  SharedPreferencesService._internal();

  Future<dynamic> getData(String key) async {
    final sharedPref = await SharedPreferences.getInstance();
    final data = sharedPref.get(key);
    return data ?? '';
  }

  Future<bool> setData(String key, dynamic value) async {
    final sharedPref = await SharedPreferences.getInstance();
    if (value is int) {
      return sharedPref.setInt(key, value);
    } else if (value is double) {
      return sharedPref.setDouble(key, value);
    } else if (value is String) {
      return sharedPref.setString(key, value);
    } else if (value is bool) {
      return sharedPref.setBool(key, value);
    } else {
      return sharedPref.setString(key, value);
    }
  }

  Future<bool> remove(String key) async {
    final sharedPref = await SharedPreferences.getInstance();
    return sharedPref.remove(key);
  }

  Future<dynamic> removeAll() async {
    final sharedPref = await SharedPreferences.getInstance();
    final keys = sharedPref.getKeys();
    if (keys.isNotEmpty) {
      for (var key in keys) {
        sharedPref.remove(key);
      }
    }
  }
}
