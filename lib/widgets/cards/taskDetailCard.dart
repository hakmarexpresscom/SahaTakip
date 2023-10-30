import 'package:deneme/styles/context_extension.dart';
import 'package:deneme/widgets/button_widget.dart';
import 'package:deneme/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class TaskDetailCard extends StatefulWidget {

  late double heightConst;
  late double widthConst;
  late String taskName;
  late String taskDescription;
  late String taskDeadline;

  TaskDetailCard ({ Key? key, required this.heightConst, required this.widthConst,required this.taskName,required this.taskDescription,required this.taskDeadline,}): super(key: key);

  @override
  State<TaskDetailCard> createState() => _TaskDetailCardState();
}

class _TaskDetailCardState extends State<TaskDetailCard> {

  late bool isCompleted=false;

  @override
  Widget build(BuildContext context) {

    return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextWidget(text: widget.taskName, heightConst: 0, widhtConst: 0, size: 25, fontWeight: FontWeight.w600, color: Colors.black),
            SizedBox(height: context.dynamicWidht(0.05),),
            TextWidget(text: "Bitiş Tarihi: ${widget.taskDeadline}", heightConst: 0, widhtConst: 0, size: 23, fontWeight: FontWeight.w600, color: Colors.black),
            SizedBox(height: context.dynamicWidht(0.3),),
            TextWidget(text: widget.taskDescription, heightConst: 0, widhtConst: 0, size: 20, fontWeight: FontWeight.w400, color: Colors.black),
            SizedBox(height: context.dynamicWidht(0.5),),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextWidget(text: "Tamamlandı", heightConst: 0, widhtConst: 0, size: 20, fontWeight: FontWeight.w400, color: Colors.black),
                Checkbox(value: isCompleted, onChanged: (newvalue){setState(() {isCompleted=newvalue!;});})
              ],
            ),
            SizedBox(height: context.dynamicWidht(0.05),),
            ButtonWidget(text: "Kaydet", heightConst: 0.06, widthConst: 0.8, size: 18, radius: 20, fontWeight: FontWeight.w600, onTaps: (){}, borderWidht: 1, backgroundColor: Colors.lightGreen.withOpacity(0.6), borderColor: Colors.lightGreen.withOpacity(0.6), textColor: Colors.black),
          ]
    );
  }
}




