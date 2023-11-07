import 'package:flutter/material.dart';

class TextFormFieldDatePicker extends StatefulWidget{
  final String text;
  final double borderWidht;
  final Color titleColor;
  final Color borderColor;
  final TextEditingController dateController;
  late String value;
  final double paddingValue;
  final int maxLines;

  TextFormFieldDatePicker({
    Key? key,
    required this.text,
    required this.borderWidht,
    required this.titleColor,
    required this.borderColor,
    required this.dateController,
    required this.value,
    required this.paddingValue,
    required this.maxLines
  }) : super(key: key);

  @override
  State<TextFormFieldDatePicker> createState() => _TextFormFieldDatePickerState();
}

class _TextFormFieldDatePickerState extends State<TextFormFieldDatePicker> {

  @override
  Widget build(BuildContext context){
    return TextFormField(
      maxLines: widget.maxLines,
      controller: widget.dateController,
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
        onTap: () async{
          DateTime? date = DateTime(1900);
          FocusScope.of(context).requestFocus(FocusNode());

          date = await showDatePicker(
              context: context,
              initialDate:DateTime.now(),
              firstDate:DateTime(1900),
              lastDate: DateTime(2100));

          widget.dateController.text = date!.day.toString()+"-"+date!.month.toString()+"-"+date!.year.toString();}
    );
  }

}