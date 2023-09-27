import 'package:deneme/constants/constants.dart';
import 'package:deneme/routing/bottomNavigationBar.dart';
import 'package:flutter/material.dart';
import '../../../widgets/cards/taskCard.dart';


class ExternalTasksMainScreen extends StatefulWidget {
  const ExternalTasksMainScreen({super.key});

  @override
  State<ExternalTasksMainScreen> createState() =>
      _ExternalTasksMainScreenState();
}

class _ExternalTasksMainScreenState extends State<ExternalTasksMainScreen> {

  int _selectedIndex = 4; //bu değişken other main screen'deki değerle aynı olucak çünkü o sayfanın altında

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
          title: const Text('Harici İşlerim'),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child:Container(
            alignment: Alignment.center,
            child: externalTasksMainScreenUI(),
          ),
        ),
        bottomNavigationBar: BottomNaviBar(selectedIndex: _selectedIndex,itemList: itemListBS,pageList: pages,)
    );
  }

  Widget externalTasksMainScreenUI(){
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


