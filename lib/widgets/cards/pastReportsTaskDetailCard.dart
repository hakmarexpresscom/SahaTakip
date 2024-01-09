import 'package:deneme/styles/context_extension.dart';
import 'package:flutter/material.dart';
import '../button_widget.dart';
import '../rich_text_widget.dart';

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
  late String? answerNote;

  PastReportTaskDetailCard ({ Key? key, required this.heightConst, required this.widthConst,required this.taskName,required this.taskDescription,required this.taskDeadline, required this.taskType, required this.onTapsShowPhoto ,required this.id,required this.assignmentDate, required this.shop_code, required this.photo_id, required this.completeDate, required this. completionInfo, required this.answerNote}): super(key: key);

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
          RichTextWidget(title: " Görev İsmi: ", text: widget.taskName, size: 20, fontWeightTitle: FontWeight.w600, fontWeightText: FontWeight.w400, color: Colors.black),
          SizedBox(height: context.dynamicHeight(0.02),),
          RichTextWidget(title: " Görev Bitiş Tarihi: ", text: widget.taskDeadline, size: 20, fontWeightTitle: FontWeight.w600, fontWeightText: FontWeight.w400, color: Colors.black),
          SizedBox(height: context.dynamicHeight(0.02),),
          RichTextWidget(title: " Görev Atama Tarihi: ", text: widget.assignmentDate, size: 20, fontWeightTitle: FontWeight.w600, fontWeightText: FontWeight.w400, color: Colors.black),
          SizedBox(height: context.dynamicHeight(0.02),),
          (widget.completionInfo==1)? RichTextWidget(title: " Görev Tamamlanma Tarihi: ", text: widget.completeDate, size: 20, fontWeightTitle: FontWeight.w600, fontWeightText: FontWeight.w400, color: Colors.black) : SizedBox(height: context.dynamicHeight(0.0),),
          (widget.completionInfo==1)?SizedBox(height: context.dynamicHeight(0.02),):SizedBox(height: context.dynamicHeight(0.0),),
          RichTextWidget(title: " Mağaza Kodu: ", text: "${widget.shop_code}", size: 20, fontWeightTitle: FontWeight.w600, fontWeightText: FontWeight.w400, color: Colors.black),
          SizedBox(height: context.dynamicHeight(0.02),),
          RichTextWidget(title: " Görev Türü: ", text: widget.taskType, size: 20, fontWeightTitle: FontWeight.w600, fontWeightText: FontWeight.w400, color: Colors.black),
          SizedBox(height: context.dynamicHeight(0.02),),
          RichTextWidget(title: " Görev Detayı: ", text: widget.taskDescription, size: 20, fontWeightTitle: FontWeight.w600, fontWeightText: FontWeight.w400, color: Colors.black),
          SizedBox(height: context.dynamicHeight(0.02),),
          (widget.completionInfo==1)? (widget.answerNote==""||widget.answerNote==null) ? RichTextWidget(title: " Cevap Notu: ", text: "Cevap notu girilmemiş.", size: 20, fontWeightTitle: FontWeight.w600, fontWeightText: FontWeight.w400, color: Colors.black) : RichTextWidget(title: " Cevap Notu: ", text: widget.answerNote!, size: 20, fontWeightTitle: FontWeight.w600, fontWeightText: FontWeight.w400, color: Colors.black) : SizedBox(height: context.dynamicHeight(0.0),),
          (widget.completionInfo==1)?SizedBox(height: context.dynamicHeight(0.02),):SizedBox(height: context.dynamicHeight(0.0),),
          SizedBox(height: context.dynamicHeight(0.05),),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              (widget.completionInfo==1)?ButtonWidget(text: "Cevap Fotoğrafı Görüntüle", heightConst: 0.06, widthConst: 0.8, size: 18, radius: 20, fontWeight: FontWeight.w600, onTaps: (){widget.onTapsShowPhoto();}, borderWidht: 3, backgroundColor: Colors.orangeAccent, borderColor: Colors.orangeAccent, textColor: Colors.black):ButtonWidget(text: "Fotoğrafı Görüntüle", heightConst: 0.06, widthConst: 0.8, size: 18, radius: 20, fontWeight: FontWeight.w600, onTaps: (){widget.onTapsShowPhoto();}, borderWidht: 3, backgroundColor: Colors.orangeAccent, borderColor: Colors.orangeAccent, textColor: Colors.black),
            ],
          ),
        ]
    );
  }
}
