import 'package:daily_readings_admin_sdk/services/storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firestore.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class AuthController extends GetxController {
  late FirestoreController firestoreController;
  @override
  void onInit() {
    super.onInit();
    firestoreController = Get.put(FirestoreController(getUID()));
  }

  String? getUID() {
    if (Storage.hasData('uid')) {
      return Storage.getValue('uid');
    } else {
      auth.userChanges().listen((User? user) {
        if (user == null) {
        } else {
          Storage.saveValueIfNull('uid', user.uid);
        }
      });
      return '';
    }
  }

  Future logOut() async {
    await FirebaseAuth.instance.signOut();
    await Storage.clearStorage();
  }

  Future<String?> registerWithEmail(
      String email, String password, errorcb) async {
    EasyLoading.show();
    try {
      // ignore: prefer_final_locals
      var userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      firestoreController.reInit(userCredential.user!.uid, userCredential.user);
      EasyLoading.dismiss();
      return userCredential.user?.uid;
      // initFirestore(userCredential.user.uid);
      // stateChanged();
    } on FirebaseAuthException catch (e) {
      errorcb(e.message);
      EasyLoading.dismiss();
      return null;
    }
  }

  loginWithEmail(String email, String password, errorcb) async {
    EasyLoading.show();
    try {
      final userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      firestoreController.reInit(userCredential.user!.uid, userCredential.user);
      Storage.saveValueIfNull('uid', userCredential.user?.uid);
      EasyLoading.dismiss();
      Get.toNamed('/home');
    } on FirebaseAuthException catch (e) {
      print('${e.message}');
      if (e.code == 'user-not-found') {
        errorcb('No user found for that email.');
        EasyLoading.dismiss();
      } else if (e.code == 'wrong-password') {
        errorcb('Wrong password');
        EasyLoading.dismiss();
      } else {
        errorcb(e.message);
        EasyLoading.dismiss();
      }
    }
  }
 

}
