import 'dart:async';
import 'package:deneme/constants/constants.dart';
import 'package:deneme/routing/bottomNavigationBar.dart';
import 'package:deneme/widgets/button_widget.dart';
import 'package:deneme/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import '../../routing/landing.dart';


// konum erişimi eklenicek
// work duration fonksiyonu yazılacak


class StartWorkMainScreen extends StatefulWidget {
  const StartWorkMainScreen({super.key});

  @override
  State<StartWorkMainScreen> createState() =>
      _StartWorkMainScreenState();
}

class _StartWorkMainScreenState extends State<StartWorkMainScreen> {

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
        _selectedIndex = 0;
      }
      if(user=="PM"){
        naviBarList = itemListPM;
        pageList = pagesPM;
        _selectedIndex = 0;
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

    userCondition(userType); //utils dosyasındaki fonksiyonu çekmiyor sebebine bakılacak

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text('Mesaiye Başla'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(0, deviceHeight*0.2, 0, 0),
        child:Container(
          alignment: Alignment.center,
          child: startWorkMainScreenUI(),
        ),
      ),
      bottomNavigationBar: BottomNaviBar(selectedIndex: _selectedIndex,itemList: naviBarList,pageList: pageList,)
    );
  }

  Widget startWorkMainScreenUI(){
    return Builder(builder: (BuildContext context){
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            locationInfo(),
            SizedBox(height: deviceHeight*0.03,),
            hourInfo(),
            SizedBox(height: deviceHeight*0.03,),
            workDurationInfo(),
            SizedBox(height: deviceHeight*0.09,),
            startWorkButton(),
            SizedBox(height: deviceHeight*0.03,),
            finishWorkButton(),
          ],
        ),
      );
    });
  }


  Widget locationInfo(){
    return TextWidget(text: "My Location", heightConst: 0, widhtConst: 0, size: 25, fontWeight: FontWeight.w400, color: Colors.black);
  }
  Widget hourInfo(){
    return TextWidget(text: (now.hour+3).toString()+":"+now.minute.toString(), heightConst: 0, widhtConst: 0, size: 25, fontWeight: FontWeight.w400, color: Colors.black);
  }
  Widget workDurationInfo(){
    return TextWidget(text: "Work Duration", heightConst: 0, widhtConst: 0, size: 25, fontWeight: FontWeight.w400, color: Colors.black);
  }
  Widget startWorkButton(){
    return ButtonWidget(text: "Mesaiye Başla", heightConst: 0.06, widthConst: 0.8, size: 18, radius: 20, fontWeight: FontWeight.w600, onTaps: (){naviShopVisitingShopsScreen(context);}, borderWidht: 1, backgroundColor: Colors.lightGreen.withOpacity(0.6), borderColor: Colors.lightGreen.withOpacity(0.6), textColor: Colors.black);
  }
  Widget finishWorkButton(){
    return ButtonWidget(text: "Mesaiyi Bitir", heightConst: 0.06, widthConst: 0.8, size: 18, radius: 20, fontWeight: FontWeight.w600, onTaps: (){}, borderWidht: 3, backgroundColor: Colors.orangeAccent, borderColor: Colors.orangeAccent, textColor: Colors.black);
  }
}


