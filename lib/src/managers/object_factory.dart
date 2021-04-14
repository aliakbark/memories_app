import 'package:memories_app/src/managers/api/api_service.dart';
import 'package:memories_app/src/managers/api/api_client.dart';
import 'package:memories_app/src/managers/prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ObjectFactory {
  static final _objectFactory = ObjectFactory._internal();

  ObjectFactory._internal();

  factory ObjectFactory() => _objectFactory;

  ///Initialisation of Objects
  Prefs _prefs = Prefs();
  ApiService _apiService = ApiService();

  ///
  /// Getter of Objects
  ///

  Prefs get prefs => _prefs;

  ApiService get apiService => _apiService;

  ///
  /// Setter of Objects
  ///

  void setPrefs(SharedPreferences value) {
    _prefs.sharedPreferences = value;
  }
}
