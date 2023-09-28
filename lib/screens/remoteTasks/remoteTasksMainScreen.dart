import 'package:deneme/constants/constants.dart';
import 'package:deneme/routing/bottomNavigationBar.dart';
import 'package:deneme/screens/remoteTasks/remoteTaskDetailScreen.dart';
import 'package:flutter/material.dart';
import '../../routing/landing.dart';
import '../../widgets/cards/taskCard.dart';

class RemoteTaskMainScreen extends StatefulWidget {
  const RemoteTaskMainScreen({super.key});

  @override
  State<RemoteTaskMainScreen> createState() =>
      _RemoteTaskMainScreenState();
}

class _RemoteTaskMainScreenState extends State<RemoteTaskMainScreen> {

  int _selectedIndex = 3;

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
          title: const Text('Uzaktan Görevler'),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(0, deviceWidth*0.04, 0, 0),
          child:Container(
            alignment: Alignment.center,
            child: remoteTaskMainScreenUI(),
          ),
        ),
        bottomNavigationBar: BottomNaviBar(selectedIndex: _selectedIndex,itemList: naviBarList,pageList: pageList,)
    );
  }

  Widget remoteTaskMainScreenUI(){
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
                TaskCard(heightConst: 0.13, widthConst: 0.95, taskName: "Temizlik görevi",onTaps: (){naviRemoteTaskDetailScreen(context);}),
                SizedBox(height: deviceHeight*0.005,),
                TaskCard(heightConst: 0.13, widthConst: 0.95, taskName: "Temizlik görevi",onTaps: (){naviRemoteTaskDetailScreen(context);}),
                SizedBox(height: deviceHeight*0.005,),
                TaskCard(heightConst: 0.13, widthConst: 0.95, taskName: "Temizlik görevi",onTaps: (){naviRemoteTaskDetailScreen(context);}),
                SizedBox(height: deviceHeight*0.005,),
                TaskCard(heightConst: 0.13, widthConst: 0.95, taskName: "Temizlik görevi",onTaps: (){naviRemoteTaskDetailScreen(context);}),
                SizedBox(height: deviceHeight*0.005,),
                TaskCard(heightConst: 0.13, widthConst: 0.95, taskName: "Temizlik görevi",onTaps: (){naviRemoteTaskDetailScreen(context);}),
                SizedBox(height: deviceHeight*0.005,),
                TaskCard(heightConst: 0.13, widthConst: 0.95, taskName: "Temizlik görevi",onTaps: (){naviRemoteTaskDetailScreen(context);}),
                SizedBox(height: deviceHeight*0.005,),
                TaskCard(heightConst: 0.13, widthConst: 0.95, taskName: "Temizlik görevi",onTaps: (){naviRemoteTaskDetailScreen(context);}),
                SizedBox(height: deviceHeight*0.005,),
                TaskCard(heightConst: 0.13, widthConst: 0.95, taskName: "Temizlik görevi",onTaps: (){naviRemoteTaskDetailScreen(context);}),
                SizedBox(height: deviceHeight*0.005,),
                TaskCard(heightConst: 0.13, widthConst: 0.95, taskName: "Temizlik görevi",onTaps: (){naviRemoteTaskDetailScreen(context);}),
              ],
            )
          ],
        ),
      );
    });
  }
}


