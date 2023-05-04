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

//_________________________________________________________________

  Future<Response> getUserList() async {
    var userUrl = Uri.parse('${Constants.BASE_URL}/users');
    final res = await client.get(userUrl);
    return res;
  }

  Future<Response> getUserLById(String id) async {
    var userUrl = Uri.parse('${Constants.BASE_URL}/users/$id');
    final res = await client.get(userUrl);
    return res;
  }

  Future<Response> addUser(int roleId, String email, String password,
      String fullname, String phone) async {
    var userUrl = Uri.parse('${Constants.BASE_URL}/users');
    final res = await client.post(userUrl, body: {
      "role_id": roleId.toString(),
      "email": email,
      "password": password,
      "fullname": fullname,
      "phone": phone,
    });
    return res;
  }

  Future<Response> updateUser(
      int? id, int roleId, String email, String fullname, String phone) async {
    var userUrl = Uri.parse('${Constants.BASE_URL}/users/$id');
    final res = await client.put(userUrl, body: {
      "role_id": roleId.toString(),
      "email": email,
      "fullname": fullname,
      "phone": phone,
    });
    return res;
  }

  Future<Response> deleteUser(String id) async {
    var userUrl = Uri.parse('${Constants.BASE_URL}/users/$id');
    final res = await client.delete(userUrl);
    return res;
  }

//_________________________________________________________________


  Future<Response> getRoleList() async {
    var rolerUrl = Uri.parse('${Constants.BASE_URL}/roles');
    final res = await client.get(rolerUrl);
    return res;
  }

  Future<Response> getRoleById(String id) async {
    var rolerUrl = Uri.parse('${Constants.BASE_URL}/roles/$id');
    final res = await client.get(rolerUrl);
    return res;
  }

  Future<Response> addRole(String roleName, String roleDescription) async {
    var rolerUrl = Uri.parse('${Constants.BASE_URL}/roles');
    final res = await client.post(rolerUrl,
        body: {"role_name": roleName, "role_description": roleDescription});
    return res;
  }

  Future<Response> updateRole(
      int? id, String roleName, String roleDescription) async {
    var rolerUrl = Uri.parse('${Constants.BASE_URL}/roles/$id');
    final res = await client.put(rolerUrl,
        body: {"role_name": roleName, "role_description": roleDescription});
    return res;
  }

  Future<Response> deleteRole(String id) async {
    var rolerUrl = Uri.parse('${Constants.BASE_URL}/roles/$id');
    final res = await client.delete(rolerUrl);
    return res;
  }

  Future<Response> addPermissiontoRole(int? id, List<int?> permissions) async {
    var permissionUrl =
    Uri.parse('${Constants.BASE_URL}/roles/permissions/$id');
    final res =
    await client.post(permissionUrl, body: {"permissions": jsonEncode(permissions)});
    return res;
  }

//_________________________________________________________________

  Future<Response> getProductList() async {
    var productUrl = Uri.parse('${Constants.BASE_URL}/products');
    final res = await client.get(productUrl);
    return res;
  }

  Future<Response> getProductById(String id) async {
    var productUrl = Uri.parse('${Constants.BASE_URL}/products/$id');
    final res = await client.get(productUrl);
    return res;
  }

  Future<Response> addProduct(String prodName, String prodDescription,
      String prodImage, String prodPrice) async {
    var productUrl = Uri.parse('${Constants.BASE_URL}/products');
    final res = await client.post(productUrl, body: {
      "prod_name": prodName,
      "prod_description": prodDescription,
      "prod_image": prodImage,
      "prod_price": prodPrice
    });
    return res;
  }

  Future<Response> updateProduct(int? id, String prodName,
      String prodDescription, String prodImage, String prodPrice) async {
    var productUrl = Uri.parse('${Constants.BASE_URL}/products/$id');
    final res = await client.put(productUrl, body: {
      "prod_name": prodName,
      "prod_description": prodDescription,
      "prod_image": prodImage,
      "prod_price": prodPrice
    });
    return res;
  }

  Future<Response> deleteProduct(String id) async {
    var productUrl = Uri.parse('${Constants.BASE_URL}/products/$id');
    final res = await client.delete(productUrl);
    return res;
  }

}
