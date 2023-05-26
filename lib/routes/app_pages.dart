import 'package:daily_readings_admin_sdk/screens/login.dart';
import 'package:daily_readings_admin_sdk/screens/main/main_screen.dart';
import 'package:daily_readings_admin_sdk/screens/users/users_screen.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // ignore: constant_identifier_names
  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
        name: Routes.LOGIN,
        page: () => const LoginScreen(
              errMsg: '',
            )),
    GetPage(name: Routes.HOME, page: () => MainScreen()),
    GetPage(
        name: Routes.USERS,
        page: () => const UsersScreen(
              errMsg: '',
            )),
  ];
}
