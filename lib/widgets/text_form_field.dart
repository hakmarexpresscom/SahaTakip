import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormFieldWidget extends StatefulWidget{
  final String text;
  final double borderWidht;
  final Color titleColor;
  final Color borderColor;
  final TextEditingController controller;
  late String value;
  final double paddingValue;
  final int maxLines;
  final int maxLength;
  final String controllerString;

  TextFormFieldWidget({
    Key? key,
    required this.text,
    required this.borderWidht,
    required this.titleColor,
    required this.borderColor,
    required this.controller,
    required this.value,
    required this.paddingValue,
    required this.maxLines,
    required this.maxLength,
    required this.controllerString
  }) : super(key: key);

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {

  @override
  Widget build(BuildContext context){
    return TextFormField(
      inputFormatters: [
        LengthLimitingTextInputFormatter(widget.maxLength),
      ],
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
        counterText: '${widget.controllerString.length}/${widget.maxLength}',
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