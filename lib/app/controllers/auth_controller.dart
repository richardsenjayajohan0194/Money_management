import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:money_management/app/controllers/firestore_controller.dart';
import 'package:money_management/app/model/user_model.dart';
import 'package:money_management/app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore firebase = FirebaseFirestore.instance;
  FirestoreController firestoreController = FirestoreController();

  Stream<User?> get streamAuthStatus => _auth.authStateChanges();

  User? currentUser;

  UserModel userModel = UserModel();

  void signup(String username, String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      if (user != null) {
        await user.reload();
        String uid = user.uid;
        print('User UID: $uid');

        userModel.uid = uid;
        userModel.email = user.email;
        userModel.username = username;
        userModel.password = password;

        // Convert UserModel to Map
        Map<String, dynamic> userMap = userModel.toMap();
        saveDataToSF(userMap);
        firestoreController.addUser(userMap);
      }
      Get.offAllNamed(Routes.DASHBOARD);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    }
  }

  Future<void> saveDataToSF(Map<String, dynamic> userMap) async {
    final SharedPreferences SF = await SharedPreferences.getInstance();

    //!Buat bersihin dari yang sebelumnya datanya
    if (SF.containsKey("currUserIn")) {
      SF.clear();
    }

    final currUserIn = json.encode({
      'user': userMap,
    });

    SF.setString('currUserIn', currUserIn);
  }

  Future<Map<String, dynamic>?> getUserData() async {
    final SharedPreferences SF = await SharedPreferences.getInstance();

    if (SF.containsKey("currUserIn")) {
      final currUserIn =
          json.decode(SF.getString('currUserIn')!) as Map<String, dynamic>;

      return currUserIn;
    } else {
      return null;
    }
  }

  void login(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = userCredential.user;
      if (user != null) {
        await user.reload();
        String uid = user.uid;
        String? email = user.email;
        print('User UID: $uid');
        print('Email : $email');
        final snapShot = await firebase.collection('users').doc(uid).get();
        final getUsername = snapShot.data()!['Username'];
        if (snapShot.exists) {
          print('Ada datanya');
          print('Username: ${getUsername}');
        } else {
          print('Tidak ada datanya');
        }
        userModel.uid = uid;
        userModel.email = user.email;
        userModel.password = password;
        userModel.username = getUsername;

        // Convert UserModel to Map
        Map<String, dynamic> userMap = userModel.toMap();
        saveDataToSF(userMap);
      }

      Get.offAllNamed(Routes.DASHBOARD);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  void logout() async {
    await _auth.signOut();
    userModel.clear();
    Get.offAllNamed(Routes.LOGIN);
  }
}
