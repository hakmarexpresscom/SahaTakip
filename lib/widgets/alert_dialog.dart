import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlertDialogWidget extends StatefulWidget {
  String title;
  String content;
  final VoidCallback onTaps;

  AlertDialogWidget({super.key,required this.title,required this.content,required this.onTaps});

  @override
  State<AlertDialogWidget> createState() => _AlertDialogWidgetState();
}

class _AlertDialogWidgetState extends State<AlertDialogWidget> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Text(widget.content),
      actions: <Widget>[
        TextButton(
          onPressed: ()=>{widget.onTaps()},
          child: Text('Tamam'),
        ),
      ],
    );
  }
}
