import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_management/app/controllers/auth_controller.dart';
import 'package:money_management/app/model/user_model.dart';
import 'package:money_management/app/utils/Widget/Textfield.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final AuthController authC = Get.find();
  final AuthController authController = Get.find<AuthController>();

  // Dummy data for the list
  final List<Map<String, String>> dummyItems = List.generate(
    20,
    (index) => {
      'title': 'Dummy Item $index',
      'subtitle': 'Subtitle $index',
    },
  );

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
            body: SafeArea(
              child: Container(
                color: Colors.grey,
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.height * 0.01,
                ),
                child: Column(
                  children: [
                    Container(
                      color: Colors.redAccent,
                      child: Row(
                        children: [
                          Icon(
                            Icons.account_circle,
                            size: MediaQuery.of(context).size.height * 0.065,
                          ),
                          Expanded(
                            child: Container(
                              color: Colors.blueGrey,
                              padding: EdgeInsets.all(8.0), // Added padding
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment
                                    .start, // Align text to the start
                                children: [
                                  Text(
                                    "Welcome Back",
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    '${userModel.username}',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Container(
                      color: Colors.blue,
                      child: TextfieldTemplate(
                        controller: controller.search,
                        useOutlineBorder: true,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.01,
                          horizontal: MediaQuery.of(context).size.height * 0.01,
                        ),
                        prefixIcon: Icon(Icons.search_rounded),
                        hintText: 'Search',
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ), // Optional: Add spacing between search and list
                    Expanded(
                      child: Container(
                        color: Colors.white, // Background color for the list
                        padding: EdgeInsets.symmetric(
                            vertical: 10), // Optional padding
                        child: SingleChildScrollView(
                          child: Column(
                            children: List.generate(
                              dummyItems.length,
                              (index) => ListTile(
                                title: Text(dummyItems[index]['title']!),
                                subtitle: Text(dummyItems[index]['subtitle']!),
                                leading: Icon(Icons.label),
                                trailing: Icon(Icons.arrow_forward),
                                onTap: () {
                                  // Handle item tap
                                  print(
                                      'Tapped on ${dummyItems[index]['title']}');
                                },
                              ),
                            ),
                          ),
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
