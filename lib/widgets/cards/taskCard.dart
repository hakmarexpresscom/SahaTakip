import 'package:deneme/styles/context_extension.dart';
import 'package:deneme/widgets/button_widget.dart';
import 'package:deneme/widgets/text_widget.dart';
import 'package:flutter/material.dart';

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
              TextWidget(text: "  ${widget.taskName}", heightConst: 0, widhtConst: 0, size: 20, fontWeight: FontWeight.w500, color: Colors.black),
              SizedBox(height: context.dynamicHeight(0.02),),
              (widget.taskType=="Uzaktan") ? TextWidget(text: "  Mağaza Kodu: ${widget.shop_code}", heightConst: 0, widhtConst: 0, size: 20, fontWeight: FontWeight.w600, color: Colors.black) : SizedBox(height: context.dynamicHeight(0.0),),
              (widget.taskType=="Uzaktan") ? SizedBox(height: context.dynamicHeight(0.02),) : SizedBox(height: context.dynamicHeight(0.00),),
              TextWidget(text: "  Görev atama tarihi: ${widget.taskAssignmentDate}", heightConst: 0, widhtConst: 0, size: 20, fontWeight: FontWeight.w500, color: Colors.black),
            ],
          ),
        ),
      )
    );
  }
}