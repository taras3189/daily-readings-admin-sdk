import 'package:daily_readings_admin_sdk/services/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/roles.dart';


class EditRoleScreen extends StatelessWidget {
  const EditRoleScreen({Key? key, required this.roles}) : super(key: key);
  final Roles roles;
  static const String _title = 'Edit Role';


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: StatefulEditRoleWidget(roles: roles),
    );
  }
}

class StatefulEditRoleWidget extends StatefulWidget {
  const StatefulEditRoleWidget({Key? key, required this.roles}) : super(key: key);

  @override
  _EditRoleWidgetState createState() => _EditRoleWidgetState(roles: roles);
}

class _EditRoleWidgetState extends State<StatefulEditRoleWidget> {

  _EditRoleWidgetState({required this.roles});
  final Roles roles;
  final ApiService api = ApiService();
  final _editRoleFormKey = GlobalKey<FormState>();
  final _roleNameController = TextEditingController();
  final _roleDesciptionController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
