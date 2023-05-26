import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_readings_admin_sdk/controllers/global_controller.dart';
import 'package:daily_readings_admin_sdk/helpers/app_colors.dart';
import 'package:daily_readings_admin_sdk/screens/users/user_details_screen.dart';
import 'package:daily_readings_admin_sdk/services/firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../models/user/user_model.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key, required this.errMsg}) : super(key: key);
  final String errMsg;

  @override
  State<UsersScreen> createState() => _UsersScreen(errMsg: errMsg);
}

class _UsersScreen extends State<UsersScreen> {
  _UsersScreen({required this.errMsg});

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
  UserListWidget({Key? key, required this.users}) : super(key: key);

  FirestoreController firestore = Get.find();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.isEmpty ? 0 : users.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          child: Card(
            color: AppColors.secondaryColor,
            shape: RoundedRectangleBorder(
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
              child: Row(
                children: [
                  Expanded(
                    child: ListTile(
                      leading: const Icon(
                        Icons.person,
                        size: 48,
                        color: Colors.white,
                      ),
                      title: Text(
                        users[index].function.toString(),
                        style: const TextStyle(
                          fontFamily: 'Roboto',
                          color: Colors.white,
                        ),
                      ),
                      subtitle: Text(
                        users[index].email.toString(),
                        style: const TextStyle(
                          fontFamily: 'Roboto',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () => {
                            firestore.updateUserById(users[index].uid,
                                {'isVerified': !users[index].isVerified})

                            //  firebase
                          },
                      icon: Icon(
                        Icons.verified_outlined,
                        color: users[index].isVerified
                            ? AppColors.kPrimaryColor
                            : Colors.white,
                      )),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
