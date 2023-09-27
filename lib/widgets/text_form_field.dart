import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatefulWidget{
  final String text;
  final double borderWidht;
  final Color titleColor;
  final Color borderColor;
  final TextEditingController controller;
  final Icon prefixIcon;
  late String value;
  final double paddingValue;
  final int maxLines;

  TextFormFieldWidget({
    Key? key,
    required this.text,
    required this.borderWidht,
    required this.titleColor,
    required this.borderColor,
    required this.controller,
    required this.prefixIcon,
    required this.value,
    required this.paddingValue,
    required this.maxLines
  }) : super(key: key);

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {

  @override
  Widget build(BuildContext context){
    return TextFormField(
      maxLines: widget.maxLines,
      controller: widget.controller,
      autocorrect: false,
      style: TextStyle(color: widget.titleColor),
      onSaved: (input){
        setState((){
          widget.value = input!;
        });
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(widget.paddingValue),
        border: OutlineInputBorder(borderSide: BorderSide(color: widget.borderColor, width: widget.borderWidht)),
        hintText: widget.text,
      ),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
    );
  }

}