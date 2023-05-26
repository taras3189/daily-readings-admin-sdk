import 'package:daily_readings_admin_sdk/services/firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GlobalController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  static FirestoreController firestore = Get.find();
  final RxInt selectedIndex = 0.obs;
  final RxBool isDrawerOpen = false.obs;
  void openDrawer() {
    isDrawerOpen.value = true;
    scaffoldKey.currentState!.openDrawer();
  }

  void closeDrawer() {
    isDrawerOpen.value = false;
    Get.back();
  }

  getStorageListFiles() async {
    final storageRef = FirebaseStorage.instance.ref();
    try {
      final listResult = await storageRef.listAll();
      // for (Reference element in listResult.items) {
      //   Map<String, dynamic>? res =
      //       await firestore.getBibleTitle(bookName: element.name);

      //   books[element.name] = {'ref': element, 'title': res?['title']};
      //   checkIfBookDownloaded();
      // }
      return listResult;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print('ssss222 $e');
      }
      return;
    }
  }
}
