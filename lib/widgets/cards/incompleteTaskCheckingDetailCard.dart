import 'package:deneme/styles/context_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../button_widget.dart';
import '../text_widget.dart';

class IncompleteTaskCheckingDetailCard extends StatefulWidget {
  late double heightConst;
  late double widthConst;
  late String taskName;
  late String taskDescription;
  late String taskDeadline;
  late String taskType;
  late VoidCallback onTapsShowPhoto;
  late int id;
  late String assignmentDate;
  late int shop_code;
  late int? photo_id;

  IncompleteTaskCheckingDetailCard ({ Key? key, required this.heightConst, required this.widthConst,required this.taskName,required this.taskDescription,required this.taskDeadline, required this.taskType, required this.onTapsShowPhoto ,required this.id,required this.assignmentDate, required this.shop_code, required this.photo_id}): super(key: key);

  @override
  State<IncompleteTaskCheckingDetailCard> createState() => _IncompleteTaskCheckingDetailCardState();
}

class _IncompleteTaskCheckingDetailCardState extends State<IncompleteTaskCheckingDetailCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextWidget(text: widget.taskName, heightConst: 0, widhtConst: 0, size: 25, fontWeight: FontWeight.w600, color: Colors.black),
          SizedBox(height: context.dynamicHeight(0.02),),
          TextWidget(text: "Bitiş Tarihi: ${widget.taskDeadline}", heightConst: 0, widhtConst: 0, size: 23, fontWeight: FontWeight.w600, color: Colors.black),
          SizedBox(height: context.dynamicHeight(0.02),),
          TextWidget(text: "Görev Atama Tarihi: ${widget.assignmentDate}", heightConst: 0, widhtConst: 0, size: 23, fontWeight: FontWeight.w600, color: Colors.black),
          SizedBox(height: context.dynamicHeight(0.02),),
          TextWidget(text: "Mağaza Kodu: ${widget.shop_code}", heightConst: 0, widhtConst: 0, size: 25, fontWeight: FontWeight.w600, color: Colors.black),
          SizedBox(height: context.dynamicHeight(0.02),),
          TextWidget(text: "Görev Türü: ${widget.taskType}", heightConst: 0, widhtConst: 0, size: 25, fontWeight: FontWeight.w600, color: Colors.black),
          SizedBox(height: context.dynamicHeight(0.1),),
          TextWidget(text: widget.taskDescription, heightConst: 0, widhtConst: 0, size: 20, fontWeight: FontWeight.w400, color: Colors.black),
          SizedBox(height: context.dynamicHeight(0.1),),
          ButtonWidget(text: "Fotoğrafı Görüntüle", heightConst: 0.06, widthConst: 0.8, size: 18, radius: 20, fontWeight: FontWeight.w600, onTaps: (){widget.onTapsShowPhoto();}, borderWidht: 3, backgroundColor: Colors.orangeAccent, borderColor: Colors.orangeAccent, textColor: Colors.black),
        ]
    );
  }
}
