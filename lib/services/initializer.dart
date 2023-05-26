import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../controllers/global_controller.dart';
import 'auth.dart';
import 'firebase_options.dart';

class Initializer {
  static Future<void> init() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(options: options);
      await _initStorage();
      _configLoading();
      _initScreenPreference();
      _initApis();
    } catch (err) {
      rethrow;
    }
  }

  static void _configLoading() {
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

  static void _initApis() async {
    final authController = AuthController();
    final globalCtrl = GlobalController();
    Get.put<AuthController>(
      authController,
    );
    Get.put<GlobalController>(
      globalCtrl,
    );
  }

  static Future<void> _initStorage() async {
    await GetStorage.init();
  }

  static void _initScreenPreference() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}
