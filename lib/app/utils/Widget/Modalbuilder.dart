// modal_dialog_template.dart
import 'package:flutter/material.dart';

class ModalbuilderTemplate extends StatefulWidget {
  final List<Widget> children;
  final String title;

  ModalbuilderTemplate({
    Key? key,
    required this.children,
    this.title = '',
  }) : super(key: key);

  @override
  _ModalbuilderTemplateState createState() => _ModalbuilderTemplateState();
}

class _ModalbuilderTemplateState extends State<ModalbuilderTemplate> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
      child: Container(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.08),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.title,
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Wrap(
              children: widget.children,
            ),
          ],
        ),
      ),
    );
  }
}
