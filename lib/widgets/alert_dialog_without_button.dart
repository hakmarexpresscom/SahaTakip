import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlertDialogWithoutButtonWidget extends StatefulWidget {
  String title;
  String content;

  AlertDialogWithoutButtonWidget({super.key,required this.title,required this.content});

  @override
  State<AlertDialogWithoutButtonWidget> createState() => _AlertDialogWithoutButtonWidgetState();
}

class _AlertDialogWithoutButtonWidgetState extends State<AlertDialogWithoutButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text(widget.content),
        ],
      ),
    );
  }
}
