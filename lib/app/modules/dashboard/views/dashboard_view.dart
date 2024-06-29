import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:money_management/app/controllers/auth_controller.dart';
import 'package:money_management/app/modules/profile/views/profile_view.dart';
import '../../add_wallate/views/add_wallate_view.dart';
import '../../home/views/home_view.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends StatelessWidget {
  final AuthController authC = Get.find();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (controller) {
        return Scaffold(
          body:IndexedStack(
            index: controller.currentIndexPage,
            children: [
              HomeView(),
              AddWallateView(),
              ProfileView()
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: Colors.black,
            selectedItemColor: Colors.amberAccent,
            onTap: controller.changeCurrentIndexPage,
            currentIndex: controller.currentIndexPage,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            items: [
              _bottomNavigationBarItem(
                icon: Icons.home,
                label: 'Home',
              ),
              _bottomNavigationBarItem(icon: Icons.wallet, label: 'Add Wallates'),
              _bottomNavigationBarItem(icon: Icons.person, label: 'Account'),
            ],
          ),
        );
      }
    );
  }

  _bottomNavigationBarItem({IconData? icon, String? label}) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }
}
