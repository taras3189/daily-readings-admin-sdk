import 'dart:convert';

import 'package:daily_readings_admin_sdk/screens/user_details_screen.dart';
import 'package:daily_readings_admin_sdk/services/api_service.dart';
import 'package:flutter/material.dart';
import '../models/users.dart';

class EditUserScreen extends StatelessWidget {
  const EditUserScreen({Key? key, required this.users}) : super(key: key);
  final Users users;
  static const String _title = 'Edit User';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: StatefulEditUserWidget(users: users),
    );
  }
}

class StatefulEditUserWidget extends StatefulWidget {
  const StatefulEditUserWidget({Key? key, required this.users})
      : super(key: key);
  final Users users;

  @override
  _EditUserWidgetState createState() => _EditUserWidgetState(users: users);
}

class _EditUserWidgetState extends State<StatefulEditUserWidget> {
  _EditUserWidgetState({required this.users});

  final Users users;
  List<dynamic> roles = [];
  final ApiService api = ApiService();
  final _editUserFormKey = GlobalKey<FormState>();
  int? _valRole;
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();

  void loadRolesList() async {
    final resp = await api.getRoleList();
    setState(() {
      roles = jsonDecode(resp.body);
    });
  }

  @override
  void initState() {
    super.initState();
    loadRolesList();
    _valRole = users.roles!.id;
    _emailController.text = users.email.toString();
    _nameController.text = users.fullname.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 252, 142, 54),
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
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
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
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
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
                      value: _valRole,
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
                            child: Text(
                              item['role_name'],
                              style: const TextStyle(
                                height: 2.171875,
                                fontSize: 24,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w300,
                                color: Color.fromARGB(255, 26, 255, 1),
                              ),
                            ),
                          value: item['id'],
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _valRole = value as int;
                        });
                      },
                    ),
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


























