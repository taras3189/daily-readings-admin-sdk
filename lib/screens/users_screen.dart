import 'dart:convert';

import 'package:daily_readings_admin_sdk/models/users.dart';
import 'package:daily_readings_admin_sdk/screens/user_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart';
import '../helpers/slide_right_route.dart';
import '../services/api_service.dart';
import 'add_user_screen.dart';
import 'home.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key, required this.errMsg}) : super(key: key);
  final String errMsg;
  static const String _title = 'User List';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: StatefulUsersWidget(errMsg: errMsg),
    );
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
  final ApiService api = ApiService();
  late List<Users> users = [];

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

  Future<Response> get listUsers async {
    EasyLoading.show();
    return await api.getUserList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 26, 255, 1)),
        title: const Text(
          'Users',
          style: TextStyle(
            height: 1.171875,
            fontSize: 18,
            fontFamily: 'Roboto Condensed',
            fontWeight: FontWeight.w500,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 71, 123, 171),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Color.fromARGB(255, 255, 255, 255)),
          onPressed: () => Navigator.pushReplacement(
              context,
              SlideRightRoute(
                  page: const HomeScreen(
                errMsg: '',
              ))),
        ),
      ),
      body: Center(
        child: FutureBuilder(
          future: listUsers,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Response resp = snapshot.data as Response;
              if (resp.statusCode == 200) {
                EasyLoading.dismiss();
                final jsonMap = json.decode(resp.body);
                users = (jsonMap as List)
                    .map((userItem) => Users.fromJson(userItem))
                    .toList();
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
              } else if (resp.statusCode == 401) {
                EasyLoading.dismiss();
                Future.delayed(Duration.zero, () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen(
                                errMsg: 'Permission Denied',
                              )));
                });
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddUserScreen()));
        },
        tooltip: 'Increment',
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class UserListWidget extends StatelessWidget {
  final List<Users> users;

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
                  users[index].fullname.toString(),
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
