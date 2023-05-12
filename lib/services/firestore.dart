import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_readings_admin_sdk/models/user/user_model.dart';
import 'package:daily_readings_admin_sdk/services/storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'auth.dart';

class FirestoreController extends GetxController {
  final String? injectedUID;
  FirestoreController(this.injectedUID);

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var userDataModel = UserModel().obs;
  User? userAuthData = FirebaseAuth.instance.currentUser;
  String? uid;
  dynamic userListener;

  @override
  void onInit() {
    uid = injectedUID;
    print('tesssss $uid');
    initData();
    listenUser();
    super.onInit();
  }

  void initData() {
    if (auth.currentUser == null) {
      userDataModel.update((val) {
        if (Storage.hasData('fontSize')) {
          val?.fontSize = Storage.getValue('fontSize');
        } else {
          val?.fontSize = 20;
        }
        if (Storage.hasData('fontHeight')) {
          val?.fontHeight = Storage.getValue('fontHeight');
        } else {
          val?.fontHeight = 1   ;
        }
        if (Storage.hasData('fontFamily')) {
          val?.fontFamily = Storage.getValue('fontFamily');
        } else {
          val?.fontFamily = 'Roboto';
        }
      });
    }
  }

  void reInit(String id, [User? user]) {
    uid = id;
    userListener?.cancel();
    if (id.isNotEmpty) {
      listenUser();
      if (user != null) userAuthData = user;
    } else {
      userDataModel.value = UserModel();
    }
  }

  void listenUser() {
    if (uid!.isNotEmpty) {
      userListener = firestore
          .collection('users')
          .doc(injectedUID)
          .snapshots()
          .listen((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          userDataModel.value = UserModel.fromJson(
              documentSnapshot.data() as Map<String, dynamic>);
          // print(userDataModel.value);
          // updateUser({'currency': 'aaa'});
          print(userDataModel);
        } else {
          print('Document does not exist on the database');
        }
      });
    }
  }

  Future<void> createUser(String uid, Map<String, dynamic> obj) {
    // Call the user's CollectionReference to add a new user
    return firestore
        .collection('users')
        .doc(uid)
        .set(obj)
        .then((value) => print('User Added'))
        .catchError((error) => print('Failed to add user: $error'));
  }

  Future<void> updateUser(Map<String, dynamic> obj) {
    // print(obj);
    // Call the user's CollectionReference to add a new user
    return firestore
        .collection('users')
        .doc(uid)
        .update(obj)
        .then((value) => print('User Updated'))
        .catchError((error) => print('Failed to add user: $error'));
  }

  Future<void> updateUserById(String? _uid, Map<String, dynamic> obj) {
    // print(obj);
    // Call the user's CollectionReference to add a new user
    return firestore
        .collection('users')
        .doc(_uid)
        .update(obj)
        .then((value) => print('User Updated'))
        .catchError((error) => print('Failed to update user: $error'));
  }

  Future<UserModel?> getUserByID(String? uid) async {
    var users = await firestore
        .collection('users')
        .withConverter<UserModel>(
          fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
          toFirestore: (user, _) => user.toJson(),
        )
        .doc(uid)
        .get();
    return users.data();
  }

  Future<Map<String, dynamic>?> getBibleTitle({required String bookName}) async {
    var data = await firestore.collection('bible_titles').doc(bookName).get();
    return data.data();
  }

  Future<QuerySnapshot<UserModel>> getUsersByID(List uids) async {
    var users = await firestore
        .collection('users')
        .withConverter<UserModel>(
          fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
          toFirestore: (user, _) => user.toJson(),
        )
        .where(FieldPath.documentId, whereIn: uids)
        .get();

    return users;
  }
}
