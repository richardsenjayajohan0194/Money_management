import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_management/app/utils/Widget/Dropdown.dart';
import 'package:money_management/app/utils/Widget/Modalbuilder.dart';
import 'package:money_management/app/utils/Widget/Textfield.dart';

import 'package:money_management/app/model/user_model.dart';
import 'package:money_management/app/model/bank_model.dart';
import 'package:money_management/app/controllers/auth_controller.dart';
import '../../../controllers/firestore_controller.dart';
import '../controllers/home_controller.dart';

final _formKey = GlobalKey<FormState>();

class HomeView extends GetView<HomeController> {
  final AuthController authC = Get.find();
  final firestoreF = Get.find<FirestoreController>();

  // Dummy data for the list
  // final List<Map<String, String>> dummyItems = List.generate(
  //   20,
  //   (index) => {
  //     'title': 'Dummy Item $index',
  //     'subtitle': 'Subtitle $index',
  //   },
  // );
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel?>(
      future: authC.getUserDataLog(),
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
                      // color: Colors.redAccent,
                      child: Row(
                        children: [
                          Icon(
                            Icons.account_circle,
                            size: MediaQuery.of(context).size.height * 0.065,
                          ),
                          Expanded(
                            child: Container(
                              // color: Colors.blueGrey,
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
                      height: MediaQuery.of(context).size.height * 0.06,
                    ),
                    Container(
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                            "Wallate",
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.026),
                          )),
                          IconButton(
                            icon: Icon(Icons.add_box),
                            iconSize: MediaQuery.of(context).size.height * 0.04,
                            onPressed: () => Get.dialog(
                              Form(
                                key: _formKey,
                                child: ModalbuilderTemplate(
                                  title: 'Modal Dialog',
                                  children: [
                                    TextfieldTemplate(
                                      hintText: 'Bank',
                                      controller: controller.bank,
                                      useOutlineBorder: true,
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical:
                                            MediaQuery.of(context).size.width *
                                                0.001,
                                        horizontal:
                                            MediaQuery.of(context).size.height *
                                                0.001,
                                      ),
                                      prefixIcon: Icon(
                                        Icons.account_balance_rounded,
                                        color: Colors.black,
                                      ),
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide:
                                              BorderSide(color: Colors.black),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Bank cannot be empty';
                                        }
                                        return null;
                                      },
                                    ),
                                    TextfieldTemplate(
                                      hintText: 'Type',
                                      controller: controller.type,
                                      useOutlineBorder: true,
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical:
                                            MediaQuery.of(context).size.width *
                                                0.001,
                                        horizontal:
                                            MediaQuery.of(context).size.height *
                                                0.001,
                                      ),
                                      prefixIcon: Icon(
                                        Icons.add_card_rounded,
                                        color: Colors.black,
                                      ),
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide:
                                              BorderSide(color: Colors.black),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Type cannot be empty';
                                        }
                                        return null;
                                      },
                                    ),
                                    DropdownTemplate(),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                          backgroundColor:
                                              Color.fromRGBO(20, 80, 163, 10),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                        onPressed: () {
                                          _formKey.currentState!.validate();
                                          firestoreF.Bank(controller.bank.text,
                                              controller.type.text);
                                        },
                                        child: Text(
                                          "Submit",
                                          style: TextStyle(
                                            color: Color.fromRGBO(
                                                241, 240, 232, 10),
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.02,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ), // Optional: Add spacing between search and list
                    Expanded(
                      child: Container(
                        color: Colors.white, // Background color for the list
                        padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.width * 0.01,
                        ), // Optional padding
                        child: StreamBuilder<List<BankModel>>(
                          stream: firestoreF.getBanks(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(
                                  child: Text('Error: ${snapshot.error}'));
                            } else if (!snapshot.hasData ||
                                snapshot.data!.isEmpty) {
                              return Center(child: Text('No banks found.'));
                            } else {
                              final banks = snapshot.data!;

                              return ListView.builder(
                                itemCount: banks.length,
                                itemBuilder: (context, index) {
                                  final bank = banks[index];
                                  return ListTile(
                                    title: Text(bank.bank ?? 'No Bank'),
                                    subtitle:
                                        Text(bank.type ?? 'No Type'),
                                    leading:
                                        Icon(Icons.account_balance_rounded),
                                    trailing: Icon(Icons.arrow_forward),
                                    onTap: () {
                                      // Handle item tap
                                      print('Tapped on ${banks[index].bank}');
                                    },
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
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
