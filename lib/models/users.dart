import 'package:daily_readings_admin_sdk/models/roles.dart';


class Users {
  late final int? id;
  late final String? email;
  late final String? password;
  late final String? fullname;
  late final String? phone;
  late final String? createdAt;
  late final String? updatedAt;
  late final Roles? roles;

  Users(
      {this.id,
      this.email,
      this.password,
      this.fullname,
      this.phone,
      this.createdAt,
      this.updatedAt,
      this.roles});

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
        id: json['id'] as int,
        email: json['email'] as String,
      password: json['password'] as String,
      fullname: json['fullname'] as String,
      phone: json['phone'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      roles: Roles.fromJson(json['roles'])
    );
  }

  @override
  String toString() {
    return 'Users{name: $fullname, email: $email}';
  }

}
