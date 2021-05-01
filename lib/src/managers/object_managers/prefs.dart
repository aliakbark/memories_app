import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:memories_app/src/managers/memories.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// shared preference storage
class Prefs {
  SharedPreferences? _sharedPreferences;

  static const String _IS_LOGGED_IN = "is_logged_in";
  static const String _USER_ID = "user_id";
  static const String _NETWORK_CONNECTION = "has_network_connection";
  static const String _AUTH_TOKEN = "auth_token";
  static const String _FCM_TOKEN = "fcm_token";
  static const String _USER_DATA = "user_data";

  static const String _APP_LOCALE = "app_locale";
  static const String _HAS_LANGUAGE_SET = "has_language_set";

  set sharedPreferences(SharedPreferences value) {
    _sharedPreferences = value;
  }

  /// for clearing the data in preference
  void clearPrefs() {
    _sharedPreferences?.clear();
  }

  bool get isLoggedIn => _sharedPreferences?.getBool(_IS_LOGGED_IN) ?? false;

  void setLoginStatus(bool loggedInStatus, {bool autoLogout = false}) async {
    await _sharedPreferences?.setBool(_IS_LOGGED_IN, loggedInStatus);
  }

  bool get hasNetworkConnection =>
      _sharedPreferences?.getBool(_NETWORK_CONNECTION) ?? false;

  void setNetworkConnectionStatus(bool hasNetworkConnection) async {
    await _sharedPreferences?.setBool(
        _NETWORK_CONNECTION, hasNetworkConnection);
  }

  String get getUserId => _sharedPreferences?.getString(_USER_ID) ?? '';

  void setUserId(String userId) async {
    await _sharedPreferences?.setString(_USER_ID, userId);
  }

  String get getAuthToken => _sharedPreferences?.getString(_AUTH_TOKEN) ?? '';

  void setAuthToken(String token) async {
    await _sharedPreferences?.setString(_AUTH_TOKEN, '$token');
  }

  String get getFCMToken => _sharedPreferences?.getString(_FCM_TOKEN) ?? '';

  void setFCMToken(String token) async {
    await _sharedPreferences?.setString(_FCM_TOKEN, '$token');
  }

  bool get hasLanguageSet =>
      _sharedPreferences?.getBool(_HAS_LANGUAGE_SET) ?? false;

  void setHasLanguageSet(bool value) async {
    await _sharedPreferences?.setBool(_HAS_LANGUAGE_SET, value);
  }

  Locale get getLocale {
    if (_sharedPreferences!.containsKey(_APP_LOCALE) &&
        (_sharedPreferences?.getString(_APP_LOCALE) ?? '').isNotEmpty) {
      Map<String, dynamic> _loc =
          jsonDecode(_sharedPreferences?.getString(_APP_LOCALE) ?? '');
      return Locale(
        _loc['languageCode'],
        _loc['countryCode'],
      );
    }
    return Memories.defaultLocale;
  }

  void setLocale(Locale locale) async {
    final _loc = {
      'languageCode': locale.languageCode,
      'countryCode': locale.countryCode
    };
    await _sharedPreferences?.setString(_APP_LOCALE, jsonEncode(_loc));
  }

// User get getUserData {
//   if (_sharedPreferences.containsKey(_USER_DATA) &&
//       _sharedPreferences.getString(_USER_DATA).isNotEmpty) {
//     Map<String, dynamic> _userData =
//         jsonDecode(_sharedPreferences.getString(_USER_DATA));
//     return User.fromJson(_userData);
//   }
//   return null;
// }
//
// void setUserData(User user) async {
//   await _sharedPreferences.setString(_USER_DATA, jsonEncode(user.toJson()));
// }
}
