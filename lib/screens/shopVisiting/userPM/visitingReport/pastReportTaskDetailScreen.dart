import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../models/completeTask.dart';
import '../../../../models/incompleteTask.dart';
import '../../../../routing/landing.dart';
import '../../../../services/completeTaskServices.dart';
import '../../../../services/inCompleteTaskServices.dart';
import '../../../../widgets/cards/pastReportsTaskDetailCard.dart';

class PastReportTaskDetailScreen extends StatefulWidget {

  int task_id = 0;
  int completionInfo = 0;
  PastReportTaskDetailScreen({super.key, required this.task_id,required this.completionInfo});

  @override
  State<PastReportTaskDetailScreen> createState() => _PastReportTaskDetailScreenState();
}

class _PastReportTaskDetailScreenState extends State<PastReportTaskDetailScreen> with TickerProviderStateMixin  {

  late Future<IncompleteTask> futureIncompleteTask;
  late Future<CompleteTask> futureCompleteTask;

  late double deviceHeight;
  late double deviceWidth;

  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    futureIncompleteTask = fetchIncompleteTask2('http://172.23.21.112:7042/api/TamamlanmamisGorev/${widget.task_id}');
    futureCompleteTask = fetchCompleteTask2('http://172.23.21.112:7042/api/TamamlanmisGorev/${widget.task_id}');
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
            child: (widget.completionInfo==0)?incompletePastReportTaskDetailScreen():completePastReportTaskDetailScreen(),
          ),
        ),
    );
  }

  Widget incompletePastReportTaskDetailScreen(){
    return Column(
        children: [FutureBuilder<IncompleteTask>(
            future: futureIncompleteTask,
            builder: (context, snapshot){
              if(snapshot.hasData){
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    PastReportTaskDetailCard(
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
                      completeDate: "",
                      completionInfo: snapshot.data!.completionInfo,
                      answerNote: "",
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
        )]
    );
  }

  Widget completePastReportTaskDetailScreen(){
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
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              PastReportTaskDetailCard(
                                heightConst: 0.7,
                                widthConst: 0.9,
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
                                completionInfo: snapshot.data!.completionInfo,
                                answerNote: snapshot2.data!.answerNote,
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
