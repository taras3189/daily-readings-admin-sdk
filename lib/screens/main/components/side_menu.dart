import 'package:daily_readings_admin_sdk/controllers/global_controller.dart';
import 'package:daily_readings_admin_sdk/helpers/app_colors.dart';
import 'package:daily_readings_admin_sdk/services/auth.dart';
import 'package:daily_readings_admin_sdk/services/firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);
  static GlobalController globalController = Get.find();
  static FirestoreController firestore = Get.find();
  static AuthController auth = Get.find();

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Obx(
      () => (firestore.userDataModel.value.isVerified ||
              firestore.userDataModel.value.function == "App Admin")
          ? ListView(
              children: [
                DrawerHeader(
                    padding: EdgeInsets.zero,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.menu_book_rounded,
                          size: 50,
                          color: AppColors.kPrimaryColor,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Text('Daily Readings Admin SDK',
                              style: TextStyle(
                                fontSize: 20,
                              )),
                        ),
                      ],
                    )),
                DrawerListTile(
                  active: globalController.selectedIndex.value == 0,
                  title: "Home",
                  press: () {
                    globalController.selectedIndex.value = 0;
                  },
                ),
                DrawerListTile(
                  active: globalController.selectedIndex.value == 1,
                  title: "Users",
                  icon: Icons.people,
                  press: () {
                    globalController.selectedIndex.value = 1;
                  },
                ),
                DrawerListTile(
                  title: "Transaction",
                  icon: Icons.attach_money,
                  press: () {},
                ),
                DrawerListTile(
                  title: "Task",
                  icon: Icons.task,
                  press: () {},
                ),
                DrawerListTile(
                  title: "Documents",
                  icon: Icons.file_copy,
                  press: () {},
                ),
                DrawerListTile(
                  title: "Store",
                  icon: Icons.store,
                  press: () {},
                ),
                DrawerListTile(
                  title: "Notification",
                  icon: Icons.notifications,
                  press: () {},
                ),
                DrawerListTile(
                  title: "Profile",
                  icon: Icons.person,
                  press: () {},
                ),
                DrawerListTile(
                  title: "Settings",
                  icon: Icons.settings,
                  press: () {},
                ),
              ],
            )
          : ListView(
              children: [
                DrawerHeader(
                    padding: EdgeInsets.zero,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.menu_book_rounded,
                          size: 50,
                          color: AppColors.kPrimaryColor,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Text('Daily Readings Admin SDK',
                              style: TextStyle(
                                fontSize: 20,
                              )),
                        ),
                      ],
                    )),
                DrawerListTile(
                  title: "Logout",
                  icon: Icons.logout,
                  press: () async {
                    await auth.logOut();
                    Get.offAllNamed('/');
                  },
                ),
              ],
            ),
    ));
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    this.icon,
    required this.press,
    this.active = false,
  }) : super(key: key);
  static GlobalController globalController = Get.find();

  final String title;
  final IconData? icon;
  final VoidCallback press;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: Icon(
        icon ?? Icons.home,
        color: active ? Colors.white : Colors.white30,
      ),
      title: Text(
        title,
        style: TextStyle(
            color: active ? Colors.white : Colors.white30,
            fontWeight: active ? FontWeight.bold : FontWeight.normal),
      ),
    );
  }
}
