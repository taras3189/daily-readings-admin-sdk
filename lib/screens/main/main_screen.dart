import 'package:daily_readings_admin_sdk/controllers/global_controller.dart';
import 'package:daily_readings_admin_sdk/screens/dashboard/dashboard_screen.dart';
import 'package:daily_readings_admin_sdk/screens/responsive.dart';
import 'package:daily_readings_admin_sdk/screens/users/users_screen.dart';
import 'package:daily_readings_admin_sdk/services/firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'components/side_menu.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);
  static GlobalController globalController = Get.find();
  static FirestoreController firestore = Get.find();
  final _widgetOptions = <Widget>[
    DashboardScreen(),
    UsersScreen(
      errMsg: '',
    ),
    // Record(),
    // Events(),
    // Alerts(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalController.scaffoldKey,
      drawer: const SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              const Expanded(
                child: SideMenu(),
              ),
            Expanded(
              flex: 5,
              child: Obx(
                () {
                  if (firestore.userDataModel.value.isVerified ||
                      firestore.userDataModel.value.function == "App Admin") {
                    return _widgetOptions
                        .elementAt(globalController.selectedIndex.value);
                  } else {
                    return  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('You logined as ${firestore.userDataModel.value.email}'),
                          const Text("You are not verified yet"),
                        ],
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
