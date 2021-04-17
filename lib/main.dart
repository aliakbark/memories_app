import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:memories_app/src/app.dart';
import 'package:memories_app/src/managers/object_factory.dart';
import 'package:memories_app/src/utilities/app_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FirebaseApp app = await Firebase.initializeApp();
  print('Initialized default app $app');

  ObjectFactory().firebaseManager.init();

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
  );

  //* Forcing only portrait orientation
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  ObjectFactory().appManager.init();

  ///setting pref
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  ObjectFactory().setPrefs(sharedPreferences);

  AppState appState = AppState();

  LicenseRegistry.addLicense(() async* {
    final license =
        await rootBundle.loadString('assets/google_fonts/LICENSE.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  runApp(App(appState: appState));
}
