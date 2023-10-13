import 'package:deneme/constants/constants.dart';
import 'package:deneme/routing/bottomNavigationBar.dart';
import 'package:flutter/material.dart';
import '../../routing/landing.dart';
import '../../widgets/cards/taskCard.dart';


class ExternalTasksListScreen extends StatefulWidget {
  const ExternalTasksListScreen({super.key});

  @override
  State<ExternalTasksListScreen> createState() =>
      _ExternalTasksListScreenState();
}

class _ExternalTasksListScreenState extends State<ExternalTasksListScreen> {

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
        _selectedIndex = 3;
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
          title: const Text('Harici İşlerim'),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(0, deviceHeight*0.03, 0, 0),
          child:Container(
            alignment: Alignment.center,
            child: externalTasksMainScreenUI(),
          ),
        ),
        bottomNavigationBar: BottomNaviBar(selectedIndex: _selectedIndex,itemList: naviBarList,pageList: pageList,)
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
                TaskCard(heightConst: 0.13, widthConst: 0.95, taskName: "Temizlik görevi",onTaps: (){naviExternalTaskDetailScreen(context);}),
                SizedBox(height: deviceHeight*0.005,),
                TaskCard(heightConst: 0.13, widthConst: 0.95, taskName: "Temizlik görevi",onTaps: (){naviExternalTaskDetailScreen(context);}),
                SizedBox(height: deviceHeight*0.005,),
                TaskCard(heightConst: 0.13, widthConst: 0.95, taskName: "Temizlik görevi",onTaps: (){naviExternalTaskDetailScreen(context);}),
                SizedBox(height: deviceHeight*0.005,),
                TaskCard(heightConst: 0.13, widthConst: 0.95, taskName: "Temizlik görevi",onTaps: (){naviExternalTaskDetailScreen(context);}),
                SizedBox(height: deviceHeight*0.005,),
                TaskCard(heightConst: 0.13, widthConst: 0.95, taskName: "Temizlik görevi",onTaps: (){naviExternalTaskDetailScreen(context);}),
                SizedBox(height: deviceHeight*0.005,),
                TaskCard(heightConst: 0.13, widthConst: 0.95, taskName: "Temizlik görevi",onTaps: (){naviExternalTaskDetailScreen(context);}),
                SizedBox(height: deviceHeight*0.005,),
                TaskCard(heightConst: 0.13, widthConst: 0.95, taskName: "Temizlik görevi",onTaps: (){naviExternalTaskDetailScreen(context);}),
                SizedBox(height: deviceHeight*0.005,),
                TaskCard(heightConst: 0.13, widthConst: 0.95, taskName: "Temizlik görevi",onTaps: (){naviExternalTaskDetailScreen(context);}),
                SizedBox(height: deviceHeight*0.005,),
                TaskCard(heightConst: 0.13, widthConst: 0.95, taskName: "Temizlik görevi",onTaps: (){naviExternalTaskDetailScreen(context);}),
              ],
            )
          ],
        ),
      );
    });
  }
}


