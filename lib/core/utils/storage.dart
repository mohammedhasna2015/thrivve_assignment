import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static const _isLogin = '_isLogin';

  final SharedPreferences _preferences;
  Storage(this._preferences);
  void remove(String key) async {
    _preferences.remove(key);
  }

  void write(String key, dynamic value) async {
    if (value is String) {
      _preferences.setString(key, value);
    } else if (value is bool) {
      _preferences.setBool(key, value);
    } else if (value is int) {
      _preferences.setInt(key, value);
    } else if (value is double) {
      _preferences.setDouble(key, value);
    } else if (value is List<String>) {
      _preferences.setStringList(key, value);
    } else {
      debugPrint('not knowing type ');
    }
  }

  T? read<T>(String key) {
    return _preferences.get(key) as T?;
  }

  Future<void> erase({bool keepSettings = true}) async {
    final storage = await SharedPreferences.getInstance();
    storage.clear();
  }

  /// ======================================= start ================
}
