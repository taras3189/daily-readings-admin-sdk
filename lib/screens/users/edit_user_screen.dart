
import 'package:daily_readings_admin_sdk/helpers/slide_right_route.dart';
import 'package:daily_readings_admin_sdk/models/user/user_model.dart';
import 'package:daily_readings_admin_sdk/services/firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'user_details_screen.dart';
import 'users_screen.dart';

class EditUserScreen extends StatelessWidget {
  const EditUserScreen({Key? key, required this.users}) : super(key: key);
  final UserModel users;
  static const String _title = 'Edit User';

  @override
  Widget build(BuildContext context) {
    return StatefulEditUserWidget(users: users);
  }
}

class StatefulEditUserWidget extends StatefulWidget {
  const StatefulEditUserWidget({Key? key, required this.users})
      : super(key: key);
  final UserModel users;

  @override
  _EditUserWidgetState createState() => _EditUserWidgetState(users: users);
}

class _EditUserWidgetState extends State<StatefulEditUserWidget> {
  _EditUserWidgetState({required this.users});

  final UserModel users;
  final _editUserFormKey = GlobalKey<FormState>();
  int? _valRole;
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  FirestoreController firestore = Get.find();

  List<String> roles = [
    'App Admin',
    'Language Admin',
    'Group Admin',
    'User',
  ];

  @override
  void initState() {
    super.initState();

    // _valRole = users.roles!.id;
    _emailController.text = users.email.toString();
    _nameController.text = users.name.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 26, 255, 1)),
        title: const Text(
          'Edit User',
          style: TextStyle(
            height: 1.171875,
            fontSize: 18,
            fontFamily: 'Roboto Condensed',
            fontWeight: FontWeight.w500,
            color: Color.fromARGB(255, 26, 255, 1),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Color.fromARGB(255, 26, 255, 1)),
          onPressed: () => Navigator.pushReplacement(
              context, SlideRightRoute(page: UserDetailsScreen(users: users))),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _editUserFormKey,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(15, 80, 15, 20),
                child: Text(
                  'Please edit your role, email, password and name',
                  overflow: TextOverflow.visible,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    height: 1.171875,
                    fontSize: 18,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                child: InputDecorator(
                  decoration: const InputDecoration(
                    icon: Icon(
                      Icons.group_work,
                      color: Color.fromARGB(255, 0, 0, 0),
                      size: 24,
                    ),
                    fillColor: Color.fromARGB(255, 0, 0, 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 128, 255, 0), width: 1),
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      style: const TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0), fontSize: 24),
                      dropdownColor: const Color.fromARGB(255, 0, 0, 0),
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      isExpanded: true,
                      value: roles[_valRole ?? 0],
                      hint: const Text(
                        'Select Role',
                        style: TextStyle(
                          height: 1.171875,
                          fontSize: 24,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w300,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      items: roles.map((item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              height: 2.171875,
                              fontSize: 24,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w300,
                              color: Color.fromARGB(255, 26, 255, 1),
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _valRole = roles.indexOf(value!);
                        });
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                child: TextFormField(
                  controller: _emailController,
                  validator: (value) {
                    if (value == null) {
                      return 'Please enter your email';
                    } else {
                      return EmailValidator.validate(value)
                          ? null
                          : 'Please fill with the valid email';
                    }
                  },
                  onChanged: (value) {},
                  autocorrect: true,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    errorStyle:
                        TextStyle(color: Color.fromARGB(255, 26, 255, 1)),
                    fillColor: Color.fromARGB(255, 0, 0, 0),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 128, 255, 0), width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 128, 255, 0), width: 1),
                    ),
                    labelText: 'Email',
                    hintText: 'Email',
                    prefixIcon: Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Icon(
                        Icons.email,
                        color: Color.fromARGB(255, 128, 255, 0),
                        size: 24,
                      ),
                    ),
                    labelStyle: TextStyle(
                      height: 1.171875,
                      fontSize: 24,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w300,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                    hintStyle: TextStyle(
                      height: 1.171875,
                      fontSize: 24,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w300,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                    filled: true,
                  ),
                  style: const TextStyle(
                      color: Color.fromARGB(255, 128, 255, 0), fontSize: 24),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                child: TextFormField(
                  controller: _nameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  onChanged: (value) {},
                  autocorrect: true,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    errorStyle:
                        TextStyle(color: Color.fromARGB(255, 26, 255, 1)),
                    fillColor: Color.fromARGB(255, 0, 0, 0),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 128, 255, 0), width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 235, 235, 235), width: 1),
                    ),
                    labelText: 'Name',
                    hintText: 'Name',
                    prefixIcon: Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Icon(
                        Icons.perm_identity,
                        color: Color.fromARGB(255, 128, 255, 0),
                        size: 24,
                      ),
                    ),
                    labelStyle: TextStyle(
                      height: 1.171875,
                      fontSize: 24,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w300,
                      color: Color.fromARGB(255, 128, 255, 0),
                    ),
                    hintStyle: TextStyle(
                      height: 1.171875,
                      fontSize: 24,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w300,
                      color: Color.fromARGB(255, 128, 255, 0),
                    ),
                    filled: true,
                  ),
                  style: const TextStyle(
                      color: Color.fromARGB(255, 128, 255, 0), fontSize: 24),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                child: TextFormField(
                  controller: _nameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  onChanged: (value) {},
                  autocorrect: true,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    errorStyle:
                        TextStyle(color: Color.fromARGB(255, 26, 255, 1)),
                    fillColor: Color.fromARGB(255, 0, 0, 0),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 128, 255, 0), width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 235, 235, 235), width: 1),
                    ),
                    labelText: 'Nomor HP',
                    hintText: 'Nomor HP',
                    prefixIcon: Padding(
                      padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                      child: Icon(
                        Icons.perm_identity,
                        color: Color.fromARGB(255, 128, 255, 0),
                        size: 24,
                      ),
                    ),
                    labelStyle: TextStyle(
                        height: 1.171875,
                        fontSize: 24.0,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w300,
                        color: Color.fromARGB(255, 128, 255, 0)),
                    hintStyle: TextStyle(
                        height: 1.171875,
                        fontSize: 24.0,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w300,
                        color: Color.fromARGB(255, 128, 255, 0)),
                    filled: true,
                  ),
                  style: const TextStyle(
                      color: Color.fromARGB(255, 128, 255, 0), fontSize: 24.0),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: SizedBox(
                  height: 60.0,
                  width: MediaQuery.of(context).size.width * 1.0,
                  child: ElevatedButton.icon(
                    icon: const Icon(
                      Icons.login,
                      color: Color.fromARGB(255, 0, 0, 0),
                      size: 24.0,
                    ),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        side: const BorderSide(
                            color: Color.fromARGB(255, 128, 255, 0),
                            width: 1.0),
                      )),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 255, 200, 0)),
                    ),
                    onPressed: () async {
                      if (_editUserFormKey.currentState!.validate()) {
                        _editUserFormKey.currentState!.save();
                        EasyLoading.show();
                        firestore.updateUserById(users.uid, {
                          'name': _nameController.text,
                          'email': _emailController.text,
                          'function': roles[_valRole!],
                        });
                        EasyLoading.dismiss();
                        Navigator.pushReplacement(
                            context,
                            SlideRightRoute(
                                page: const UsersScreen(
                              errMsg: 'Updated Successfully',
                            )));
                        // var res = await api.updateUser(
                        //     users.id, _valRole!, _emailController.text, _nameController.text);

                        // switch (res.statusCode) {
                        //   case 200:

                        //     break;
                        //   case 400:
                        //     EasyLoading.dismiss();
                        //     var data = jsonDecode(res.body);
                        //     if (data["msg"] != null) {
                        //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        //         content: Text(data["msg"].toString()),
                        //       ));
                        //     }
                        //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        //       content: Text("Update Failed"),
                        //     ));
                        //     break;
                        //   case 403:
                        //     EasyLoading.dismiss();
                        //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        //       content: Text("Permission Denied"),
                        //     ));
                        //     break;
                        //   default:
                        //     EasyLoading.dismiss();
                        //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        //       content: Text("Update Failed"),
                        //     ));
                        //     break;
                        // }
                      }
                    },
                    label: const Text('UPDATE',
                        style: TextStyle(
                          height: 1.171875,
                          fontSize: 24.0,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 0, 0, 0),
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
