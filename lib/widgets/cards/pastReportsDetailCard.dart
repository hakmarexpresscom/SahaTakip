import 'package:deneme/screens/remoteTasks/remoteTaskDetailScreen.dart';
import 'package:deneme/styles/context_extension.dart';
import 'package:deneme/widgets/button_widget.dart';
import 'package:deneme/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class PastReportsDetailCard extends StatefulWidget {

  late double heightConstContainer;
  late double widthConstContainer;
  late String taskName;
  late bool isCompleted;
  late String personName;
  final double size;

  PastReportsDetailCard({Key? key, required this.heightConstContainer,required this.widthConstContainer, required this.taskName, required this.isCompleted, required this.personName, required this.size}): super(key: key);

  @override
  State<PastReportsDetailCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<PastReportsDetailCard> {

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
        padding: EdgeInsets.fromLTRB(0,0, 0, 0),
        height: context.dynamicHeight(widget.heightConstContainer),
        width: context.dynamicWidht(widget.widthConstContainer),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextWidget(text: widget.taskName, heightConst: 0, widhtConst: 0, size: widget.size, fontWeight: FontWeight.w500, color: Colors.black),
            TextWidget(text: (widget.isCompleted)?"Tamamlandı":"Tamamlanmadı", heightConst: 0, widhtConst: 0, size: widget.size, fontWeight: FontWeight.w500, color: Colors.black),
            TextWidget(text: widget.personName, heightConst: 0, widhtConst: 0, size: widget.size, fontWeight: FontWeight.w500, color: Colors.black),
          ],
        ),
      ),
    );
  }
}
