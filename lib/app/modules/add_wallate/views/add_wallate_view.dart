import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_management/app/controllers/auth_controller.dart';
import 'package:money_management/app/controllers/firestore_controller.dart';
import '../controllers/add_wallate_controller.dart';
import 'package:money_management/app/utils/Widget/Textfield.dart';

final _formKey = GlobalKey<FormState>();

class AddWallateView extends GetView<AddWallateController> {
  final AuthController authC = Get.find();
  final firestoreF = Get.find<FirestoreController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Wallates'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => authC.logout(),
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.amber,
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
          child: Center(
            child: Form(
              key: _formKey,
              child: Container(
                color: Colors.redAccent,
                child: Column(
                  children: [
                    TextfieldTemplate(
                      controller: controller.wallateC,
                      hintText: 'Wallates name',
                      isObscuredText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Wallates name cannot be empty';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.015),
                    TextfieldTemplate(
                      controller: controller.nameC,
                      hintText: 'Name',
                      isObscuredText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Name cannot be empty';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.015),
                    TextfieldTemplate(
                      controller: controller.descC,
                      hintText: 'Desc',
                      isObscuredText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Desc cannot be empty';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.015),
                    TextfieldTemplate(
                      controller: controller.ballanceC,
                      hintText: 'Ballance',
                      isObscuredText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Ballance cannot be empty';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.015),
                    TextfieldTemplate(
                      controller: controller.imageC,
                      hintText: 'Image',
                      isObscuredText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Image cannot be empty';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.015),
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Color.fromRGBO(20, 80, 163, 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        _formKey.currentState!.validate();
                        firestoreF.addWallate(
                            controller.wallateC.text,
                            controller.nameC.text,
                            controller.descC.text,
                            controller.ballanceC.text,
                            controller.imageC.text);
                      },
                      child: Text(
                        "ADD",
                        style: TextStyle(
                          color: Color.fromRGBO(241, 240, 232, 10),
                          fontSize: MediaQuery.of(context).size.height * 0.02,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
