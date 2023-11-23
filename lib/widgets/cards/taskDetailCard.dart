import 'package:deneme/styles/context_extension.dart';
import 'package:deneme/widgets/button_widget.dart';
import 'package:deneme/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../constants/constants.dart';
import '../../services/externalWorkServices.dart';
import '../../services/inCompleteTaskServices.dart';
import 'dart:io';

class TaskDetailCard extends StatefulWidget {

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
  late String assignmentHour;
  late int user_id;
  late int shop_code;
  late int? photo_id;
  late int? report_id;
  late Widget addPhotoButton;
  late XFile? image;

  TaskDetailCard ({ Key? key, required this.heightConst, required this.widthConst,required this.taskName,required this.taskDescription,required this.taskDeadline, required this.taskType, required this.isCompleted, required this.onTaps, required this.onTapsShowPhoto ,required this.id,required this.assignmentDate,required this.assignmentHour,required this.user_id, required this.shop_code, required this.photo_id,required this.report_id,required this.addPhotoButton, required this.image}): super(key: key);

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
            SizedBox(height: context.dynamicHeight(0.1),),
            TextWidget(text: widget.taskDescription, heightConst: 0, widhtConst: 0, size: 20, fontWeight: FontWeight.w400, color: Colors.black),
            SizedBox(height: context.dynamicHeight(0.05),),
            (widget.taskType=="Harici")?SizedBox(height: context.dynamicHeight(0.03),):ButtonWidget(text: "Fotoğrafı Görüntüle", heightConst: 0.06, widthConst: 0.8, size: 18, radius: 20, fontWeight: FontWeight.w600, onTaps: (){widget.onTapsShowPhoto();}, borderWidht: 3, backgroundColor: Colors.orangeAccent, borderColor: Colors.orangeAccent, textColor: Colors.black),
            SizedBox(height: context.dynamicHeight(0.1),),
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
                      if(widget.taskType=="Harici"){
                        updateCompletionInfoExternalWork(
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
                            'http://172.23.21.112:7042/api/TamamlanmamisGorev/${widget.id}'
                        );
                        // createCompleteTask();
                        // cevap olarak eklenen fotoğrafı sql'e kaydetmeyi
                        // yapmamışım onu eklemem lazım ama nasıl olcağını bilmiyorum
                        // XFile image olarak dosyası buraya iletiliyo screen scrptinden
                        // ama tam olarak nerede createPhoto() fonksiyonunu çalıştırmam
                        // lazım onu bulamadım
                        // createPhoto() fonksiyonunu bu else if'in içinde çağırabiliriz
                        // diye düşünüyorum
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
            ButtonWidget(text: "Kaydet", heightConst: 0.06, widthConst: 0.8, size: 18, radius: 20, fontWeight: FontWeight.w600, onTaps: (){widget.onTaps();}, borderWidht: 1, backgroundColor: Colors.lightGreen.withOpacity(0.6), borderColor: Colors.lightGreen.withOpacity(0.6), textColor: Colors.black),
          ]
    );
  }
}




