import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlertDialogDoubleButtonWidget extends StatefulWidget {
  String title;
  String content;
  final VoidCallback onTaps;
  final VoidCallback onTaps2;

  AlertDialogDoubleButtonWidget({super.key,required this.title,required this.content,required this.onTaps,required this.onTaps2});

  @override
  State<AlertDialogDoubleButtonWidget> createState() => _AlertDialogDoubleButtonWidgetState();
}

class _AlertDialogDoubleButtonWidgetState extends State<AlertDialogDoubleButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Text(widget.content),
      actions: <Widget>[
        TextButton(
          onPressed: ()=>{widget.onTaps()},
          child: Text('Kaydetme'),
        ),
        TextButton(
          onPressed: ()=>{widget.onTaps2()},
          child: Text('Kaydet'),
        ),
      ],
    );
  }
}
