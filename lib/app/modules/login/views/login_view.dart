import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:money_management/app/controllers/auth_controller.dart';
import 'package:money_management/app/routes/app_pages.dart';
import 'package:money_management/app/utils/Widget/Textfield.dart';

import '../controllers/login_controller.dart';

final _formKey = GlobalKey<FormState>();

class LoginView extends GetView<LoginController> {
  final authC = Get.find<AuthController>();

  LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: Color.fromRGBO(20, 80, 163, 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Container(
                  // color: Colors.amber,
                  child: Center(
                    child: Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.06),
                      child: Image.asset("images/login.png"),
                      // height: MediaQuery.of(context).size.height * 0.45,
                    ),
                  ),
                ),
              ),
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      color: Color.fromRGBO(241, 240, 232, 10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Form(
                          key: _formKey,
                          child: Container(
                            margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.05,
                              bottom: MediaQuery.of(context).size.height * 0.03,
                              left: MediaQuery.of(context).size.width * 0.05,
                              right: MediaQuery.of(context).size.width * 0.05,
                            ),
                            // color: Colors.amber,
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Column(
                                children: [
                                  Text(
                                    "Login",
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextfieldTemplate(
                                    controller: controller.emailC,
                                    hintText: 'Email',
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Email cannot be empty';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.015),
                                  TextfieldTemplate(
                                    controller: controller.passC,
                                    hintText: 'Password',
                                    isObscuredText: false,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Password cannot be empty';
                                      }
                                      return null;
                                    },
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
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
                                        authC.login(controller.emailC.text,
                                            controller.passC.text);
                                      },
                                      child: Text(
                                        "LOGIN",
                                        style: TextStyle(
                                          color:
                                              Color.fromRGBO(241, 240, 232, 10),
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.015),
                                  RichText(
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: "Don't have an account? ",
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.02,
                                            color: Colors.black,
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'SignUp now',
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              debugPrint("SignUp press");
                                              Get.offAllNamed(Routes.SIGNUP);
                                            },
                                          style: TextStyle(
                                            color:
                                                Color.fromRGBO(20, 80, 163, 10),
                                            fontWeight: FontWeight.bold,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.02,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.04),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
