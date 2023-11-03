import 'package:flutter/material.dart';
import 'package:deneme/styles/context_extension.dart';

class ButtonWidget extends StatefulWidget{
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
  }): super(key: key);

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {

  @override
  Widget build(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(widget.radius),),
      height: context.dynamicHeight(widget.heightConst),
      width: context.dynamicWidht(widget.widthConst),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: widget.borderColor, width: widget.borderWidht),
          borderRadius: BorderRadius.all(Radius.circular(widget.radius))),
        onPressed: ()=>{widget.onTaps()},
        child: Text(widget.text,style: TextStyle(fontWeight: widget.fontWeight,fontSize: widget.size, color: widget.textColor),textAlign: TextAlign.center,),
        ),
    );
  }


}