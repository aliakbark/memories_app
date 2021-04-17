import 'package:flutter/material.dart';

class Memories {
  static const String app_name = "Delo Seeker";
  static const String app_version = "Version 1.0.0";
  static const int app_version_code = 1;
  static const String app_color = "#ffd7167";
  static Color primaryAppColor = Colors.green;
  static Color secondaryAppColor = Colors.white;
  static const String google_sans_family = "GoogleSans";
  static bool isDebugMode = false;
  static const int OTP_RESEND_DURATION = 30;

  // * Url related
  static String baseUrl = "https://memories.com/";

  static const Locale defaultLocale = Locale('en', 'IN');
  static const List<Locale> supportedLocales = [
    Locale('en', 'IN'),
  ];
  static String languageJsonFilePath = 'i18n/';

  /// FCM topics
  static String memoriesMobile = 'memories_mobile';
}
