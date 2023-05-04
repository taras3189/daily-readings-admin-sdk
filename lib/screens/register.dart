import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../services/auth.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  static const String _title = 'Register';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: StatefulRegisterWidget(),
    );
  }
}

class StatefulRegisterWidget extends StatefulWidget {
  const StatefulRegisterWidget({Key? key}) : super(key: key);

  @override
  State<StatefulRegisterWidget> createState() => _StatefulRegisterWidget();
}

class _StatefulRegisterWidget extends State<StatefulRegisterWidget> {
  final AuthService authService = AuthService();
  final storage = const FlutterSecureStorage();
  final _registerFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 52, 179, 16),
      body: SingleChildScrollView(
        child: Form(
          key: _registerFormKey,
          child: Column(
              children: [
          const Padding(
          padding: EdgeInsets.fromLTRB(15, 80, 15, 20),
          child: Text(
            'Please fill your email, password and name',
            overflow: TextOverflow.visible,
            textAlign: TextAlign.center,
            style: TextStyle(
              height: 1.171875,
              fontSize: 18.0,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
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
              }
              onChanged: (value)
          {},
          autocorrect: true,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            errorStyle: TextStyle(
              color: Color.fromARGB(255, 255, 234, 1),
            ),
            fillColor: Color.fromARGB(255, 0, 0, 0),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(
                color: Color.fromARGB(255, 128, 255, 0),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(
                color: Color.fromARGB(255, 128, 255, 0),
                width: 1,
              ),
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
            color: Color.fromARGB(255, 128, 255, 0),
            fontSize: 24,),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
        child: TextFormField(
            controller: _passwordController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your password';
              } else {
                return null;
              }
            }
            onChanged: (value) {},
        autocorrect: true,
        obscureText: true,
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
          errorStyle: TextStyle(
            color: Color.fromARGB(255, 26, 255, 1),
          ),
          fillColor: Color.fromARGB(255, 0, 0, 0),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(
              color: Color.fromARGB(255, 128, 255, 0),
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(
              color: Color.fromARGB(255, 235, 235, 235),
              width: 1,
            ),
          ),
          labelText: 'Password',
          hintText: 'Password',
          prefixIcon: Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Icon(
              Icons.password,
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
          color: Color.fromARGB(255, 235, 235, 235),
          fontSize: 24,),
      ),
          ),
      ],
    ),)
    ,
    )
    ,
    );
  }
}













