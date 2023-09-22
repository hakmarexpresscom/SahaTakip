import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget{
  final String text;
  final double heightConst;
  final double widhtConst;
  final double size;
  final FontWeight fontWeight;
  final Color color;

  const TextWidget({
    Key? key,
    required this.text,
    required this.heightConst,
    required this.widhtConst,
    required this.size,
    required this.fontWeight,
    required this.color
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Container(
      child: Column(
        children: [Text(text,style: TextStyle(fontSize: size, fontWeight: fontWeight, color: color),)],
      ),
    );
  }

}