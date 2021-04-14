import 'dart:convert';

import 'package:memories_app/src/managers/memories.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// shared preference storage
class Prefs {
  SharedPreferences _sharedPreferences;

  static const String _IS_LOGGED_IN = "is_logged_in";
  static const String _IS_DARK_MODE_ON = "is_dark_mode_on";
  static const String _PHONE = "phone";
  static const String _NETWORK_CONNECTION = "has_network_connection";
  static const String _AUTH_TOKEN = "auth_token";

  static const String _APP_LOCALE = "app_locale";
  static const String _HAS_LANGUAGE_SET = "has_language_set";

  Prefs();

  set sharedPreferences(SharedPreferences value) {
    _sharedPreferences = value;
  }

  /// for clearing the data in preference
  void clearPrefs() {
    _sharedPreferences.clear();
  }

  bool get isLoggedIn => _sharedPreferences.getBool(_IS_LOGGED_IN) ?? false;

  set isLoggedIn(bool loggedInStatus) {
    _sharedPreferences.setBool(_IS_LOGGED_IN, loggedInStatus);
  }

  bool get isDarkModeOn =>
      _sharedPreferences.getBool(_IS_DARK_MODE_ON) ?? false;

  set isDarkModeOn(bool darkMode) {
    _sharedPreferences.setBool(_IS_LOGGED_IN, darkMode);
  }

  bool get hasNetworkConnection =>
      _sharedPreferences.getBool(_NETWORK_CONNECTION) ?? false;

  set setNetworkConnectionStatus(bool hasNetworkConnection) {
    _sharedPreferences.setBool(_NETWORK_CONNECTION, hasNetworkConnection);
  }

  String get getPhone => _sharedPreferences.getString(_PHONE) ?? '';

  set setPhone(String phone) {
    _sharedPreferences.setString(_PHONE, phone);
  }

  void setAuthToken({String token}) {
    _sharedPreferences.setString(_AUTH_TOKEN, 'Token $token');
  }

  String get getAuthToken => _sharedPreferences.getString(_AUTH_TOKEN);

  bool get hasLanguageSet =>
      _sharedPreferences.getBool(_HAS_LANGUAGE_SET) ?? false;

  set hasLanguageSet(bool hasLanguageSet) {
    _sharedPreferences.setBool(_HAS_LANGUAGE_SET, hasLanguageSet);
  }

  Locale get getLocale {
    if (_sharedPreferences.containsKey(_APP_LOCALE) &&
        _sharedPreferences.getString(_APP_LOCALE).isNotEmpty) {
      Map<String, dynamic> _loc =
          jsonDecode(_sharedPreferences.getString(_APP_LOCALE));
      return Locale(
        _loc['languageCode'],
        _loc['countryCode'],
      );
    }
    return Memories.defaultLocale;
  }

  set setLocale(Locale locale) {
    Map<String, dynamic> _loc = {
      "languageCode": locale.languageCode == null
          ? Memories.defaultLocale.languageCode
          : locale.languageCode,
      "countryCode": locale == null
          ? Memories.defaultLocale.countryCode
          : locale.countryCode
    };
    _sharedPreferences.setString(_APP_LOCALE, jsonEncode(_loc));
  }
}
