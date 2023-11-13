import 'package:deneme/styles/context_extension.dart';
import 'package:deneme/widgets/button_widget.dart';
import 'package:deneme/widgets/text_widget.dart';
import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../services/externalWorkServices.dart';
import '../../services/inCompleteTaskServices.dart';

class TaskDetailCard extends StatefulWidget {

  late double heightConst;
  late double widthConst;
  late String taskName;
  late String taskDescription;
  late String taskDeadline;
  late String taskType;
  late bool isCompleted;
  late VoidCallback onTaps;
  late VoidCallback onTapsPhoto;
  late int id;
  late String assignmentDate;
  late String assignmentHour;
  late int user_id;
  late int shop_code;
  late int? photo_id;
  late int? report_id;

  TaskDetailCard ({ Key? key, required this.heightConst, required this.widthConst,required this.taskName,required this.taskDescription,required this.taskDeadline, required this.taskType, required this.isCompleted, required this.onTaps,required this.onTapsPhoto, required this.id,required this.assignmentDate,required this.assignmentHour,required this.user_id, required this.shop_code, required this.photo_id,required this.report_id}): super(key: key);

  @override
  State<TaskDetailCard> createState() => _TaskDetailCardState();
}

class _TaskDetailCardState extends State<TaskDetailCard> {

  @override
  Widget build(BuildContext context) {

    return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextWidget(text: widget.taskName, heightConst: 0, widhtConst: 0, size: 25, fontWeight: FontWeight.w600, color: Colors.black),
            SizedBox(height: context.dynamicHeight(0.02),),
            (widget.taskType=="Harici")?TextWidget(text: "Bitiş Saati: ${widget.taskDeadline}", heightConst: 0, widhtConst: 0, size: 23, fontWeight: FontWeight.w600, color: Colors.black): TextWidget(text: "Bitiş Tarihi: ${widget.taskDeadline}", heightConst: 0, widhtConst: 0, size: 23, fontWeight: FontWeight.w600, color: Colors.black),
            SizedBox(height: context.dynamicWidht(0.3),),
            TextWidget(text: widget.taskDescription, heightConst: 0, widhtConst: 0, size: 20, fontWeight: FontWeight.w400, color: Colors.black),
            SizedBox(height: context.dynamicHeight(0.2),),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextWidget(text: "Tamamlandı", heightConst: 0, widhtConst: 0, size: 20, fontWeight: FontWeight.w400, color: Colors.black),
                Checkbox(
                    value: widget.isCompleted,
                    onChanged: (newvalue){
                      setState(() {widget.isCompleted=newvalue!;});
                      print(widget.taskType);
                      if(widget.taskType=="Harici"){
                        updateExternalWork(
                          widget.id,
                          widget.taskName,
                          widget.taskDescription,
                          widget.assignmentDate,
                          widget.taskDeadline,
                            (isBS)?widget.user_id:null,
                            (isBS)?null:widget.user_id,
                          (widget.isCompleted)?1:0,
                          widget.assignmentHour,
                          'http://172.23.21.112:7042/api/HariciIs/${widget.id}'
                        );
                      }
                      else if(widget.taskType=="Uzaktan"||widget.taskType=="Yerinde"||widget.taskType=="Rapor"){
                        updateIncompleteTask(
                          widget.id,
                          widget.taskName,
                          widget.taskDescription,
                          widget.assignmentDate,
                          widget.taskDeadline,
                          widget.shop_code,
                          widget.photo_id,
                          widget.taskType,
                          widget.report_id,
                            (widget.isCompleted)?1:0,
                            'http://172.23.21.112:7042/api/TamamlanmamisGorev/${widget.id}'
                        );
                      }
                    }
                    )
              ],
            ),
            (widget.taskType=="Harici")?SizedBox(height: context.dynamicHeight(0.00)):SizedBox(height: context.dynamicHeight(0.03)),
            (widget.taskType=="Harici")?SizedBox(height: context.dynamicHeight(0.03),):ButtonWidget(text: "Fotoğraf Ekle", heightConst: 0.06, widthConst: 0.8, size: 18, radius: 20, fontWeight: FontWeight.w600, onTaps: (){widget.onTapsPhoto();}, borderWidht: 3, backgroundColor: Colors.orangeAccent, borderColor: Colors.orangeAccent, textColor: Colors.black),
            (widget.taskType=="Harici")?SizedBox(height: context.dynamicHeight(0.00)):SizedBox(height: context.dynamicHeight(0.03)),
            ButtonWidget(text: "Kaydet", heightConst: 0.06, widthConst: 0.8, size: 18, radius: 20, fontWeight: FontWeight.w600, onTaps: (){widget.onTaps();}, borderWidht: 1, backgroundColor: Colors.lightGreen.withOpacity(0.6), borderColor: Colors.lightGreen.withOpacity(0.6), textColor: Colors.black),
          ]
    );
  }
}




