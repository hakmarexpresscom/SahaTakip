import 'package:deneme/styles/context_extension.dart';
import 'package:deneme/widgets/button_widget.dart';
import 'package:deneme/widgets/text_widget.dart';
import 'package:flutter/material.dart';

void setState(Null Function() param0) {
}

class TaskDetailCard extends StatelessWidget {

  late double heightConst;
  late double widthConst;
  late String taskName;
  late String taskDescription;
  late String taskDeadline;

  TaskDetailCard({super.key,required this.heightConst,required this.widthConst, required this.taskName, required this.taskDescription, required this.taskDeadline});

  @override
  Widget build(BuildContext context) {
    late bool isCompleted=true;
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
              color: Colors.orangeAccent,
              width: 3
          )
      ),
      child: Container(
        height: context.dynamicHeight(heightConst),
        width: context.dynamicWidht(widthConst),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: context.dynamicWidht(0.03),),
            TextWidget(text: taskName, heightConst: 0, widhtConst: 0, size: 25, fontWeight: FontWeight.w600, color: Colors.black),
            SizedBox(height: context.dynamicWidht(0.03),),
            TextWidget(text: taskDescription, heightConst: 0, widhtConst: 0, size: 20, fontWeight: FontWeight.w400, color: Colors.black),
            SizedBox(height: context.dynamicWidht(0.03),),
            ButtonWidget(text: "Kaydet", heightConst: 0.06, widthConst: 0.6, size: 18, radius: 20, fontWeight: FontWeight.w400, onTaps: (){}, borderWidht: 1, backgroundColor: Colors.lightGreen.withOpacity(0.6), borderColor: Colors.lightGreen.withOpacity(0.6), textColor: Colors.black)
          ],
        ),
      ),
    );
  }

}


