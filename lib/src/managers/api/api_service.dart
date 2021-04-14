import 'package:memories_app/src/managers/api/api_client.dart';

class ApiService {
  ApiClient _client;

  ApiService() {
    _client = ApiClient();
  }

  /// Login with OTP
// Future<dynamic> userLoginSignUp(LoginRequest loginRequest) {
//   return _client.dio.post(_client.apiUserLogin(), data: loginRequest);
// }
}
