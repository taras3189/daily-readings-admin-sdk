
import 'package:daily_readings_admin_sdk/models/user/user_model.dart';
import 'package:daily_readings_admin_sdk/screens/users/users_screen.dart';
import 'package:daily_readings_admin_sdk/services/firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../helpers/slide_right_route.dart';
import 'edit_user_screen.dart';

class UserDetailsScreen extends StatelessWidget {
  const UserDetailsScreen({Key? key, required this.users}) : super(key: key);
  final UserModel users;

  static const String _title = 'Users';

  @override
  Widget build(BuildContext context) {
    return StatefulUserDetailsWidget(users: users);
  }
}

class StatefulUserDetailsWidget extends StatefulWidget {
  const StatefulUserDetailsWidget({Key? key, required this.users})
      : super(key: key);
  final UserModel users;

  @override
  _UserDetailsWidgetState createState() =>
      _UserDetailsWidgetState(users: users);
}

class _UserDetailsWidgetState extends State<StatefulUserDetailsWidget> {
  _UserDetailsWidgetState({required this.users});

  final UserModel users;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 26, 255, 1)),
        title: const Text(
          'User Details',
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
                  page: const UsersScreen(
                errMsg: '',
              ))),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Card(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: const Color.fromARGB(255, 255, 255, 255),
                border: Border.all(color: const Color.fromARGB(255, 0, 0, 0)),
              ),
              padding: const EdgeInsets.all(10),
              width: 440,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Column(
                      children: <Widget>[
                        Text('Name:',
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.8))),
                        Text(widget.users.function.toString(),
                            style: Theme.of(context).textTheme.titleMedium)
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Column(
                      children: <Widget>[
                        Text('Email:',
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.8))),
                        Text(widget.users.email.toString(),
                            style: Theme.of(context).textTheme.titleMedium)
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Column(
                      children: <Widget>[
                        Text('Role:',
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.8))),
                        Text(widget.users.function,
                            style: Theme.of(context).textTheme.titleMedium)
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          child: SizedBox(
                            height: 60,
                            width: MediaQuery.of(context).size.width * 1.0,
                            child: ElevatedButton.icon(
                              icon: const Icon(
                                Icons.edit,
                                color: Color.fromARGB(255, 255, 255, 255),
                                size: 24,
                              ),
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  // side: const BorderSide(
                                  //     color: Color.fromARGB(255, 128, 255, 0),
                                  //     width: 1.0),
                                )),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        const Color.fromARGB(255, 71, 123, 171)),
                              ),
                              onPressed: () async {
                                Navigator.pushReplacement(
                                    context,
                                    SlideRightRoute(
                                        page: EditUserScreen(
                                      users: users,
                                    )));
                              },
                              label: const Text('EDIT',
                                  style: TextStyle(
                                    height: 1.171875,
                                    fontSize: 24,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  )),
                            ),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            child: SizedBox(
                              height: 60,
                              width: MediaQuery.of(context).size.width * 1.0,
                              child: ElevatedButton.icon(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  size: 24,
                                ),
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    // side: const BorderSide(
                                    //     color: Color.fromARGB(255, 128, 255, 0),
                                    //     width: 1.0),
                                  )),
                                  backgroundColor: MaterialStateProperty.all<
                                          Color>(
                                      const Color.fromARGB(255, 71, 123, 171)),
                                ),
                                onPressed: () async {
                                  _confirmDialog(users.uid);
                                },
                                label: const Text('DELETE',
                                    style: TextStyle(
                                      height: 1.171875,
                                      fontSize: 24,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromARGB(255, 255, 255, 255),
                                    )),
                              ),
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _confirmDialog(uid) async {
    FirestoreController firestore = Get.find();
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Warning!'),
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Are you sure want delete this item?'),
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('Yes'),
                onPressed: () async {
                  EasyLoading.show();

                  await firestore.deleteAccount(uid);
                  EasyLoading.dismiss();
                  Navigator.pushReplacement(
                      context,
                      SlideRightRoute(
                          page: const UsersScreen(
                        errMsg: 'Deleted Successfully',
                      )));
                },
              ),
              ElevatedButton(
                child: const Text('No'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
