import 'package:daily_readings_admin_sdk/controllers/global_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);
  static GlobalController globalController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Obx(
      () => ListView(
        children: [
          DrawerHeader(
            child: Image.asset("../public/assets/images/logo.png"),
          ),
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
        icon??Icons.home,
        color:active ? Colors.white : Colors.white30,
      ),
      title: Text(
        title,
        style: TextStyle(
            color: Colors.white54,
            fontWeight: active ? FontWeight.bold : FontWeight.normal),
      ),
    );
  }
}
