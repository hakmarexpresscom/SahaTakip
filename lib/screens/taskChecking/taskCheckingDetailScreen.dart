import 'package:deneme/routing/landing.dart';
import 'package:deneme/widgets/cards/incompleteTaskCheckingDetailCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../constants/bottomNaviBarLists.dart';
import '../../constants/constants.dart';
import '../../constants/pagesLists.dart';
import '../../models/completeTask.dart';
import '../../models/incompleteTask.dart';
import '../../routing/bottomNavigationBar.dart';
import '../../services/completeTaskServices.dart';
import '../../services/inCompleteTaskServices.dart';
import '../../widgets/cards/completeTaskCheckingDetailCard.dart';

class TaskCheckingDetailScreen extends StatefulWidget {
  int task_id = 0;
  int completionInfo = 0;
  TaskCheckingDetailScreen({super.key, required this.task_id,required this.completionInfo});

  @override
  State<TaskCheckingDetailScreen> createState() => _TaskCheckingDetailScreenState();
}

class _TaskCheckingDetailScreenState extends State<TaskCheckingDetailScreen> with TickerProviderStateMixin {

  late Future<IncompleteTask> futureIncompleteTask;
  late Future<CompleteTask> futureCompleteTask;

  int _selectedIndex = 3;

  List<BottomNavigationBarItem> naviBarList = [];
  List<Widget> pageList = [];

  late double deviceHeight;
  late double deviceWidth;

  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    futureIncompleteTask = fetchIncompleteTask2('${constUrl}api/TamamlanmamisGorev/${widget.task_id}');
    futureCompleteTask = fetchCompleteTask2('${constUrl}api/TamamlanmisGorev/${widget.task_id}');
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
  void dispose() {
    controller.dispose(); // AnimationController'ı temizle
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    void userCondition(String user){
      if(user=="BS"){
        naviBarList = itemListBS;
        if(isStoreVisitInProgress.value==false){
          pageList = pagesBS;
        }
        else if(isStartShopVisitWorkObs.value){
          pageList = pagesBS2;
        }
        else if(isStartExternalTaskWorkObs.value){
          pageList = pagesBS3;
        }
      }
      if(user=="PM"){
        naviBarList = itemListPM;
        if(isStoreVisitInProgress.value==false){
          pageList = pagesPM;
        }
        else if(isStartShopVisitWorkObs.value){
          pageList = pagesPM2;
        }
        else if(isStartExternalTaskWorkObs.value){
          pageList = pagesPM3;
        }
      }
      if(user=="BM" || user=="GK"){
        naviBarList = itemListBMandGK;
        pageList = pagesBMGK;
        _selectedIndex = 2;
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
          foregroundColor: Colors.white,
          backgroundColor: Colors.indigo,
          title: const Text('Görev Detayı'),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(0, deviceHeight*0.04, 0, 0),
          child:Container(
            alignment: Alignment.center,
            child: (widget.completionInfo==0)?incompleteTaskCheckingDetailScreen():completeTaskCheckingDetailScreen(),
          ),
        ),
        bottomNavigationBar: BottomNaviBar(selectedIndex: _selectedIndex,itemList: naviBarList,pageList: pageList,)
    );
  }

  Widget incompleteTaskCheckingDetailScreen(){
    return Column(
        children: [FutureBuilder<IncompleteTask>(
            future: futureIncompleteTask,
            builder: (context, snapshot){
              if(snapshot.hasData){
                return IncompleteTaskCheckingDetailCard(
                        heightConst: 0.7,
                        widthConst: 0.9,
                        taskName: snapshot.data!.taskTitle,
                        taskDescription: snapshot.data!.taskDetail!,
                        taskDeadline: snapshot.data!.taskFinishDate,
                        taskType: snapshot.data!.taskType,
                        onTapsShowPhoto: (){naviTaskDownloadedPhotoScreen(context, snapshot.data!.photo_id);},
                        id: snapshot.data!.task_id,
                        assignmentDate: snapshot.data!.taskAssigmentDate,
                        shop_code: snapshot.data!.shopCode,
                        photo_id: snapshot.data!.photo_id,
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
        )]
    );
  }

  Widget completeTaskCheckingDetailScreen(){
    return Column(
        children: [FutureBuilder<IncompleteTask>(
            future: futureIncompleteTask,
            builder: (context, snapshot){
              if(snapshot.hasData){
                return Column(
                  children: [FutureBuilder<CompleteTask>(
                      future: futureCompleteTask,
                      builder: (context,snapshot2){
                        if(snapshot2.hasData){
                          return CompleteTaskCheckingDetailCard(
                                taskName: snapshot.data!.taskTitle,
                                taskDescription: snapshot.data!.taskDetail!,
                                taskDeadline: snapshot.data!.taskFinishDate,
                                taskType: snapshot.data!.taskType,
                                onTapsShowPhoto: (){naviAnswerDownloadedPhotoScreen(context, snapshot.data!.task_id);},
                                id: snapshot.data!.task_id,
                                assignmentDate: snapshot.data!.taskAssigmentDate,
                                shop_code: snapshot.data!.shopCode,
                                photo_id: snapshot.data!.photo_id,
                                completeDate: snapshot2.data!.taskCompleteDate,
                                answerNote: snapshot2.data!.answerNote,
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
                      },
                    )]
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
        )]
    );
  }
}
