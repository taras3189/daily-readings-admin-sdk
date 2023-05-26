import 'package:daily_readings_admin_sdk/screens/product/products_screen.dart';
import 'package:daily_readings_admin_sdk/screens/roles_screen.dart';
import 'package:daily_readings_admin_sdk/screens/users/users_screen.dart';
import 'package:daily_readings_admin_sdk/services/auth.dart';
import 'package:daily_readings_admin_sdk/services/firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../../helpers/slide_right_route.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key, required this.errMsg}) : super(key: key);
  final String errMsg;

  @override
  Widget build(BuildContext context) {
    return StatefulHomeWidget(
      errMsg: errMsg,
    );
  }
}

class StatefulHomeWidget extends StatefulWidget {
  const StatefulHomeWidget({Key? key, required this.errMsg}) : super(key: key);
  final String errMsg;

  @override
  // ignore: no_logic_in_create_state
  State<StatefulHomeWidget> createState() =>
      _StatefulHomeWidget(errMsg: errMsg);
}

class _StatefulHomeWidget extends State<StatefulHomeWidget> {
  _StatefulHomeWidget({required this.errMsg});
  final String errMsg;
  final storage = const FlutterSecureStorage();
  FirestoreController firestore = Get.find();
  final AuthController auth = AuthController();

  @override
  void initState() {
    super.initState();

    if (errMsg.isNotEmpty) {
      Future.delayed(Duration.zero, () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(errMsg),
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        iconTheme:
            const IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
        title: const Text(
          'Flutter Auth Role',
          style: TextStyle(
            height: 1.171875,
            fontSize: 18.0,
            fontFamily: 'Roboto Condensed',
            fontWeight: FontWeight.w500,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 71, 123, 171),
      ),
      drawer: Drawer(
        child: Container(
          color: const Color.fromARGB(255, 255, 255, 255),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 71, 123, 171),
                ),
                child: Center(
                  child: Text(
                    'MENU',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      height: 1.171875,
                      fontSize: 18.0,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    // left: BorderSide(
                    //     width: 6.0, color: Color.fromARGB(255, 0, 0, 0)),
                    bottom: BorderSide(
                        width: 0.5, color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                ),
                child: ListTile(
                  title: const Text(
                    'Users',
                    style: TextStyle(
                      height: 1.171875,
                      fontSize: 18.0,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        SlideRightRoute(
                            page: const UsersScreen(
                          errMsg: '',
                        )));
                  },
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    // left: BorderSide(
                    //     width: 6.0, color: Color.fromARGB(255, 0, 0, 0)),
                    bottom: BorderSide(
                        width: 0.5, color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                ),
                child: ListTile(
                  title: const Text(
                    'Roles',
                    style: TextStyle(
                      height: 1.171875,
                      fontSize: 18.0,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        SlideRightRoute(
                            page: const RolesScreen(
                          errMsg: '',
                        )));
                  },
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    // left: BorderSide(
                    //     width: 6.0, color: Color.fromARGB(255, 0, 0, 0)),
                    bottom: BorderSide(
                        width: 0.5, color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                ),
                child: ListTile(
                  title: const Text(
                    'Products',
                    style: TextStyle(
                      height: 1.171875,
                      fontSize: 18.0,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        SlideRightRoute(
                            page: const ProductsScreen(
                          errMsg: '',
                        )));
                  },
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    // left: BorderSide(
                    //     width: 6.0, color: Color.fromARGB(255, 0, 0, 0)),
                    bottom: BorderSide(
                        width: 0.5, color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                ),
                child: ListTile(
                  title: const Text(
                    'Logout',
                    style: TextStyle(
                      height: 1.171875,
                      fontSize: 18.0,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  onTap: () async {
                    await auth.logOut();
                    Get.offAllNamed('/');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: Obx(() => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var key in firestore.userDataModel.value.toJson().keys)
                  Text(
                    '$key: ${firestore.userDataModel.value.toJson()[key]}',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.visible,
                    style: const TextStyle(
                      height: 1.171875,
                      fontSize: 18.0,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
              ],
            )),
      ),
    );
  }
}
