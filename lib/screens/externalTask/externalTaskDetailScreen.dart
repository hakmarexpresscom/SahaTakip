import 'package:deneme/constants/constants.dart';
import 'package:deneme/models/externalWork.dart';
import 'package:deneme/routing/bottomNavigationBar.dart';
import 'package:deneme/routing/landing.dart';
import 'package:deneme/widgets/cards/taskDetailCard.dart';
import 'package:flutter/material.dart';

import '../../constants/bottomNaviBarLists.dart';
import '../../constants/pagesLists.dart';
import '../../services/externalWorkServices.dart';
import '../../widgets/button_widget.dart';

class ExternalTaskDetailScreen extends StatefulWidget {

  int work_id = 0;
  ExternalTaskDetailScreen({super.key, required this.work_id});

  @override
  State<ExternalTaskDetailScreen> createState() =>
      _ExternalTaskDetailScreenState();
}

class _ExternalTaskDetailScreenState extends State<ExternalTaskDetailScreen> with TickerProviderStateMixin {

  late Future<ExternalWork> futureExternalWork;

  int _selectedIndex = 0;

  List<BottomNavigationBarItem> naviBarList = [];
  List<Widget> pageList = [];

  late double deviceHeight;
  late double deviceWidth;

  DateTime now = DateTime.now();

  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    futureExternalWork = fetchExternalWork2('http://172.23.21.112:7042/api/HariciIs/${widget.work_id}');
    controller = AnimationController(
      /// [AnimationController]s can be created with `vsync: this` because of
      /// [TickerProviderStateMixin].
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
    });
    controller.repeat(reverse: true);
  }

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
          title: const Text('Harici İş Detayı'),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(0, deviceHeight*0.04, 0, 0),
          child:Container(
            alignment: Alignment.center,
            child: externalTaskDetailScreenUI(),
          ),
        ),
        bottomNavigationBar: BottomNaviBar(selectedIndex: _selectedIndex,itemList: naviBarList,pageList: pageList,)
    );
  }

  Widget externalTaskDetailScreenUI(){
    return Expanded(
        child: FutureBuilder<ExternalWork>(
            future: futureExternalWork,
            builder: (context, snapshot){
              if(snapshot.hasData){
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TaskDetailCard(
                      heightConst: 0.7,
                      taskDeadline: snapshot.data!.workFinishHour,
                      taskDescription: snapshot.data!.workDetail!,
                      taskName: snapshot.data!.workTitle,
                      widthConst: 0.9,
                      taskType: "Harici",
                      isCompleted: (snapshot.data!.completionInfo==1)?true:false,
                      onTaps: (){naviExternalTasksListScreen(context);},
                      onTapsShowPhoto: (){},
                      id: snapshot.data!.external_work_id,
                      user_id: userID,
                      assignmentDate: now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString(),
                      assignmentHour: now.hour.toString()+"."+now.minute.toString(),
                      shop_code: 0,
                      report_id: 0,
                      photo_id: 0,
                      addPhotoButton: ButtonWidget(text: "Fotoğraf Ekle", heightConst: 0.06, widthConst: 0.8, size: 18, radius: 20, fontWeight: FontWeight.w600, onTaps: (){}, borderWidht: 3, backgroundColor: Colors.orangeAccent, borderColor: Colors.orangeAccent, textColor: Colors.black),
                      image: null,
                    )
                  ],
                );
              }
              if(snapshot.connectionState == ConnectionState.waiting){
                return Column(
                    children:[
                      SizedBox(height: deviceHeight*0.06,),
                      CircularProgressIndicator(
                        value: controller.value,
                        semanticsLabel: 'Circular progress indicator',
                      ),
                    ]
                );
              }
              else{
                return Text("Veri yok");
              }
            }
        )
    );
  }
}


