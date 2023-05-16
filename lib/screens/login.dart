import 'package:daily_readings_admin_sdk/services/auth.dart';
import 'package:daily_readings_admin_sdk/services/firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import '../helpers/slide_right_route.dart';
import 'home.dart';
import 'register.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key, required this.errMsg}) : super(key: key);
  final String errMsg;
  static const String _title = 'Login';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: StatefulLoginWidget(
        errMsg: errMsg,
      ),
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
  // FirestoreController firestore = Get.put(FirestoreController(''));
  bool isLoading = false;
  final AuthController auth = AuthController();
  void checkToken() async {
    var token = await storage.read(key: "token");
    if (token != null) {
      Navigator.pushReplacement(
          context,
          SlideRightRoute(
              page: const HomeScreen(
            errMsg: '',
          )));
    }
  }

  @override
  void initState() {
    super.initState();
    checkToken();
    // if (firestore.uid != null) {
    //   print('subscribed to ${'self_' + firestore.uid!}');
    // }
    // Future.delayed(Duration(seconds: 1), () {
    //   Get.to(() => firestore.uid!.isNotEmpty?HomeScreen(errMsg: ''):LoginScreen(errMsg: 'Please login to enter the app!'));
    // });

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
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Form(
          key: _loginFormKey,
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
                          color: Color.fromARGB(255, 235, 235, 235), width: 1),
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
                    fillColor: Color.fromARGB(255, 255, 255, 255),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 71, 123, 171), width: 1),
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
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 24.0),
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
                          const Color.fromARGB(255, 71, 123, 171)),
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
                          EasyLoading.show();
                          auth.loginWithEmail(
                              _emailController.text, _passwordController.text);

                          // var res = await authService.login(
                          //     _emailController.text, _passwordController.text);
                          // switch (res!.statusCode) {
                          //   case 200:
                          //     EasyLoading.dismiss();
                          //     var data = jsonDecode(res.body);
                          //     storage.write(key: "token", value: data['token']);
                          Navigator.pushReplacement(
                              context,
                              SlideRightRoute(
                                  page: const HomeScreen(
                                errMsg: '',
                              )));
                          //     break;
                          //   case 401:
                          EasyLoading.dismiss();
                          //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          //       content: Text("Wrong email or password!"),
                          //     ));
                          //     break;
                          //   default:
                          //     EasyLoading.dismiss();
                          //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          //       content: Text("Wrong email or password!"),
                          //     ));
                          //     break;
                          // }
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
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w300,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                    children: <TextSpan>[
                      const TextSpan(
                          text: 'Register ',
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
                                      page: const RegisterScreen()));
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
