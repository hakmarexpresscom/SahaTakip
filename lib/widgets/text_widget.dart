import 'package:flutter/material.dart';

class TextWidget extends StatefulWidget{
  final String text;
  final double size;
  final FontWeight fontWeight;
  final Color color;

  const TextWidget({
    Key? key,
    required this.text,
    required this.size,
    required this.fontWeight,
    required this.color
  }) : super(key: key);

  @override
  State<TextWidget> createState() => _TextWidgetState();
}

class _TextWidgetState extends State<TextWidget> {

  @override
  Widget build(BuildContext context){
    return Text(widget.text,style: TextStyle(fontSize: widget.size, fontWeight: widget.fontWeight, color: widget.color,),textAlign: TextAlign.start,);
  }

}