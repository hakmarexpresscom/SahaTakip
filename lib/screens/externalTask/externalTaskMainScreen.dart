import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../routing/bottomNavigationBar.dart';
import '../../routing/landing.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/text_widget.dart';

class ExternalTaskMainScreen extends StatefulWidget {
  const ExternalTaskMainScreen({super.key});

  @override
  State<ExternalTaskMainScreen> createState() => _ExternalTaskMainScreenState();
}

class _ExternalTaskMainScreenState extends State<ExternalTaskMainScreen> {

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
          title: const Text('Harici İş'),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child:Container(
            alignment: Alignment.center,
            child: externalTaskMainScreenUI(),
          ),
        ),
        bottomNavigationBar: BottomNaviBar(selectedIndex: _selectedIndex,itemList: naviBarList,pageList: pageList,)
    );
  }

  Widget externalTaskMainScreenUI(){
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: deviceHeight*0.02,),
                      hourInfo(),
                      SizedBox(height: deviceHeight*0.03,),
                      workDurationInfo(),
                    ],
                  ),
                  SizedBox(width: deviceWidth*0.05,),
                  stopExternalTaskButton(),
                ],
              ),
            ),
            SizedBox(height: deviceHeight*0.08,),
            externalWorkButton(),
            SizedBox(height: deviceHeight*0.05,),
            addExternalWorkButton()
          ],
        ),
      );
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
  Widget stopExternalTaskButton(){
    return ButtonWidget(text: "Harici İşi Durdur", heightConst: 0.05, widthConst: 0.33, size: 15, radius: 20, fontWeight: FontWeight.w600, onTaps: (){}, borderWidht: 1, backgroundColor: Colors.red.withOpacity(0.6), borderColor: Colors.red.withOpacity(0.6), textColor: Colors.black);
  }
  Widget externalWorkButton(){
    return ButtonWidget(text: "Harici İşlerim", heightConst: 0.06, widthConst: 0.8, size: 18, radius: 20, fontWeight: FontWeight.w600, onTaps: (){naviExternalTasksListScreen(context);}, borderWidht: 1, backgroundColor: Colors.lightGreen.withOpacity(0.6), borderColor: Colors.lightGreen.withOpacity(0.6), textColor: Colors.black);
  }
  Widget addExternalWorkButton(){
    return ButtonWidget(text: "Harici İş Girişi", heightConst: 0.06, widthConst: 0.8, size: 18, radius: 20, fontWeight: FontWeight.w600, onTaps: (){naviEnterExternalTaskScreen(context);}, borderWidht: 3, backgroundColor: Colors.orangeAccent, borderColor: Colors.orangeAccent, textColor: Colors.black);
  }

}
