import 'package:deneme/styles/context_extension.dart';
import 'package:deneme/styles/styleConst.dart';
import 'package:flutter/material.dart';
import '../rich_text_widget.dart';

class ExternalWorkDetailCard extends StatefulWidget {

  static var answerNoteController = TextEditingController();

  late double heightConst;
  late double widthConst;
  late String taskName;
  late String? taskDescription;
  late String startHour;
  late String finishHour;
  late String workPlace;
  late bool isCompleted;
  late int id;
  late String assignmentDate;
  late int user_id;
  late VoidCallback onTaps;
  late String lat;
  late String long;

  ExternalWorkDetailCard ({ Key? key, required this.heightConst, required this.widthConst,required this.taskName,required this.taskDescription, required this.startHour, required this.finishHour, required this.workPlace,required this.isCompleted, required this.id,required this.assignmentDate,required this.user_id,required this.onTaps, required this.lat, required this.long}): super(key: key);

  @override
  State<ExternalWorkDetailCard> createState() => _TaskDetailCardState();
}

class _TaskDetailCardState extends State<ExternalWorkDetailCard> {

  @override
  Widget build(BuildContext context) {

    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          RichTextWidget(title: " Görev ismi: ", text: widget.taskName, size: 20, fontWeightTitle: FontWeight.w600, fontWeightText: FontWeight.w400, color: textColor, alignment: Alignment.bottomLeft,textAlign: TextAlign.start),
          SizedBox(height: context.dynamicHeight(0.02),),
          RichTextWidget(title: " Görev başlangıç saati: ", text: widget.startHour, size: 20, fontWeightTitle: FontWeight.w600, fontWeightText: FontWeight.w400, color: textColor, alignment: Alignment.bottomLeft,textAlign: TextAlign.start),
          SizedBox(height: context.dynamicHeight(0.02),),
          RichTextWidget(title: " Görev bitiş saati: ", text: widget.finishHour, size: 20, fontWeightTitle: FontWeight.w600, fontWeightText: FontWeight.w400, color: textColor, alignment: Alignment.bottomLeft,textAlign: TextAlign.start),
          SizedBox(height: context.dynamicHeight(0.02),),
          RichTextWidget(title: " Görev Detayı: ", text: (widget.taskDescription==""|| widget.taskDescription==null)? "Detay belirtilmemiş.":  widget.taskDescription!, size: 20, fontWeightTitle: FontWeight.w600, fontWeightText: FontWeight.w400, color: textColor, alignment: Alignment.bottomLeft,textAlign: TextAlign.start),
          SizedBox(height: context.dynamicHeight(0.02),),
          RichTextWidget(title: " Görev yeri: ", text: widget.workPlace, size: 20, fontWeightTitle: FontWeight.w600, fontWeightText: FontWeight.w400, color: textColor, alignment: Alignment.bottomLeft,textAlign: TextAlign.start),
        ]
    );
  }
}




