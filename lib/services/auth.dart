import 'package:http/http.dart';
import '../helpers/constant.dart';

class AuthService {
  var loginUri = Uri.parse('${Constants.BASE_URL}/auth/signin');
  var registerUri = Uri.parse('${Constants.BASE_URL}/auth/signup');

  Future<Response?> login(String username, String password) async {
    var res = await post(loginUri, body: {
      "username": username,
      "password": password,
    });
    return res;
  }

  Future<Response?> register(String username, String password, String fullname,
      String phone, String nik) async {
    var res = await post(registerUri, body: {
      "username": username,
      "password": password,
      "fullname": fullname,
      "phone": phone,
    });
    return res;
  }
}