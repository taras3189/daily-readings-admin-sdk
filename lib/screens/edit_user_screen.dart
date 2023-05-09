import 'package:daily_readings_admin_sdk/services/api_service.dart';
import 'package:flutter/material.dart';
import '../models/users.dart';

class EditUserScreen  extends StatelessWidget {
  const EditUserScreen ({Key? key, required this.users}) : super(key: key);
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
  const StatefulEditUserWidget ({Key? key, required this.users}) : super(key: key);
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

}



















