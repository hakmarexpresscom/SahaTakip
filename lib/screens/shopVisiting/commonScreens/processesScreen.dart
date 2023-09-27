import 'dart:async';
import 'package:deneme/constants/constants.dart';
import 'package:deneme/routing/bottomNavigationBar.dart';
import 'package:deneme/screens/shopVisiting/commonScreens/shopClosingCheckingScreen.dart';
import 'package:deneme/screens/shopVisiting/commonScreens/shopOpeningCheckingScreen.dart';
import 'package:deneme/screens/shopVisiting/userBS/inPlaceTasks/inPlaceTasksMainScreen.dart';
import 'package:deneme/screens/shopVisiting/userBS/visitingReportTasks/visitingReportTasksMainScreen.dart';
import 'package:deneme/widgets/button_widget.dart';
import 'package:deneme/widgets/cards/shopVisitingProcessCard.dart';
import 'package:deneme/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'cashCountingScreen.dart';

class ShopVisitingProcessesScreen extends StatefulWidget {
  const ShopVisitingProcessesScreen({super.key});

  @override
  State<ShopVisitingProcessesScreen> createState() =>
      _ShopVisitingProcessesScreenState();
}

class _ShopVisitingProcessesScreenState extends State<ShopVisitingProcessesScreen> {

  int _selectedIndex = 0;

  late double deviceHeight;
  late double deviceWidth;

  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {

    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: const Text('Mağaza Ziyareti'),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child:Container(
            alignment: Alignment.center,
            child: shopVisitingProcessesScreenUI(),
          ),
        ),
        bottomNavigationBar: BottomNaviBar(selectedIndex: _selectedIndex,itemList: itemListBS,pageList: pages,)
    );
  }

  void navi(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context) => ShopOpeningCheckingScreen()));
  }
  void navi2(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context) => ShopClosingCheckingScreen()));
  }
  void navi3(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context) => VisitingReportTaskMainScreen()));
  }
  void navi4(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context) => InPlaceTaskMainScreen()));
  }
  void navi5(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context) => CashCountingScreen()));
  }


  Widget shopVisitingProcessesScreenUI(){
    return Builder(builder: (BuildContext context){
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              color: Colors.grey.withOpacity(0.6),
              height: deviceHeight*0.2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: [
                      SizedBox(height: deviceHeight*0.02,),
                      shopNameInfo(),
                      SizedBox(height: deviceHeight*0.03,),
                      hourInfo(),
                      SizedBox(height: deviceHeight*0.03,),
                      workDurationInfo(),
                    ],
                  ),
                  SizedBox(width: deviceWidth*0.05,),
                  stopVisitingButton(),
                ],
              ),
            ),
            SizedBox(height: deviceHeight*0.02,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ShopVisitingProcessCard(heightConst: 0.25, widthConst: 0.47, processName: "Mağaza\nAçılış\nKontrolü", processIcon: Icons.store,onTaps: (){navi(context);}),
                      ShopVisitingProcessCard(heightConst: 0.25, widthConst: 0.47, processName: "Mağaza\nKapanış\nKontrolü", processIcon: Icons.store,onTaps: (){navi2(context);}),
                    ]
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ShopVisitingProcessCard(heightConst: 0.25, widthConst: 0.47, processName: "Ziyaret\nRaporu\nGörevleri", processIcon: Icons.assignment,onTaps: (){navi3(context);}),
                      ShopVisitingProcessCard(heightConst: 0.25, widthConst: 0.47, processName: "Yerinde Görevler", processIcon: Icons.assignment,onTaps: (){navi4(context);}),
                    ]
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ShopVisitingProcessCard(heightConst: 0.25, widthConst: 0.47, processName: "Kasa Sayımı", processIcon: Icons.price_check,onTaps: (){navi5(context);}),
                    ]
                ),
              ],
            )


          ],
        ));
    });
  }


  Widget shopNameInfo(){
    return TextWidget(text: "Mağaza İsmi", heightConst: 0, widhtConst: 0, size: 25, fontWeight: FontWeight.w400, color: Colors.black);
  }
  Widget hourInfo(){
    return TextWidget(text: (now.hour+3).toString()+":"+now.minute.toString(), heightConst: 0, widhtConst: 0, size: 25, fontWeight: FontWeight.w400, color: Colors.black);
  }
  Widget workDurationInfo(){
    return TextWidget(text: "Work Duration", heightConst: 0, widhtConst: 0, size: 25, fontWeight: FontWeight.w400, color: Colors.black);
  }
  Widget stopVisitingButton(){
    return ButtonWidget(text: "Ziyareti Durdur", heightConst: 0.05, widthConst: 0.33, size: 15, radius: 20, fontWeight: FontWeight.w600, onTaps: (){}, borderWidht: 1, backgroundColor: Colors.red.withOpacity(0.6), borderColor: Colors.red.withOpacity(0.6), textColor: Colors.black);
  }

}


