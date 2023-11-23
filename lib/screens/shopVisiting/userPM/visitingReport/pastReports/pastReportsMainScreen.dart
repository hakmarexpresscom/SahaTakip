import 'package:deneme/widgets/cards/pastReportCard.dart';
import 'package:flutter/material.dart';
import '../../../../../routing/landing.dart';


class PastReportsMainScreen extends StatefulWidget {
  const PastReportsMainScreen({super.key});

  @override
  State<PastReportsMainScreen> createState() =>
      _PastReportsMainScreenState();
}

class _PastReportsMainScreenState extends State<PastReportsMainScreen> {

  int _selectedIndex = 0;

  late double deviceHeight;
  late double deviceWidth;

  @override
  Widget build(BuildContext context) {

    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(0, deviceHeight*0.03, 0, 0),
          child:Container(
            alignment: Alignment.center,
            child: pastReportsMainScreenUI(),
          ),
        ),
    );
  }

  Widget pastReportsMainScreenUI(){
    return Builder(builder: (BuildContext context){
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                PastReportCard(heightConst: 0.15, widthConst: 0.95, reportName: "Rapor1",onTaps: (){naviPastReportDetailScreen(context);}),
                SizedBox(height: deviceHeight*0.005,),
                PastReportCard(heightConst: 0.15, widthConst: 0.95, reportName: "Rapor1",onTaps: (){naviPastReportDetailScreen(context);}),
                SizedBox(height: deviceHeight*0.005,),
                PastReportCard(heightConst: 0.15, widthConst: 0.95, reportName: "Rapor1",onTaps: (){naviPastReportDetailScreen(context);}),
                SizedBox(height: deviceHeight*0.005,),
                PastReportCard(heightConst: 0.15, widthConst: 0.95, reportName: "Rapor1",onTaps: (){naviPastReportDetailScreen(context);}),
                SizedBox(height: deviceHeight*0.005,),
                PastReportCard(heightConst: 0.15, widthConst: 0.95, reportName: "Rapor1",onTaps: (){naviPastReportDetailScreen(context);}),
                SizedBox(height: deviceHeight*0.005,),
                PastReportCard(heightConst: 0.15, widthConst: 0.95, reportName: "Rapor1",onTaps: (){naviPastReportDetailScreen(context);}),
                SizedBox(height: deviceHeight*0.005,),
                PastReportCard(heightConst: 0.15, widthConst: 0.95, reportName: "Rapor1",onTaps: (){naviPastReportDetailScreen(context);}),
                SizedBox(height: deviceHeight*0.005,),
                PastReportCard(heightConst: 0.15, widthConst: 0.95, reportName: "Rapor1",onTaps: (){naviPastReportDetailScreen(context);}),
                SizedBox(height: deviceHeight*0.005,),
                PastReportCard(heightConst: 0.15, widthConst: 0.95, reportName: "Rapor1",onTaps: (){naviPastReportDetailScreen(context);}),
              ],
            )
          ],
        ),
      );
    });
  }
}



