import 'package:deneme/styles/context_extension.dart';
import 'package:deneme/styles/styleConst.dart';
import 'package:deneme/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class ExternalWorkCard extends StatefulWidget {

  late String taskName;
  late String taskAssignmentDate;
  late String workPlace;
  final VoidCallback onTaps;

  ExternalWorkCard({Key? key, required this.taskName, required this.taskAssignmentDate, required this.workPlace,required this.onTaps}): super(key: key);

  @override
  State<ExternalWorkCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<ExternalWorkCard> {

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
              TextWidget(text: " ${widget.taskAssignmentDate}", size: 20, fontWeight: FontWeight.w400, color: textColor),
              SizedBox(height: context.dynamicHeight(0.02),),
              TextWidget(text: " ${widget.taskName}" + " / " + widget.workPlace, size: 20, fontWeight: FontWeight.w400, color: textColor),
              SizedBox(height: context.dynamicHeight(0.02),),
            ],
          ),
        )
    );
  }
}