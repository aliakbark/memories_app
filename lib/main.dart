import 'package:firebase_core/firebase_core.dart';
import 'package:authentication/authentication.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:memories_app/src/app.dart';
import 'package:memories_app/src/managers/object_factory.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:very_good_analysis/very_good_analysis.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final app = await Firebase.initializeApp();
  print('Initialized default app $app');

  await ObjectFactory().firebaseManager.init();

  // SystemChrome.setSystemUIOverlayStyle(
  //   const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
  // );

  //* Forcing only portrait orientation
  unawaited(SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]));

  await ObjectFactory().appManager.init();

  ///setting pref
  final sharedPreferences = await SharedPreferences.getInstance();
  ObjectFactory().setPrefs(sharedPreferences);

  LicenseRegistry.addLicense(() async* {
    final license =
        await rootBundle.loadString('assets/google_fonts/LICENSE.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  final authenticationRepository = AuthenticationRepository();

  runApp(App(
    authenticationRepository: authenticationRepository,
  ));
}
