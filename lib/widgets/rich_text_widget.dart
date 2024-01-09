import 'package:flutter/material.dart';

class RichTextWidget extends StatefulWidget{
  final String title;
  final String text;
  final double size;
  final FontWeight fontWeightTitle;
  final FontWeight fontWeightText;
  final Color color;

  const RichTextWidget({
    Key? key,
    required this.title,
    required this.text,
    required this.size,
    required this.fontWeightTitle,
    required this.fontWeightText,
    required this.color
  }) : super(key: key);

  @override
  State<RichTextWidget> createState() => _RichTextWidgetState();
}

class _RichTextWidgetState extends State<RichTextWidget> {

  @override
  Widget build(BuildContext context){
    return Container(
      alignment: Alignment.bottomLeft,
        child:RichText(
          textAlign: TextAlign.start,
          text: TextSpan(
            children: [
              TextSpan(
                text: widget.title,
                style: TextStyle(
                  fontWeight: widget.fontWeightTitle, // İlk kelimenin FontWeight'u
                  fontSize: widget.size,
                  color: widget.color,
                ),
              ),
              TextSpan(
                text: widget.text,
                style: TextStyle(
                  fontWeight: widget.fontWeightText, // İlk kelimenin FontWeight'u
                  fontSize: widget.size,
                  color: widget.color,
                ),
              ),
            ],
          ),
        )
    );
  }

}