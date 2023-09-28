import 'package:deneme/constants/constants.dart';
import 'package:deneme/routing/bottomNavigationBar.dart';
import 'package:deneme/widgets/cards/pastReportCard.dart';
import 'package:deneme/widgets/cards/pastReportsDetailCard.dart';
import 'package:flutter/material.dart';


class PastReportDetailScreen extends StatefulWidget {
  const PastReportDetailScreen({super.key});

  @override
  State<PastReportDetailScreen> createState() =>
      _PastReportDetailScreenState();
}

class _PastReportDetailScreenState extends State<PastReportDetailScreen> {

  int _selectedIndex = 0;

  late double deviceHeight;
  late double deviceWidth;

  @override
  Widget build(BuildContext context) {

    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: const Text('Rapor Detayları'),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(0, deviceWidth*0.04, 0, 0),
          child:Container(
            alignment: Alignment.center,
            child: pastReportDetailScreenUI(),
          ),
        ),
        bottomNavigationBar: BottomNaviBar(selectedIndex: _selectedIndex,itemList: itemListBS,pageList: pages,)
    );
  }

  Widget pastReportDetailScreenUI(){
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
                PastReportsDetailCard(heightConstContainer: 0.20, widthConstContainer: 0.95, taskName: "Temizlik Görevi",isCompleted: true,personName: "Elif Ünlü",size: 22),
                SizedBox(height: deviceHeight*0.005,),
                PastReportsDetailCard(heightConstContainer: 0.20, widthConstContainer: 0.95, taskName: "Temizlik Görevi",isCompleted: true,personName: "Elif Ünlü",size: 22),
                SizedBox(height: deviceHeight*0.005,),
                PastReportsDetailCard(heightConstContainer: 0.20, widthConstContainer: 0.95, taskName: "Temizlik Görevi",isCompleted: false,personName: "Elif Ünlü",size: 22),
                SizedBox(height: deviceHeight*0.005,),
                PastReportsDetailCard(heightConstContainer: 0.20, widthConstContainer: 0.95, taskName: "Temizlik Görevi",isCompleted: true,personName: "Elif Ünlü",size: 22),
                SizedBox(height: deviceHeight*0.005,),
                PastReportsDetailCard(heightConstContainer: 0.20, widthConstContainer: 0.95, taskName: "Temizlik Görevi",isCompleted: true,personName: "Elif Ünlü",size: 22),
                SizedBox(height: deviceHeight*0.005,),
                PastReportsDetailCard(heightConstContainer: 0.20, widthConstContainer: 0.95, taskName: "Temizlik Görevi",isCompleted: false,personName: "Elif Ünlü",size: 22),
                SizedBox(height: deviceHeight*0.005,),
                PastReportsDetailCard(heightConstContainer: 0.20, widthConstContainer: 0.95, taskName: "Temizlik Görevi",isCompleted: true,personName: "Elif Ünlü",size: 22),
                SizedBox(height: deviceHeight*0.005,),
                PastReportsDetailCard(heightConstContainer: 0.20, widthConstContainer: 0.95, taskName: "Temizlik Görevi",isCompleted: true,personName: "Elif Ünlü",size: 22),
                SizedBox(height: deviceHeight*0.005,),
                PastReportsDetailCard(heightConstContainer: 0.20, widthConstContainer: 0.95, taskName: "Temizlik Görevi",isCompleted: true,personName: "Elif Ünlü",size: 22),
              ],
            )
          ],
        ),
      );
    });
  }
}



