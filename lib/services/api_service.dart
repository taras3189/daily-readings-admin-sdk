import 'dart:convert';
import 'package:http/http.dart';
import 'package:http_interceptor/http/intercepted_client.dart';
import '../helpers/constant.dart';
import 'apiinterceptor.dart';



class ApiService {
  Client client = InterceptedClient.build(interceptors: [
    ApiInterceptor(),
  ]);

  Future<Response> getMyProfile() async {
    var myProfileUri = Uri.parse('${Constants.BASE_URL}/auth/user/me');
    final res = await client.get(myProfileUri);
    return res;
  }

}



