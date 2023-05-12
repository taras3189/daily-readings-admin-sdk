import 'package:daily_readings_admin_sdk/services/storage.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firestore.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class AuthController extends GetxController {
  late FirestoreController firestoreController;
  @override
  void onInit() {
    super.onInit();

    firestoreController = FirestoreController(getUID());
    Get.put<FirestoreController>(
      firestoreController,
    );
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

  void logOut() async {
    await FirebaseAuth.instance.signOut();
    firestoreController.reInit('');
    firestoreController.initData();
    await Storage.removeValue('uid');
    await Get.toNamed('/home');
  }

  // sendVerificationEmail() async {
  //   User? user = FirebaseAuth.instance.currentUser;

  //   if (user != null && !user.emailVerified) {
  //     // var actionCodeSettings = ActionCodeSettings(
  //     //   url: 'https://www.example.com/?email=${user.email}',
  //     //   dynamicLinkDomain: "example.page.link",
  //     //   handleCodeInApp: true,
  //     // );

  //     await user.sendEmailVerification();
  //   }
  // }

  Future<String?> registerWithEmail(String email, String password) async {
    try {
      // ignore: prefer_final_locals
      var userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      firestoreController.reInit(userCredential.user!.uid, userCredential.user);
      return userCredential.user?.uid;
      // initFirestore(userCredential.user.uid);
      // stateChanged();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  void loginWithEmail(String email, String password) async {
    try {
      final userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      firestoreController.reInit(userCredential.user!.uid, userCredential.user);
      Storage.saveValueIfNull('uid', userCredential.user?.uid);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {}
    }
  }
}
