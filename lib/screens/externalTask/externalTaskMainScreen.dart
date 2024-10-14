import 'package:deneme/styles/styleConst.dart';
import 'package:flutter/material.dart';
import '../../constants/bottomNaviBarLists.dart';
import '../../constants/constants.dart';
import '../../constants/pagesLists.dart';
import '../../routing/bottomNavigationBar.dart';
import '../../routing/landing.dart';
import '../../widgets/button_widget.dart';

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
        if(isStartShiftObs.value==false&&isRegionCenterVisitInProgress.value==false){
          pageList = pagesBS;
        }
        else if(isStartShiftObs.value&&isRegionCenterVisitInProgress.value==false){
          pageList = pagesBS2;
        }
      }
      if(user=="PM"){
        naviBarList = itemListPM;
        if(isStartShiftObs.value==false&&isRegionCenterVisitInProgress.value==false){
          pageList = pagesPM;
        }
        else if(isStartShiftObs.value&&isRegionCenterVisitInProgress.value==false){
          pageList = pagesPM2;
        }
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
          automaticallyImplyLeading: false,
          foregroundColor: appbarForeground,
          backgroundColor: appbarBackground,
          title: const Text('Harici İş'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              naviShiftTypeScreen(context);
            },
          ),
        ),
        body: PopScope(
          canPop: false,
          onPopInvoked: (bool didPop) {},
            child:SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child:Container(
                alignment: Alignment.center,
                child: externalTaskMainScreenUI(),
              ),
          )
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
            SizedBox(height: deviceHeight*0.08,),
            externalWorkButton(),
            SizedBox(height: deviceHeight*0.03,),
            addExternalWorkButton(),
          ],
        ),
      );
    });
  }


  Widget externalWorkButton(){
    return ButtonWidget(
        text: "Harici İşlerim",
        heightConst: 0.06,
        widthConst: 0.8,
        size: 18,
        radius: 20,
        fontWeight: FontWeight.w600,
        onTaps: (){
          naviExternalTasksListScreen(context);
          },
        borderWidht: 1,
        backgroundColor: secondaryColor,
        borderColor: secondaryColor,
        textColor: textColor);
  }

  Widget addExternalWorkButton(){
    return ButtonWidget(
        text: "Harici İş Girişi",
        heightConst: 0.06,
        widthConst: 0.8,
        size: 18,
        radius: 20,
        fontWeight: FontWeight.w600,
        onTaps: (){
          naviEnterExternalTaskScreen(context);
          },
        borderWidht: 3,
        backgroundColor: primaryColor,
        borderColor: primaryColor,
        textColor: textColor);
  }

}
