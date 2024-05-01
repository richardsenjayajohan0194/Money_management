import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();
  TextEditingController usernameC = TextEditingController();

  @override
  void onClose() {
    emailC.dispose();
    passC.dispose();
    usernameC.dispose();
    super.onClose();
  }
}
