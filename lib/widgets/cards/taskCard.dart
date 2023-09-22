import 'package:deneme/styles/context_extension.dart';
import 'package:deneme/widgets/button_widget.dart';
import 'package:deneme/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {

  late double heightConst;
  late double widthConst;
  late String taskName;

  TaskCard({super.key,required this.heightConst,required this.widthConst, required this.taskName});

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
        height: context.dynamicHeight(heightConst),
        width: context.dynamicWidht(widthConst),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextWidget(text: taskName, heightConst: 0, widhtConst: 0, size: 22, fontWeight: FontWeight.w500, color: Colors.black),
            SizedBox(width: context.dynamicWidht(0.17),),
            ButtonWidget(text: "Görev Detayları", heightConst: 0.05, widthConst: 0.35, size: 15, radius: 20, fontWeight: FontWeight.w500, onTaps: (){}, borderWidht: 1, backgroundColor: Colors.lightGreen.withOpacity(0.6), borderColor: Colors.transparent, textColor: Colors.black),
          ],
        ),
      ),
    );
  }
}
