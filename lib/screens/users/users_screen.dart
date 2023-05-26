import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_readings_admin_sdk/controllers/global_controller.dart';
import 'package:daily_readings_admin_sdk/screens/main/components/side_menu.dart';
import 'package:daily_readings_admin_sdk/screens/responsive.dart';
import 'package:daily_readings_admin_sdk/screens/users/user_details_screen.dart';
import 'package:daily_readings_admin_sdk/services/firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../helpers/slide_right_route.dart';
import '../../models/user/user_model.dart';
import 'add_user_screen.dart';
import '../home/home.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key, required this.errMsg}) : super(key: key);
  final String errMsg;
  static const String _title = 'User List';

  @override
  Widget build(BuildContext context) {
    return StatefulUsersWidget(errMsg: errMsg);
  }
}

class StatefulUsersWidget extends StatefulWidget {
  const StatefulUsersWidget({Key? key, required this.errMsg}) : super(key: key);
  final String errMsg;

  @override
  State<StatefulUsersWidget> createState() =>
      _StatefulUsersWidget(errMsg: errMsg);
}

class _StatefulUsersWidget extends State<StatefulUsersWidget> {
  _StatefulUsersWidget({required this.errMsg});

  final String errMsg;
  late List<UserModel> users = [];
  FirestoreController firestore = Get.find();

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

  Future<QuerySnapshot<UserModel>> get listUsers async {
    EasyLoading.show();
    return await firestore.getAllUsers();
  }

  static GlobalController globalController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       
        Expanded(
          flex: 5,
          child: Center(
            child: FutureBuilder(
              future: listUsers,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    EasyLoading.dismiss();
                    users = snapshot.data!.docs.map((e) => e.data()).toList();
                    return users.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: UserListWidget(users: users),
                          )
                        : const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              child: Text(
                                'No users found',
                                overflow: TextOverflow.visible,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  height: 1.171875,
                                  fontSize: 24,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w300,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                              ),
                            ),
                          );
                  }
                } else if (snapshot.hasError) {
                  EasyLoading.dismiss();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('${snapshot.error}'),
                  ));
                }
                return const Center(
                  child: Text(''''''),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class UserListWidget extends StatelessWidget {
  final List<UserModel> users;
  const UserListWidget({Key? key, required this.users}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.isEmpty ? 0 : users.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          child: Card(
            color: const Color.fromARGB(255, 255, 255, 255),
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                  color: Color.fromARGB(255, 0, 0, 0), width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          UserDetailsScreen(users: users[index])),
                );
              },
              child: ListTile(
                leading: const Icon(
                  Icons.person,
                  size: 48,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                title: Text(
                  users[index].function.toString(),
                  style: const TextStyle(
                    fontFamily: 'Roboto',
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                subtitle: Text(
                  users[index].email.toString(),
                  style: const TextStyle(
                    fontFamily: 'Roboto',
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
