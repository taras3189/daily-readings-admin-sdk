import 'package:daily_readings_admin_sdk/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'services/initializer.dart';

void main() async {
  await Initializer.init();
  runApp(const MyApp());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.wave
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = const Color.fromARGB(255, 71, 123, 171)
    ..backgroundColor = const Color.fromARGB(255, 0, 0, 0)
    ..indicatorColor = const Color.fromARGB(255, 71, 123, 171)
    ..textColor = const Color.fromARGB(255, 71, 123, 171)
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: EasyLoading.init(),
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home:  const LoginScreen(
        errMsg: '',
      ),
    );
  }
}

// ihorkharchyshyn@gmail.com
// color111