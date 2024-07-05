import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';
import 'package:money_management/app/model/user_model.dart';
import 'package:money_management/app/controllers/auth_controller.dart';

class ProfileView extends GetView<ProfileController> {
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel?>(
      future: authController.getUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else if (!snapshot.hasData || snapshot.data == null) {
          return Scaffold(
            body: Center(
              child: Text('No user data available.'),
            ),
          );
        } else {
          final UserModel userModel = snapshot.data!;

          return Scaffold(
            body: Center(
              child: Container(
                height: MediaQuery.of(context).size.height,
                color: Color.fromRGBO(20, 80, 163, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.4,
                        color: Colors.amber,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Icon(
                            Icons.account_circle,
                            size: MediaQuery.of(context).size.height * 0.2,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.015),
                    Center(
                      child: Text(
                        '${userModel.username}',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.03,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.015),
                    Center(
                      child: Text(
                        '${userModel.email}',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.025,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
