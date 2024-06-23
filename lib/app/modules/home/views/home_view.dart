// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:money_management/app/controllers/auth_controller.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final AuthController authC = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    );
  }
}
