import 'package:deneme/constants/constants.dart';
import 'package:deneme/routing/bottomNavigationBar.dart';
import 'package:deneme/screens/other/externalTasks/enterExternalTaskScreen.dart';
import 'package:deneme/screens/other/externalTasks/externalTasksMainScreen.dart';
import 'package:deneme/widgets/button_widget.dart';
import 'package:flutter/material.dart';


class OtherMainScreen extends StatefulWidget {
  const OtherMainScreen({super.key});

  @override
  State<OtherMainScreen> createState() =>
      _OtherMainScreenState();
}

class _OtherMainScreenState extends State<OtherMainScreen> {

  int _selectedIndex = 4;

  List<BottomNavigationBarItem> naviBarList = [];
  List<Widget> pageList = [];

  late double deviceHeight;
  late double deviceWidth;

  @override
  Widget build(BuildContext context) {

    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    void userCondition(String user){
      if(user=="BS"){
        naviBarList = itemListBS;
        pageList = pagesBS;
        _selectedIndex = 4;
      }
      if(user=="PM"){
        naviBarList = itemListPM;
        pageList = pagesPM;
        _selectedIndex = 5;
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
          title: const Text('Diğer'),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(0, deviceWidth*0.1, 0, 0),
          child:Container(
            alignment: Alignment.center,
            child: otherMainScreenUI(),
          ),
        ),
        bottomNavigationBar: BottomNaviBar(selectedIndex: _selectedIndex,itemList: naviBarList,pageList: pageList,)
    );
  }

  Widget otherMainScreenUI(){
    return Builder(builder: (BuildContext context){
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            externalWorkButton(),
            SizedBox(height: deviceHeight*0.03,),
            addExternalWorkButton(),
            SizedBox(height: deviceHeight*0.03,),
            logoutButton()
          ],
        ),
      );
    });
  }

  void navi(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context) => ExternalTasksMainScreen()));
  }
  void navi2(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context) => EnterExternalTaskScreen()));
  }

  Widget externalWorkButton(){
    return ButtonWidget(text: "Harici İşlerim", heightConst: 0.06, widthConst: 0.8, size: 18, radius: 20, fontWeight: FontWeight.w600, onTaps: (){navi(context);}, borderWidht: 1, backgroundColor: Colors.lightGreen.withOpacity(0.6), borderColor: Colors.lightGreen.withOpacity(0.6), textColor: Colors.black);
  }
  Widget addExternalWorkButton(){
    return ButtonWidget(text: "Harici İş Girişi", heightConst: 0.06, widthConst: 0.8, size: 18, radius: 20, fontWeight: FontWeight.w600, onTaps: (){navi2(context);}, borderWidht: 3, backgroundColor: Colors.orangeAccent, borderColor: Colors.orangeAccent, textColor: Colors.black);
  }
  Widget logoutButton(){
    return ButtonWidget(text: "Çıkış yap", heightConst: 0.06, widthConst: 0.8, size: 18, radius: 20, fontWeight: FontWeight.w600, onTaps: (){}, borderWidht: 1, backgroundColor: Colors.lightGreen.withOpacity(0.6), borderColor: Colors.lightGreen.withOpacity(0.6), textColor: Colors.black);
  }
}


