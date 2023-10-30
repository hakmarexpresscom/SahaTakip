import 'dart:async';
import 'package:deneme/constants/constants.dart';
import 'package:deneme/routing/bottomNavigationBar.dart';
import 'package:deneme/widgets/button_widget.dart';
import 'package:deneme/widgets/cards/shopVisitingProcessCard.dart';
import 'package:deneme/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import '../../../constants/bottomNaviBarLists.dart';
import '../../../constants/pagesLists.dart';
import '../../../routing/landing.dart';
import 'cashCountingScreen.dart';

class ShopVisitingProcessesScreen extends StatefulWidget {
  int shop_code = 0;
  ShopVisitingProcessesScreen({super.key, required this.shop_code});

  @override
  State<ShopVisitingProcessesScreen> createState() =>
      _ShopVisitingProcessesScreenState();
}

class _ShopVisitingProcessesScreenState extends State<ShopVisitingProcessesScreen> {

  int _selectedIndex = 0;

  List<BottomNavigationBarItem> naviBarList = [];
  List<Widget> pageList = [];

  late double deviceHeight;
  late double deviceWidth;

  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {

    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    void userCondition(String user){
      if(user=="BS"){
        naviBarList = itemListBS;
        pageList = pagesBS;
      }
      if(user=="PM"){
        naviBarList = itemListPM;
        pageList = pagesPM;
      }
      if(user=="BM" || user=="GK"){
        naviBarList = itemListBMandGK;
        pageList = pagesBMGK;
      }
      if(user=="NK"){
        naviBarList = itemListNK;
        pageList = pagesNK;
      }
    }

    userCondition(userType);

    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: const Text('Mağaza Ziyareti'),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child:Container(
            alignment: Alignment.center,
            child: (isBS)?shopVisitingProcessesScreenBSUI():shopVisitingProcessesScreenPMUI(),
          ),
        ),
        bottomNavigationBar: BottomNaviBar(selectedIndex: _selectedIndex,itemList: naviBarList,pageList: pageList,)
    );
  }

  Widget shopVisitingProcessesScreenBSUI(){
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
                      ShopVisitingProcessCard(heightConst: 0.25, widthConst: 0.47, processName: "Mağaza\nAçılış\nKontrolü", processIcon: Icons.store,onTaps: (){naviShopOpeningCheckingScreen(context);}),
                      ShopVisitingProcessCard(heightConst: 0.25, widthConst: 0.47, processName: "Mağaza\nKapanış\nKontrolü", processIcon: Icons.store,onTaps: (){naviShopClosingCheckingScreen(context);}),
                    ]
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ShopVisitingProcessCard(heightConst: 0.25, widthConst: 0.47, processName: "Ziyaret\nRaporu\nGörevleri", processIcon: Icons.assignment,onTaps: (){naviVisitingReportTaskMainScreen(context);}),
                      ShopVisitingProcessCard(heightConst: 0.25, widthConst: 0.47, processName: "Yerinde Görevler", processIcon: Icons.assignment,onTaps: (){naviInPlaceTaskMainScreen(context, widget.shop_code);}),
                    ]
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ShopVisitingProcessCard(heightConst: 0.25, widthConst: 0.47, processName: "Kasa Sayımı", processIcon: Icons.price_check,onTaps: (){naviCashCountingScreen(context);}),
                    ]
                ),
              ],
            )
          ],
        ));
    });
  }

  Widget shopVisitingProcessesScreenPMUI(){
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
                        ShopVisitingProcessCard(heightConst: 0.25, widthConst: 0.47, processName: "Mağaza\nAçılış\nKontrolü", processIcon: Icons.store,onTaps: (){naviShopOpeningCheckingScreen(context);}),
                        ShopVisitingProcessCard(heightConst: 0.25, widthConst: 0.47, processName: "Mağaza\nKapanış\nKontrolü", processIcon: Icons.store,onTaps: (){naviShopClosingCheckingScreen(context);}),
                      ]
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        ShopVisitingProcessCard(heightConst: 0.25, widthConst: 0.47, processName: "Ziyaret\nRaporu\nGirişi", processIcon: Icons.assignment,onTaps: (){naviVisitingReportMainScreen(context);}),
                        ShopVisitingProcessCard(heightConst: 0.25, widthConst: 0.47, processName: "Kasa Sayımı", processIcon: Icons.price_check,onTaps: (){naviCashCountingScreen(context);}),
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


