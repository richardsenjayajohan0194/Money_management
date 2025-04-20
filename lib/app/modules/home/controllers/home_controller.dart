import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final String title = 'Home Title';

  TextEditingController bank = TextEditingController();
  TextEditingController type = TextEditingController();

  final count = 0.obs;

  get search => null;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
