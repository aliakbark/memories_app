import 'package:flutter/material.dart';
import 'package:memories_app/src/managers/memories.dart';
import 'package:memories_app/src/managers/object_factory.dart';

class AppState extends ChangeNotifier {
  bool isDarkModeOn = false;
  Locale _appLocale = Memories.defaultLocale;

  Locale get appLocal => _appLocale ?? Memories.defaultLocale;

  fetchLocale() async {
    _appLocale = ObjectFactory().prefs.getLocale;
    return true;
  }

  void updateTheme(bool isDarkModeOn) {
    this.isDarkModeOn = isDarkModeOn;
    notifyListeners();
  }
}
