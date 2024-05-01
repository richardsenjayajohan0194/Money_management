import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:money_management/app/utils/Layout/ScaleTransition.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScaleTransitionApp(),
    );
  }
}
