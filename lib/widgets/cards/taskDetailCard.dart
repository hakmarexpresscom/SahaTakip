import 'package:deneme/styles/context_extension.dart';
import 'package:deneme/styles/styleConst.dart';
import 'package:deneme/widgets/button_widget.dart';
import 'package:deneme/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../constants/constants.dart';
import '../../services/externalWorkServices.dart';
import '../../services/inCompleteTaskServices.dart';
import 'dart:io';
import '../rich_text_widget.dart';
import '../text_form_field.dart';

class TaskDetailCard extends StatefulWidget {

  static var answerNoteController = TextEditingController();

  late double heightConst;
  late double widthConst;
  late String taskName;
  late String taskDescription;
  late String taskDeadline;
  late String taskType;
  late bool isCompleted;
  late VoidCallback onTaps;
  late VoidCallback onTapsShowPhoto;
  late int id;
  late String assignmentDate;
  late String? assignmentHour;
  late int user_id;
  late int shop_code;
  late int? photo_id;
  late int? report_id;
  late Widget addPhotoButton;
  late XFile? image;
  late String completionDate;
  late int? answer_photo_id;
  late int group_no;

  TaskDetailCard ({ Key? key, required this.heightConst, required this.widthConst,required this.taskName,required this.taskDescription,required this.taskDeadline, required this.taskType, required this.isCompleted, required this.onTaps, required this.onTapsShowPhoto ,required this.id,required this.assignmentDate,required this.assignmentHour,required this.user_id, required this.shop_code, required this.photo_id,required this.report_id,required this.addPhotoButton, required this.image, required this.completionDate, required this.answer_photo_id,required this.group_no}): super(key: key);

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
            RichTextWidget(title: " Görev ismi: ", text: widget.taskName, size: 20, fontWeightTitle: FontWeight.w600, fontWeightText: FontWeight.w400, color: textColor, alignment: Alignment.bottomLeft,textAlign: TextAlign.start),
            SizedBox(height: context.dynamicHeight(0.02),),
            (widget.taskType=="Harici")? RichTextWidget(title: " Görev bitiş saati: ", text: widget.taskDeadline, size: 20, fontWeightTitle: FontWeight.w600, fontWeightText: FontWeight.w400, color: textColor, alignment: Alignment.bottomLeft,textAlign: TextAlign.start): RichTextWidget(title: " Görev bitiş tarihi: ", text: widget.taskDeadline, size: 20, fontWeightTitle: FontWeight.w600, fontWeightText: FontWeight.w400, color: textColor, alignment: Alignment.bottomLeft,textAlign: TextAlign.start),
            SizedBox(height: context.dynamicHeight(0.02),),
            RichTextWidget(title: " Görev detayı: ", text: widget.taskDescription, size: 20, fontWeightTitle: FontWeight.w600, fontWeightText: FontWeight.w400, color: textColor, alignment: Alignment.bottomLeft,textAlign: TextAlign.start),
            SizedBox(height: context.dynamicHeight(0.05),),
            (widget.taskType=="Harici")?SizedBox(height: context.dynamicHeight(0.03),):ButtonWidget(text: "Fotoğrafı Görüntüle", heightConst: 0.06, widthConst: 0.8, size: 18, radius: 20, fontWeight: FontWeight.w600, onTaps: (){widget.onTapsShowPhoto();}, borderWidht: 3, backgroundColor: primaryColor, borderColor: primaryColor, textColor: textColor),
            SizedBox(height: context.dynamicHeight(0.1),),
            Container(
              width: context.dynamicWidth(0.85),
              child: TextFormFieldWidget(
                  text: "Cevap Notu",
                  borderWidht: 2,
                  titleColor: textColor,
                  borderColor: textColor,
                  controller: TaskDetailCard.answerNoteController,
                  value: TaskDetailCard.answerNoteController.text,
                  paddingValue: 5,
                  maxLines: 6,
                  maxLength: 300,
                  controllerString: TaskDetailCard.answerNoteController.text
              ),
            ),

            SizedBox(height: context.dynamicHeight(0.03),),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextWidget(text: "Tamamlandı", size: 20, fontWeight: FontWeight.w400, color: textColor),
                Checkbox(
                    value: widget.isCompleted,
                    onChanged: (newvalue){
                      setState(() {widget.isCompleted=newvalue!;taskIsCompleted=newvalue;});
                      if(widget.taskType=="Harici"){
                        updateCompletionInfoExternalWork(
                          widget.id,
                          widget.taskName,
                          widget.taskDescription,
                          widget.assignmentDate,
                          widget.taskDeadline,
                            widget.user_id,
                            null,
                          (widget.isCompleted)?1:0,
                          widget.assignmentHour,
                          '${constUrl}api/HariciIs/${widget.id}'
                        );
                      }
                      else if(widget.taskType=="Uzaktan"||widget.taskType=="Yerinde"||widget.taskType=="Rapor"){
                        updateCompletionInfoIncompleteTask(
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
                            widget.group_no,
                            '${constUrl}api/TamamlanmamisGorev/${widget.id}'
                        );
                      }
                    }
                    )
              ],
            ),
            SizedBox(height: context.dynamicHeight(0.05)),
            (widget.taskType=="Harici")?SizedBox(height: context.dynamicHeight(0.00)):widget.image != null ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(
                  File(widget.image!.path),
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                ),
              ),
            ) : Text("Fotoğraf Bilgisi Yok", style: TextStyle(fontSize: 17),),
            (widget.taskType=="Harici")?SizedBox(height: context.dynamicHeight(0.00)):SizedBox(height: context.dynamicHeight(0.03)),
            (widget.taskType=="Harici")?SizedBox(height: context.dynamicHeight(0.03),):widget.addPhotoButton,
            (widget.taskType=="Harici")?SizedBox(height: context.dynamicHeight(0.00)):SizedBox(height: context.dynamicHeight(0.03)),
            ButtonWidget(text: "Kaydet", heightConst: 0.06, widthConst: 0.8, size: 18, radius: 20, fontWeight: FontWeight.w600, onTaps: (){widget.onTaps();}, borderWidht: 1, backgroundColor: secondaryColor, borderColor: secondaryColor, textColor: textColor),
          ]
    );
  }
}




