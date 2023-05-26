import 'package:daily_readings_admin_sdk/helpers/app_colors.dart';
import 'package:daily_readings_admin_sdk/services/auth.dart';
import 'package:daily_readings_admin_sdk/services/firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import '../../helpers/slide_right_route.dart';
import 'register.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key, required this.errMsg}) : super(key: key);
  final String errMsg;

  @override
  Widget build(BuildContext context) {
    return StatefulLoginWidget(
      errMsg: errMsg,
    );
  }
}

class StatefulLoginWidget extends StatefulWidget {
  const StatefulLoginWidget({Key? key, required this.errMsg}) : super(key: key);
  final String errMsg;

  @override
  State<StatefulLoginWidget> createState() =>
      _StatefulLoginWidget(errMsg: errMsg);
}

class _StatefulLoginWidget extends State<StatefulLoginWidget> {
  _StatefulLoginWidget({required this.errMsg});
  final String errMsg;
  // final AuthService authService = AuthService();
  final storage = const FlutterSecureStorage();
  final _loginFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  FirestoreController firestore = Get.find();
  bool isLoading = false;
  AuthController auth = Get.find();

  void checkIfLogined() async {
    if (auth.getUID() != null && auth.getUID() != '') {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.toNamed('/home');
      });
    }
  }

  @override
  void initState() {
    checkIfLogined();

    super.initState();
    if (errMsg.isNotEmpty) {
      Future.delayed(Duration.zero, () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(errMsg),
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _loginFormKey,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: 700,
              ),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(15, 80, 15, 20),
                    child: Text(
                      'Please login to enter the app!',
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        height: 1.171875,
                        fontSize: 18.0,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
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
                        fillColor: AppColors.secondaryColor,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide:
                              BorderSide(color: AppColors.kPrimaryColor, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 235, 235, 235), width: 1),
                        ),
                        labelText: 'Email',
                        hintText: 'Email',
                        prefixIcon: Padding(
                          padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                          child: Icon(
                            Icons.email,
                            color: AppColors.kPrimaryColor,
                            size: 24,
                          ),
                        ),
                        labelStyle: TextStyle(
                            height: 1.171875,
                            fontSize: 24.0,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w300,
                            color: AppColors.kPrimaryColor),
                        hintStyle: TextStyle(
                            height: 1.171875,
                            fontSize: 24.0,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w300,
                            color: Color.fromARGB(100, 100, 100, 100)),
                        filled: true,
                      ),
                      style: const TextStyle(fontSize: 24.0),
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
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {},
                      autocorrect: true,
                      obscureText: true,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        errorStyle:
                            TextStyle(color: Color.fromARGB(255, 203, 12, 12)),
                        fillColor: AppColors.secondaryColor,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide:
                              BorderSide(color: AppColors.kPrimaryColor, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 235, 235, 235), width: 1),
                        ),
                        labelText: 'Password',
                        hintText: 'Password',
                        prefixIcon: Padding(
                          padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                          child: Icon(
                            Icons.password,
                            color: AppColors.kPrimaryColor,
                            size: 24,
                          ),
                        ),
                        labelStyle: TextStyle(
                            height: 1.171875,
                            fontSize: 24.0,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w300,
                            color: AppColors.kPrimaryColor),
                        hintStyle: TextStyle(
                            height: 1.171875,
                            fontSize: 24.0,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w300,
                            color: Color.fromARGB(100, 100, 100, 100)),
                        filled: true,
                      ),
                      style: const TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255), fontSize: 24.0),
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
                          color: Color.fromARGB(255, 255, 255, 255),
                          size: 24.0,
                        ),
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            // side: const BorderSide(
                            //     color: Color.fromARGB(255, 0, 0, 0),
                            //     width: 1.0),
                          )),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              AppColors.kPrimaryColor),
                        ),
                        onPressed: () async {
                          if (_loginFormKey.currentState == null) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Wrong email and password!"),
                            ));
                          } else {
                            if (_loginFormKey.currentState!.validate()) {
                              _loginFormKey.currentState!.save();
            
                              await auth.loginWithEmail(
                                  _emailController.text, _passwordController.text,
                                  (text) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(text),
                                ));
                              });
                            }
                          }
                        },
                        label: const Text('LOGIN',
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
                        text: 'Not registered? ',
                        style: const TextStyle(
                          fontSize: 18.0,
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w300,
                        ),
                        children: <TextSpan>[
                          const TextSpan(
                              text: 'Register ',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w300,
                                color: Color.fromARGB(255, 255, 255, 255),
                              )),
                          TextSpan(
                              text: 'here ',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Get.toNamed('/register');
                                },
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w700,
                                color: AppColors.kPrimaryColor,
                              )),
                        ],
                      ),
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
}
