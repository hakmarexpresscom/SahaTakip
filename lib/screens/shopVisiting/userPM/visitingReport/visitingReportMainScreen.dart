import 'dart:async';
import 'package:deneme/constants/constants.dart';
import 'package:deneme/routing/bottomNavigationBar.dart';
import 'package:flutter/material.dart';

import 'enterVisitingReport.dart';

class VisitingRaportMainScreen extends StatefulWidget {
  const VisitingRaportMainScreen({super.key});

  @override
  State<VisitingRaportMainScreen> createState() =>
      _VisitingRaportMainScreenState();
}

class _VisitingRaportMainScreenState extends State<VisitingRaportMainScreen> {

  int _selectedIndex = 0;

  late double deviceHeight;
  late double deviceWidth;

  @override
  Widget build(BuildContext context) {

    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    return DefaultTabController(
        initialIndex: 0,
        length: 2,
        child:Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: Colors.indigo,
              title: const Text('Mağaza Ziyaret Raporu'),
              bottom: TabBar(
                tabs: [
                  Tab(text: "Rapor Girişi"),
                  Tab(text: "Geçmiş Raporlar")
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                SingleChildScrollView(child:enterVisitingReportUI(),),
                SingleChildScrollView(child:pastReportsScreenUI(),)
              ],
            ),
            bottomNavigationBar: BottomNaviBar(selectedIndex: _selectedIndex,itemList: itemListBS,pageList: pages,)
        ));
  }

  Widget enterVisitingReportUI(){
      return Container(
        child: EnterVisitingReportScreen(),
      );
  }

  Widget pastReportsScreenUI(){
    return Builder(builder: (BuildContext context){
      return Container();
    });
  }

}


