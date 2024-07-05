import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextfieldTemplate extends StatefulWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  bool isObscuredText;
  final String? obscureCharacter;
  final bool useOutlineBorder; // Changed to bool for condition check
  final Widget? prefixIcon;
  final String hintText;
  final Widget? suffixIcon;
  Widget? icon;
  final String? Function(String?)? validator;

  TextfieldTemplate({
    Key? key,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.isObscuredText = true,
    this.useOutlineBorder = false,
    this.prefixIcon,
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
          enabledBorder: widget.useOutlineBorder == true
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(width: 2.0, color: Colors.black),
                )
              : UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
          iconColor: Colors.black,
          prefixIcon: widget.prefixIcon,
          prefixIconColor: Colors.black,
          hintText: widget.hintText,
          suffixIcon: widget.hintText == "Password"
              ? IconButton(
                  onPressed: toggle,
                  icon: widget.isObscuredText
                      ? Icon(Icons.visibility)
                      : Icon(Icons.visibility_off),
                )
              : widget.icon,
          focusedBorder: widget.useOutlineBorder == true
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(width: 2.0, color: Colors.black),
                )
              : UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
          hintStyle: TextStyle(
            color: Colors.black,
            fontSize: MediaQuery.of(context).size.height * 0.02,
          ),
          errorStyle: TextStyle(
            fontSize: MediaQuery.of(context).size.height * 0.015,
          ),
        ),
        cursorColor: Colors.black,
        validator: widget.validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
      ),
    );
  }
}
