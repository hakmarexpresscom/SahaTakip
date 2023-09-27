import 'package:deneme/constants/constants.dart';
import 'package:deneme/routing/bottomNavigationBar.dart';
import 'package:deneme/widgets/cards/taskDetailCard.dart';
import 'package:flutter/material.dart';

class RemoteTaskDetailScreen extends StatefulWidget {
  const RemoteTaskDetailScreen({super.key});

  @override
  State<RemoteTaskDetailScreen> createState() =>
      _RemoteTaskDetailScreenState();
}

class _RemoteTaskDetailScreenState extends State<RemoteTaskDetailScreen> {

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
          title: const Text('Görev Detayı'),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(0, deviceWidth*0.04, 0, 0),
          child:Container(
            alignment: Alignment.center,
            child: remoteTaskDetailScreenUI(),
          ),
        ),
        bottomNavigationBar: BottomNaviBar(selectedIndex: _selectedIndex,itemList: itemListBS,pageList: pages,)
    );
  }

  Widget remoteTaskDetailScreenUI(){
    return Builder(builder: (BuildContext context){
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: deviceHeight*0.03,),
            TaskDetailCard(heightConst: 0.7,taskDeadline: "24.11.1998",taskDescription: "Görev tanımı",taskName: "Görev Adı",widthConst: 0.9)
          ],
        ),
      );
    });
  }
}


