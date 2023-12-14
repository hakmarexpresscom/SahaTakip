import 'package:deneme/constants/constants.dart';
import 'package:deneme/routing/bottomNavigationBar.dart';
import 'package:deneme/widgets/cards/pastReportsDetailCard.dart';
import 'package:flutter/material.dart';
import '../../../../constants/bottomNaviBarLists.dart';
import '../../../../constants/pagesLists.dart';
import '../../../../models/incompleteTask.dart';
import '../../../../routing/landing.dart';
import '../../../../services/inCompleteTaskServices.dart';
import '../../../../widgets/cards/taskCard.dart';
import '../../../../widgets/cards/taskCheckingCard.dart';


class PastReportTasksScreen extends StatefulWidget {
  int report_id = 0;
  PastReportTasksScreen({super.key, required this.report_id});

  @override
  State<PastReportTasksScreen> createState() =>
      _PastReportTasksScreenState();
}

class _PastReportTasksScreenState extends State<PastReportTasksScreen> with TickerProviderStateMixin {

  late Future<List<IncompleteTask>> futureIncompleteTask;

  late double deviceHeight;
  late double deviceWidth;

  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    futureIncompleteTask = fetchIncompleteTask('http://172.23.21.112:7042/api/TamamlanmamisGorev/byReportId?rapor_id=${widget.report_id}');
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

    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: Colors.indigo,
          title: const Text('Rapor Görevleri'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: deviceHeight*0.02,),
            pastReportDetailScreenUI()
          ],
        ),
    );
  }

  Widget pastReportDetailScreenUI(){
    return Expanded(
        child: FutureBuilder<List<IncompleteTask>>(
            future: futureIncompleteTask,
            builder: (context, snapshot){
              if(snapshot.hasData){
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index){
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TaskCheckingCard(heightConst: 0.25, widthConst: 0.95, taskName: snapshot.data![index].taskTitle,assignmentDate: snapshot.data![index].taskAssigmentDate,taskType: snapshot.data![index].taskType,shopCode: snapshot.data![index].shopCode,onTaps: (){naviPastReportTaskDetailScreen(context,snapshot.data![index].task_id);}),
                        SizedBox(height: deviceHeight*0.005,),
                      ],
                    );
                  },
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



