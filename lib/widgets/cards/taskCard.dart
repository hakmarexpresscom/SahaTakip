import 'package:deneme/styles/context_extension.dart';
import 'package:deneme/styles/styleConst.dart';
import 'package:deneme/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import '../rich_text_widget.dart';

class TaskCard extends StatefulWidget {

  late double heightConst;
  late double widthConst;
  late String taskName;
  late String taskAssignmentDate;
  late String taskType;
  late int shop_code;
  final VoidCallback onTaps;

  TaskCard({Key? key, required this.heightConst,required this.widthConst, required this.taskName, required this.taskAssignmentDate, required this.taskType,required this.shop_code,required this.onTaps}): super(key: key);

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){widget.onTaps();},
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
                color: primaryColor,
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
              TextWidget(text: " ${widget.taskName}", size: 20, fontWeight: FontWeight.w500, color: textColor),
              SizedBox(height: context.dynamicHeight(0.02),),
              (widget.taskType=="Uzaktan") ? RichTextWidget(title: " Mağaza Kodu: ", text: "${widget.shop_code}", size: 20, fontWeightTitle: FontWeight.w600, fontWeightText: FontWeight.w400, color: textColor, alignment: Alignment.bottomLeft,textAlign: TextAlign.start) : SizedBox(height: context.dynamicHeight(0.0),),
              (widget.taskType=="Uzaktan") ? SizedBox(height: context.dynamicHeight(0.02),) : SizedBox(height: context.dynamicHeight(0.00),),
              RichTextWidget(title: " Görev atama tarihi: ", text: widget.taskAssignmentDate, size: 20, fontWeightTitle: FontWeight.w600, fontWeightText: FontWeight.w400, color: textColor, alignment: Alignment.bottomLeft,textAlign: TextAlign.start)
            ],
          ),
        ),
      )
    );
  }
}