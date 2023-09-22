import 'package:flutter/material.dart';
import 'package:deneme/styles/context_extension.dart';

class TextFormFieldWidget extends StatelessWidget{
  final String text;
  final double borderWidht;
  final Color titleColor;
  final Color borderColor;
  final TextEditingController controller;
  final Icon prefixIcon;
  late String value;
  final double paddingValue;

  TextFormFieldWidget({
    Key? key,
    required this.text,
    required this.borderWidht,
    required this.titleColor,
    required this.borderColor,
    required this.controller,
    required this.prefixIcon,
    required this.value,
    required this.paddingValue
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return TextFormField(
      controller: controller,
      autocorrect: false,
      style: TextStyle(color: titleColor),
      onSaved: (input){
        setState((){
          value = input!;
        });
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(paddingValue),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: borderColor, width: borderWidht)),
        hintText: text,
        prefixIcon: prefixIcon
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

  void setState(Null Function() param0) {}

}