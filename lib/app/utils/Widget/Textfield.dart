import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextfieldTemplate extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType? keyboardType;
  bool isObscuredText;
  final String? obscureCharacter;
  final String hintText;
  final Widget? suffixIcon;
  Widget? icon;
  final String? Function(String?)? validator;

  TextfieldTemplate({
    Key? key,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.isObscuredText = true,
    required this.hintText,
    this.suffixIcon,
    this.icon,
    this.obscureCharacter,
    this.validator,
  }) : super(key: key);

  @override
  _TextfieldTemplateState createState() => _TextfieldTemplateState();
}

class _TextfieldTemplateState extends State<TextfieldTemplate> {
  void toggle() {
    setState(() {
      widget.isObscuredText = !widget.isObscuredText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.015,
        bottom: MediaQuery.of(context).size.height * 0.015,
      ),
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        obscureText: !widget.isObscuredText,
        enableSuggestions: false,
        autocorrect: false,
        decoration: InputDecoration(
          hintText: widget.hintText,
          suffixIcon: widget.hintText == "Password"
              ? IconButton(
                  onPressed: toggle,
                  icon: widget.isObscuredText
                      ? Icon(Icons.visibility)
                      : Icon(Icons.visibility_off),
                )
              : widget.icon,
          hintStyle: TextStyle(
            color: Colors.black,
            fontSize: MediaQuery.of(context).size.height * 0.02,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          errorStyle: TextStyle(
            fontSize: MediaQuery.of(context).size.height * 0.015,
          ),
        ),
        validator: widget.validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
      ),
    );
  }
}
