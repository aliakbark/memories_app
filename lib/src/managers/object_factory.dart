import 'package:memories_app/src/managers/api/api_service.dart';
import 'package:memories_app/src/managers/api/api_client.dart';
import 'package:memories_app/src/managers/object_managers/app_manager.dart';
import 'package:memories_app/src/managers/object_managers/firebase_manager.dart';
import 'package:memories_app/src/managers/object_managers/prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ObjectFactory {
  static final _objectFactory = ObjectFactory._internal();

  ObjectFactory._internal();

  factory ObjectFactory() => _objectFactory;

  ///Initialisation of Objects
  Prefs _prefs = Prefs();
  ApiService _apiService = ApiService();
  FirebaseManager _firebaseManager = FirebaseManager();
  AppManager _appManager = AppManager();

  ///
  /// Getter of Objects
  ///

  Prefs get prefs => _prefs;

  ApiService get apiService => _apiService;

  FirebaseManager get firebaseManager => _firebaseManager;

  AppManager get appManager => _appManager;

  ///
  /// Setter of Objects
  ///

  void setPrefs(SharedPreferences value) {
    _prefs.sharedPreferences = value;
  }
}
