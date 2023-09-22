import 'package:flutter/material.dart';
import 'package:deneme/styles/context_extension.dart';

class ButtonWidget extends StatelessWidget{
  final String text;
  final double heightConst;
  final double widthConst;
  final double size;
  final double radius;
  final FontWeight fontWeight;
  final VoidCallback onTaps;
  final double borderWidht;
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;

  const ButtonWidget({
    Key? key,
    required this.text,
    required this.heightConst,
    required this.widthConst,
    required this.size,
    required this.radius,
    required this.fontWeight,
    required this.onTaps,
    required this.borderWidht,
    required this.backgroundColor,
    required this.borderColor,
    required this.textColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),),
      height: context.dynamicHeight(heightConst),
      width: context.dynamicWidht(widthConst),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: borderColor, width: borderWidht),
          borderRadius: BorderRadius.all(Radius.circular(radius))),
        onPressed: ()=>{onTaps()},
        child: Text(text,style: TextStyle(fontWeight: fontWeight,fontSize: size, color: textColor),),
        ),
    );
  }


}