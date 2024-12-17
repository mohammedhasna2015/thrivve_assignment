import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static const _isLogin = '_isLogin';
  static const _deviceToken = '_deviceToken';
  static const _userId = '_userId';
  static const _accessToken = '_accessToken';
  static const _emailUser = '_emailUser';
  static const _phoneUser = '_phoneUser';
  static const _nameUser = '_nameUser';

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

  bool get isLogin => read<bool>(_isLogin) ?? false;
  set isLogin(bool? newValue) => write(_isLogin, newValue);

  String get deviceToken => read<String>(_deviceToken) ?? '';
  set deviceToken(String? newValue) => write(_deviceToken, newValue);

  String get accessToken => read<String>(_accessToken) ?? '';
  set accessToken(String? newValue) => write(_accessToken, newValue);

  String get userId => read<String>(_userId) ?? '';
  set userId(String? newValue) => write(_userId, newValue);

  String get nameUser => read<String>(_nameUser) ?? '';
  set nameUser(String? newValue) => write(_nameUser, newValue);

  String get phoneUser => read<String>(_phoneUser) ?? '';
  set phoneUser(String? newValue) => write(_phoneUser, newValue);

  String get emailUser => read<String>(_emailUser) ?? '';
  set emailUser(String? newValue) => write(_emailUser, newValue);
}
