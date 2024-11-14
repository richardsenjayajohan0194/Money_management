import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextfieldTemplate extends StatefulWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  bool useMargin;
  bool isObscuredText;
  final String? obscureCharacter;
  final InputDecoration? decoration;
  final bool useOutlineBorder; // Changed to bool for condition check
  final Widget? prefixIcon;
  final String hintText;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? suffixIcon;
  Widget? icon;
  final String? Function(String?)? validator;

  TextfieldTemplate({
    Key? key,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.useMargin = true,
    this.isObscuredText = true,
    this.decoration,
    this.useOutlineBorder = false,
    this.prefixIcon,
    required this.hintText,
    this.contentPadding,
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
      margin: widget.useMargin == true
          ? EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.015,
              bottom: MediaQuery.of(context).size.height * 0.015,
            )
          : null,
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        obscureText: !widget.isObscuredText,
        enableSuggestions: false,
        autocorrect: false,
        decoration: widget.decoration?.copyWith(
              hintText: widget.hintText, // Preserve hintText
              prefixIcon: widget.prefixIcon, // Preserve prefixIcon
              contentPadding: widget.contentPadding, // Preserve contentPadding
              hintStyle: TextStyle(color: Colors.black),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(width: 1.0, color: Colors.black),
                )
            ) ??
            InputDecoration(
              hintText: widget.hintText, // Default hintText
              prefixIcon: widget.prefixIcon, // Default prefixIcon
              contentPadding: widget.contentPadding,
              enabledBorder: widget.useOutlineBorder == true
                  ? OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(width: 2.0, color: Colors.black),
                    )
                  : UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
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
