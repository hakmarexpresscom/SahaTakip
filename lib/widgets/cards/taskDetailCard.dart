import 'package:deneme/styles/context_extension.dart';
import 'package:deneme/styles/styleConst.dart';
import 'package:deneme/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../rich_text_widget.dart';
import '../text_form_field.dart';

class TaskDetailCard extends StatefulWidget {

  static var answerNoteController = TextEditingController();

  late String taskName;
  late String? taskDescription;
  late String taskDeadline;
  late String taskType;
  late VoidCallback onTaps;
  late VoidCallback onTapsShowPhoto;
  late Widget addPhotoButton;
  late XFile? image;

  TaskDetailCard ({ Key? key,
    required this.taskName,
    required this.taskDescription,
    required this.taskDeadline,
    required this.taskType,
    required this.onTaps,
    required this.onTapsShowPhoto ,
    required this.addPhotoButton,
    required this.image,
  }): super(key: key);

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
            RichTextWidget(title: " Görev bitiş tarihi: ", text: widget.taskDeadline, size: 20, fontWeightTitle: FontWeight.w600, fontWeightText: FontWeight.w400, color: textColor, alignment: Alignment.bottomLeft,textAlign: TextAlign.start),
            SizedBox(height: context.dynamicHeight(0.02),),
            RichTextWidget(title: " Görev Detayı: ", text: (widget.taskDescription==""|| widget.taskDescription==null)? "Detay belirtilmemiş.":  widget.taskDescription!, size: 20, fontWeightTitle: FontWeight.w600, fontWeightText: FontWeight.w400, color: textColor, alignment: Alignment.bottomLeft,textAlign: TextAlign.start),
            SizedBox(height: context.dynamicHeight(0.05),),
            ButtonWidget(text: "Görev Fotoğrafını Görüntüle", heightConst: 0.06, widthConst: 0.8, size: 18, radius: 20, fontWeight: FontWeight.w600, onTaps: (){widget.onTapsShowPhoto();}, borderWidht: 3, backgroundColor: primaryColor, borderColor: primaryColor, textColor: textColor),
            SizedBox(height: context.dynamicHeight(0.07),),
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
                  maxLines: 8,
                  maxLength: 250,
                  controllerString: TaskDetailCard.answerNoteController.text,
                  enabled: true,

              ),
            ),
            SizedBox(height: context.dynamicHeight(0.03)),
            widget.image != null ? Padding(
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
            SizedBox(height: context.dynamicHeight(0.03)),
            widget.addPhotoButton,
            SizedBox(height: context.dynamicHeight(0.03)),
            ButtonWidget(text: "Görevi Tamamla", heightConst: 0.06, widthConst: 0.8, size: 18, radius: 20, fontWeight: FontWeight.w600, onTaps: (){widget.onTaps();}, borderWidht: 1, backgroundColor: secondaryColor, borderColor: secondaryColor, textColor: textColor),
          ]
    );
  }
}




