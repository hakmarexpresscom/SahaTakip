import 'package:deneme/constants/constants.dart';
import 'package:deneme/routing/bottomNavigationBar.dart';
import 'package:deneme/widgets/cards/taskDetailCard.dart';
import 'package:flutter/material.dart';

import '../../../../constants/bottomNaviBarLists.dart';
import '../../../../constants/pagesLists.dart';
import '../../../../models/incompleteTask.dart';
import '../../../../services/inCompleteTaskServices.dart';

class VisitingReportTaskDetailScreen extends StatefulWidget {
  int task_id=0;
  VisitingReportTaskDetailScreen({super.key, required this.task_id});

  @override
  State<VisitingReportTaskDetailScreen> createState() =>
      _VisitingReportTaskDetailScreenState();
}

class _VisitingReportTaskDetailScreenState extends State<VisitingReportTaskDetailScreen> with TickerProviderStateMixin {

  late Future<IncompleteTask> futureIncompleteTask;

  int _selectedIndex = 0;

  List<BottomNavigationBarItem> naviBarList = [];
  List<Widget> pageList = [];

  late double deviceHeight;
  late double deviceWidth;

  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    futureIncompleteTask = fetchIncompleteTask2('http://172.23.21.112:7042/api/TamamlanmamisGorev/${widget.task_id}');
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
          title: const Text('Görev Detayı'),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(0, deviceHeight*0.03, 0, 0),
          child:Container(
            alignment: Alignment.center,
            child: visitingReportTaskDetailScreen(),
          ),
        ),
        bottomNavigationBar: BottomNaviBar(selectedIndex: _selectedIndex,itemList: naviBarList,pageList: pageList,)
    );
  }

  Widget visitingReportTaskDetailScreen(){
    return Expanded(
        child: FutureBuilder<IncompleteTask>(
            future: futureIncompleteTask,
            builder: (context, snapshot){
              if(snapshot.hasData){
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TaskDetailCard(heightConst: 0.7,taskDeadline: snapshot.data!.taskFinishDate,taskDescription: snapshot.data!.taskDetail!,taskName: snapshot.data!.taskTitle,widthConst: 0.9,isExternalTask: false)
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


