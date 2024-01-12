import 'package:deneme/styles/context_extension.dart';
import 'package:deneme/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import '../rich_text_widget.dart';

class TaskCheckingCard extends StatefulWidget {

  late double heightConst;
  late double widthConst;
  late String taskName;
  late String assignmentDate;
  late String taskType;
  late int shopCode;
  final VoidCallback onTaps;

  TaskCheckingCard({Key? key, required this.heightConst,required this.widthConst, required this.taskName, required this.assignmentDate, required this.taskType, required this.shopCode, required this.onTaps}): super(key: key);

  @override
  State<TaskCheckingCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCheckingCard> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){widget.onTaps();},
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
                color: Colors.orangeAccent,
                width: 3
            )
        ),
        child: Container(
          height: context.dynamicHeight(widget.heightConst),
          width: context.dynamicWidth(widget.widthConst),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [Icon(Icons.assignment,size: 35,),],
              ),
              TextWidget(text: " ${widget.taskName}", size: 20, fontWeight: FontWeight.w500, color: Colors.black),
              SizedBox(height: context.dynamicHeight(0.02),),
              RichTextWidget(title: " Mağaza Kodu: ", text: "${widget.shopCode}", size: 20, fontWeightTitle: FontWeight.w600, fontWeightText: FontWeight.w400, color: Colors.black, alignment: Alignment.bottomLeft,textAlign: TextAlign.start),
              SizedBox(height: context.dynamicHeight(0.02),),
              RichTextWidget(title: " Görev atama tarihi: ", text: widget.assignmentDate, size: 20, fontWeightTitle: FontWeight.w600, fontWeightText: FontWeight.w400, color: Colors.black, alignment: Alignment.bottomLeft,textAlign: TextAlign.start)
            ],
          ),
        ),
      )
    );
  }
}