import 'package:deneme/styles/context_extension.dart';
import 'package:deneme/widgets/text_widget.dart';
import 'package:flutter/material.dart';

import '../button_widget.dart';

class PastReportTaskDetailCard extends StatefulWidget {

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
  late String completeDate;
  late int completionInfo;

  PastReportTaskDetailCard ({ Key? key, required this.heightConst, required this.widthConst,required this.taskName,required this.taskDescription,required this.taskDeadline, required this.taskType, required this.onTapsShowPhoto ,required this.id,required this.assignmentDate, required this.shop_code, required this.photo_id, required this.completeDate, required this. completionInfo}): super(key: key);

  @override
  State<PastReportTaskDetailCard> createState() => _IncompleteTaskCheckingDetailCardState();
}

class _IncompleteTaskCheckingDetailCardState extends State<PastReportTaskDetailCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextWidget(text: widget.taskName, heightConst: 0, widhtConst: 0, size: 25, fontWeight: FontWeight.w600, color: Colors.black),
          SizedBox(height: context.dynamicHeight(0.07),),
          TextWidget(text: "Bitiş Tarihi: ${widget.taskDeadline}", heightConst: 0, widhtConst: 0, size: 20, fontWeight: FontWeight.w600, color: Colors.black),
          SizedBox(height: context.dynamicHeight(0.02),),
          TextWidget(text: "Görev Atama Tarihi: ${widget.assignmentDate}", heightConst: 0, widhtConst: 0, size: 20, fontWeight: FontWeight.w600, color: Colors.black),
          SizedBox(height: context.dynamicHeight(0.02),),
          (widget.completionInfo==1)?TextWidget(text: "Görev Tamamlanma Tarihi: ${widget.completeDate}", heightConst: 0, widhtConst: 0, size: 20, fontWeight: FontWeight.w600, color: Colors.black):SizedBox(height: context.dynamicHeight(0.0),),
          (widget.completionInfo==1)?SizedBox(height: context.dynamicHeight(0.02),):SizedBox(height: context.dynamicHeight(0.0),),
          TextWidget(text: "Mağaza Kodu: ${widget.shop_code}", heightConst: 0, widhtConst: 0, size: 20, fontWeight: FontWeight.w600, color: Colors.black),
          SizedBox(height: context.dynamicHeight(0.02),),
          TextWidget(text: "Görev Türü: ${widget.taskType}", heightConst: 0, widhtConst: 0, size: 20, fontWeight: FontWeight.w600, color: Colors.black),
          SizedBox(height: context.dynamicHeight(0.1),),
          TextWidget(text: widget.taskDescription, heightConst: 0, widhtConst: 0, size: 20, fontWeight: FontWeight.w400, color: Colors.black),
          SizedBox(height: context.dynamicHeight(0.1),),
          (widget.completionInfo==1)?ButtonWidget(text: "Cevap Fotoğrafı Görüntüle", heightConst: 0.06, widthConst: 0.8, size: 18, radius: 20, fontWeight: FontWeight.w600, onTaps: (){widget.onTapsShowPhoto();}, borderWidht: 3, backgroundColor: Colors.orangeAccent, borderColor: Colors.orangeAccent, textColor: Colors.black):ButtonWidget(text: "Fotoğrafı Görüntüle", heightConst: 0.06, widthConst: 0.8, size: 18, radius: 20, fontWeight: FontWeight.w600, onTaps: (){widget.onTapsShowPhoto();}, borderWidht: 3, backgroundColor: Colors.orangeAccent, borderColor: Colors.orangeAccent, textColor: Colors.black),
        ]
    );
  }
}
