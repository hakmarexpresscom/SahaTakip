import 'package:deneme/screens/remoteTasks/remoteTaskDetailScreen.dart';
import 'package:deneme/styles/context_extension.dart';
import 'package:deneme/widgets/button_widget.dart';
import 'package:deneme/widgets/text_widget.dart';
import 'package:flutter/material.dart';

import '../../screens/shopVisiting/userPM/visitingReport/pastReports/pastReportDetailScreen.dart';

class PastReportCard extends StatefulWidget {

  late double heightConst;
  late double widthConst;
  late String reportName;
  final VoidCallback onTaps;

  PastReportCard({Key? key, required this.heightConst,required this.widthConst, required this.reportName, required this.onTaps}): super(key: key);

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
        padding: EdgeInsets.fromLTRB(context.dynamicWidht(0.02), context.dynamicWidht(0.08), 0, 0),
        height: context.dynamicHeight(widget.heightConst),
        width: context.dynamicWidht(widget.widthConst),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextWidget(text: widget.reportName, heightConst: 0, widhtConst: 0, size: 22, fontWeight: FontWeight.w500, color: Colors.black),
            ButtonWidget(text: "Rapor Detayları", heightConst: 0.05, widthConst: 0.35, size: 15, radius: 20, fontWeight: FontWeight.w500, onTaps: (){widget.onTaps();}, borderWidht: 1, backgroundColor: Colors.lightGreen.withOpacity(0.6), borderColor: Colors.transparent, textColor: Colors.black),
          ],
        ),
      ),
    );
  }
}
