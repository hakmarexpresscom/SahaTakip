import 'package:deneme/styles/context_extension.dart';
import 'package:deneme/widgets/button_widget.dart';
import 'package:deneme/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class PastReportCard extends StatefulWidget {

  late double heightConst;
  late double widthConst;
  late String reportName;
  late String createDate;
  final VoidCallback onTaps;

  PastReportCard({Key? key, required this.heightConst,required this.widthConst, required this.reportName,required this.createDate, required this.onTaps}): super(key: key);

  @override
  State<PastReportCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<PastReportCard> {

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
        height: context.dynamicHeight(widget.heightConst),
        width: context.dynamicWidth(widget.widthConst),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [Icon(Icons.file_copy,size: 35,),],
            ),
            TextWidget(text: widget.reportName, size: 20, fontWeight: FontWeight.w500, color: Colors.black),
            SizedBox(height: context.dynamicHeight(0.02),),
            TextWidget(text: "Oluşturulma tarihi: "+widget.createDate, size: 20, fontWeight: FontWeight.w500, color: Colors.black),
            SizedBox(height: context.dynamicHeight(0.025),),
            ButtonWidget(text: "Rapor Detayları", heightConst: 0.04, widthConst: 0.35, size: 13, radius: 20, fontWeight: FontWeight.w500, onTaps: (){widget.onTaps();}, borderWidht: 1, backgroundColor: Colors.lightGreen.withOpacity(0.6), borderColor: Colors.transparent, textColor: Colors.black),
          ],
        ),
      ),
    );
  }
}
