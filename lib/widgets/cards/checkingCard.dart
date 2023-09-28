import 'package:deneme/screens/remoteTasks/remoteTaskDetailScreen.dart';
import 'package:deneme/styles/context_extension.dart';
import 'package:deneme/widgets/button_widget.dart';
import 'package:deneme/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class CheckingCard extends StatefulWidget {

  late double heightConst;
  late double widthConst;
  late String taskName;

  CheckingCard({Key? key, required this.heightConst,required this.widthConst, required this.taskName}): super(key: key);

  @override
  State<CheckingCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<CheckingCard> {

  bool light = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
              color: Colors.orangeAccent,
              width: 3
          )
      ),
      child: Container(
        padding: EdgeInsets.fromLTRB(context.dynamicWidht(0.02), context.dynamicWidht(0.08), 0, 0),
        height: context.dynamicHeight(widget.heightConst),
        width: context.dynamicWidht(widget.widthConst),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextWidget(text: widget.taskName, heightConst: 0, widhtConst: 0, size: 22, fontWeight: FontWeight.w500, color: Colors.black),
            SizedBox(width: context.dynamicWidht(0.40),),
            Switch(
              value: light,
              activeColor: Colors.green,
              onChanged: (bool value) {
                setState(() {light = value;});
                },
            )
          ],
        ),
      ),
    );
  }
}
