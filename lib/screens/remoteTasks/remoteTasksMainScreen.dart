import 'package:deneme/constants/constants.dart';
import 'package:deneme/routing/bottomNavigationBar.dart';
import 'package:deneme/widgets/button_widget.dart';
import 'package:deneme/widgets/cards/shopCard.dart';
import 'package:deneme/widgets/text_widget.dart';
import 'package:flutter/material.dart';

import '../../widgets/cards/taskCard.dart';

class RemoteTaskMainScreen extends StatefulWidget {
  const RemoteTaskMainScreen({super.key});

  @override
  State<RemoteTaskMainScreen> createState() =>
      _RemoteTaskMainScreenState();
}

class _RemoteTaskMainScreenState extends State<RemoteTaskMainScreen> {

  int _selectedIndex = 3;

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
          title: const Text('Uzaktan Görevler'),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(0, deviceWidth*0.04, 0, 0),
          child:Container(
            alignment: Alignment.center,
            child: navigationMainScreenUI(),
          ),
        ),
        bottomNavigationBar: BottomNaviBar(selectedIndex: _selectedIndex,itemList: itemListBS,pageList: pages,)
    );
  }

  Widget navigationMainScreenUI(){
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
                TaskCard(heightConst: 0.13, widthConst: 0.95, taskName: "Temizlik görevi"),
                SizedBox(height: deviceHeight*0.005,),
                TaskCard(heightConst: 0.13, widthConst: 0.95, taskName: "Temizlik görevi"),
                SizedBox(height: deviceHeight*0.005,),
                TaskCard(heightConst: 0.13, widthConst: 0.95, taskName: "Temizlik görevi"),
                SizedBox(height: deviceHeight*0.005,),
                TaskCard(heightConst: 0.13, widthConst: 0.95, taskName: "Temizlik görevi"),
                SizedBox(height: deviceHeight*0.005,),
                TaskCard(heightConst: 0.13, widthConst: 0.95, taskName: "Temizlik görevi"),
                SizedBox(height: deviceHeight*0.005,),
                TaskCard(heightConst: 0.13, widthConst: 0.95, taskName: "Temizlik görevi"),
                SizedBox(height: deviceHeight*0.005,),
                TaskCard(heightConst: 0.13, widthConst: 0.95, taskName: "Temizlik görevi"),
                SizedBox(height: deviceHeight*0.005,),
                TaskCard(heightConst: 0.13, widthConst: 0.95, taskName: "Temizlik görevi"),
                SizedBox(height: deviceHeight*0.005,),
                TaskCard(heightConst: 0.13, widthConst: 0.95, taskName: "Temizlik görevi"),
              ],
            )
          ],
        ),
      );
    });
  }
}


