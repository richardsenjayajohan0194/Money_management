

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:money_management/app/controllers/auth_controller.dart';
import 'package:money_management/app/utils/Widget/Textfield.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final AuthController authC = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.grey,
          child: Column(
            children: [
              Container(
                color: Colors.amber,
                child: TextfieldTemplate(
                        controller: controller.search,
                        useOutlineBorder: true,
                        prefixIcon: Icon(Icons.search_rounded),
                        hintText: 'Search',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
