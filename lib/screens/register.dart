
import 'package:daily_readings_admin_sdk/services/auth.dart';
import 'package:daily_readings_admin_sdk/services/firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../helpers/slide_right_route.dart';
import 'login.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  static const String _title = 'Register';

  @override
  Widget build(BuildContext context) {
    return const StatefulRegisterWidget();
  }
}

class StatefulRegisterWidget extends StatefulWidget {
  const StatefulRegisterWidget({Key? key}) : super(key: key);

  @override
  State<StatefulRegisterWidget> createState() => _StatefulRegisterWidget();
}

class _StatefulRegisterWidget extends State<StatefulRegisterWidget> {
  // final AuthService authService = AuthService();
  final storage = const FlutterSecureStorage();
  final _registerFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  AuthController auth = Get.find();
  FirestoreController firestore = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
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
                        TextStyle(color: Color.fromARGB(255, 203, 12, 12)),
                    fillColor: Color.fromARGB(255, 255, 255, 255),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 71, 123, 171), width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 235, 235, 255), width: 1),
                    ),
                    labelText: 'Email',
                    hintText: 'Email',
                    prefixIcon: Padding(
                      padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                      child: Icon(
                        Icons.email,
                        color: Color.fromARGB(255, 71, 123, 171),
                        size: 24,
                      ),
                    ),
                    labelStyle: TextStyle(
                        height: 1.171875,
                        fontSize: 24.0,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w300,
                        color: Color.fromARGB(255, 71, 123, 171)),
                    hintStyle: TextStyle(
                        height: 1.171875,
                        fontSize: 24.0,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w300,
                        color: Color.fromARGB(100, 100, 100, 100)),
                    filled: true,
                  ),
                  style: const TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0), fontSize: 24.0),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                child: TextFormField(
                  controller: _passwordController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your password';
                    } else if (value.length < 6) {
                      return 'Minimum 6 characters';
                    }
                    return null;
                  },
                  onChanged: (value) {},
                  autocorrect: true,
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    errorStyle:
                        TextStyle(color: Color.fromARGB(255, 203, 12, 12)),
                    fillColor: Color.fromARGB(255, 255, 255, 255),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 71, 123, 171), width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 235, 235, 255), width: 1),
                    ),
                    labelText: 'Password',
                    hintText: 'Password',
                    prefixIcon: Padding(
                      padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                      child: Icon(
                        Icons.password,
                        color: Color.fromARGB(255, 71, 123, 171),
                        size: 24,
                      ),
                    ),
                    labelStyle: TextStyle(
                        height: 1.171875,
                        fontSize: 24.0,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w300,
                        color: Color.fromARGB(255, 71, 123, 171)),
                    hintStyle: TextStyle(
                        height: 1.171875,
                        fontSize: 24.0,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w300,
                        color: Color.fromARGB(100, 100, 100, 100)),
                    filled: true,
                  ),
                  style: const TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0), fontSize: 24.0),
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
                        TextStyle(color: Color.fromARGB(255, 203, 12, 12)),
                    fillColor: Color.fromARGB(255, 255, 255, 255),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 71, 123, 171), width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 235, 235, 255), width: 1),
                    ),
                    labelText: 'Name',
                    hintText: 'Name',
                    prefixIcon: Padding(
                      padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                      child: Icon(
                        Icons.perm_identity,
                        color: Color.fromARGB(255, 71, 123, 171),
                        size: 24,
                      ),
                    ),
                    labelStyle: TextStyle(
                        height: 1.171875,
                        fontSize: 24.0,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w300,
                        color: Color.fromARGB(255, 71, 123, 171)),
                    hintStyle: TextStyle(
                        height: 1.171875,
                        fontSize: 24.0,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w300,
                        color: Color.fromARGB(100, 100, 100, 100)),
                    filled: true,
                  ),
                  style: const TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0), fontSize: 24.0),
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
                      Icons.update,
                      color: Color.fromARGB(255, 255, 255, 255),
                      size: 24.0,
                    ),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        // side: const BorderSide(color: Color.fromARGB(255, 128, 255, 0), width: 1.0),
                      )),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 71, 123, 171)),
                    ),
                    onPressed: () async {
                      if (_registerFormKey.currentState!.validate()) {
                        _registerFormKey.currentState!.save();

                        var resultUid = await auth.registerWithEmail(
                            _emailController.text,
                            _passwordController.text,
                            (text) => {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(text),
                                  ))
                                });
                        if (resultUid == null) {
                          return;
                        }
                        await firestore.createUser(resultUid, {
                          'email': _emailController.text,
                          'name': _nameController.text,
                          'role': 'user',
                          'uid': resultUid,
                        });
                        Get.offAll(() => const LoginScreen(
                              errMsg: 'Registered Successfully',
                            ));

                        // var res = await authService.register(
                        //     _emailController.text, _passwordController.text, _nameController.text);

                        // switch (res!.statusCode) {
                        //   case 201:
                        //     EasyLoading.dismiss();
                        //     Navigator.push(
                        //         context, SlideRightRoute(page: const LoginScreen(errMsg: 'Registered Successfully',)));
                        //     break;
                        //   case 400:
                        //     EasyLoading.dismiss();
                        //     var data = jsonDecode(res.body);
                        //     if (data["msg"]) {
                        //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        //         content: Text(data["msg"].toString()),
                        //       ));
                        //     }
                        //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        //       content: Text("Registration Failed"),
                        //     ));
                        //     break;
                        //   default:
                        //     EasyLoading.dismiss();
                        //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        //       content: Text("Registration Failed"),
                        //     ));
                        //     break;
                        // }
                      }
                    },
                    label: const Text('REGISTER',
                        style: TextStyle(
                          height: 1.171875,
                          fontSize: 24.0,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 255, 255, 255),
                        )),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30),
                child: RichText(
                  text: TextSpan(
                    text: 'Already registered? ',
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w300,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                    children: <TextSpan>[
                      const TextSpan(
                          text: 'Login ',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w300,
                            color: Color.fromARGB(255, 0, 0, 0),
                          )),
                      TextSpan(
                          text: 'here ',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                  context,
                                  SlideRightRoute(
                                      page: const LoginScreen(
                                    errMsg: '',
                                  )));
                            },
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w700,
                            color: Color.fromARGB(255, 71, 123, 171),
                          )),
                    ],
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
