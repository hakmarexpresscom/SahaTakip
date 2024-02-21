import 'package:deneme/routing/landing.dart';
import 'package:deneme/styles/context_extension.dart';
import 'package:deneme/styles/styleConst.dart';
import 'package:deneme/widgets/button_widget.dart';
import 'package:deneme/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import '../../constants/constants.dart';
import '../../services/externalWorkServices.dart';
import '../rich_text_widget.dart';

class ExternalWorkDetailCard extends StatefulWidget {

  static var answerNoteController = TextEditingController();

  late double heightConst;
  late double widthConst;
  late String taskName;
  late String taskDescription;
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
          RichTextWidget(title: " Görev başlangıç saati: ", text: widget.taskDescription, size: 20, fontWeightTitle: FontWeight.w600, fontWeightText: FontWeight.w400, color: textColor, alignment: Alignment.bottomLeft,textAlign: TextAlign.start),
          SizedBox(height: context.dynamicHeight(0.02),),
          RichTextWidget(title: " Görev yeri: ", text: widget.workPlace, size: 20, fontWeightTitle: FontWeight.w600, fontWeightText: FontWeight.w400, color: textColor, alignment: Alignment.bottomLeft,textAlign: TextAlign.start),
          SizedBox(height: context.dynamicHeight(0.1),),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextWidget(text: "Görev Tamamlandı", size: 20, fontWeight: FontWeight.w400, color: textColor),
              Checkbox(
                  value: widget.isCompleted,
                  onChanged: (newvalue){
                    setState(() {
                      widget.isCompleted=newvalue!;taskIsCompleted=newvalue;
                    });
                    updateCompletionInfoExternalWork(
                        widget.id,
                        (isBS)?userID:null,
                        (isBS)?null:userID,
                        widget.taskName,
                        widget.taskDescription,
                        widget.startHour,
                        widget.finishHour,
                        widget.assignmentDate,
                        1,
                        widget.workPlace,
                        widget.lat,
                        widget.long,
                        '${constUrl}api/HariciIs/${widget.id}'
                    );
                  }
              )
            ],
          ),
          SizedBox(height: context.dynamicHeight(0.02),),
          ButtonWidget(text: "Görevi Kaydet", heightConst: 0.06, widthConst: 0.8, size: 18, radius: 20, fontWeight: FontWeight.w600, onTaps: (){widget.onTaps();}, borderWidht: 1, backgroundColor: secondaryColor, borderColor: secondaryColor, textColor: textColor),
        ]
    );
  }
}




