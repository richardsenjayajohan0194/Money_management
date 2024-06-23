// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddWallateController extends GetxController {
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  TextEditingController wallateC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController descC = TextEditingController();
  TextEditingController ballanceC = TextEditingController();
  TextEditingController imageC = TextEditingController();

  @override
  void onClose() {
    wallateC.dispose();
    nameC.dispose();
    descC.dispose();
    ballanceC.dispose();
    imageC.dispose();
    super.onClose();
  }
}
