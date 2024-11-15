import 'package:flutter/material.dart';
import '../../../../../constants/constants.dart';
import '../../../../../main.dart';
import '../../../../../models/incompleteTask.dart';
import '../../../../../routing/landing.dart';
import '../../../../../services/inCompleteTaskServices.dart';
import '../../../../../styles/styleConst.dart';
import '../../../../../widgets/cards/taskCheckingCard.dart';

class PastReportTasksScreenSatisOperasyon extends StatefulWidget {
  int report_id = 0;
  PastReportTasksScreenSatisOperasyon({super.key, required this.report_id});

  @override
  State<PastReportTasksScreenSatisOperasyon> createState() =>
      _PastReportTasksScreenSatisOperasyonState();
}

class _PastReportTasksScreenSatisOperasyonState extends State<PastReportTasksScreenSatisOperasyon> with TickerProviderStateMixin {

  late Future<List<IncompleteTask>> futureIncompleteTask;
  late Future<List<IncompleteTask>> futureIncompleteTask2;

  late double deviceHeight;
  late double deviceWidth;

  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    futureIncompleteTask = fetchIncompleteTask('${constUrl}api/TamamlanmamisGorev/filterTask2?tamamlandi_bilgisi=0&rapor_id=${widget.report_id}');
    futureIncompleteTask2 = fetchIncompleteTask('${constUrl}api/TamamlanmamisGorev/filterTask2?tamamlandi_bilgisi=1&rapor_id=${widget.report_id}');
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

    return DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            foregroundColor: appbarForeground,
            backgroundColor: appbarBackground,
            title: const Text('Ziyaret Tespiti Görevleri'),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                naviVisitingReportMainScreen(context,box.get("currentShopID"),box.get("groupNo"));
              },
            ),
            bottom: TabBar(
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white30,
              tabs: [
                Tab(text: "Tamamlanmış Görevler"),
                Tab(text: "Tamamlanmamış Görevler")
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [completePastReportTasksScreenUI()],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [incompletePastResportTasksScreenUI()],
              ),
            ],
          ),
      )
    );
  }

  Widget incompletePastResportTasksScreenUI(){
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
                        SizedBox(height: deviceHeight*0.01,),
                        TaskCheckingCard(
                            taskName: snapshot.data![index].taskTitle,
                            assignmentDate: snapshot.data![index].taskAssigmentDate,
                            taskType: snapshot.data![index].taskType,
                            shopCode: snapshot.data![index].shopCode,
                            shopName: snapshot.data![index].shopName,
                            bsName: snapshot.data![index].bsName,
                            onTaps: (){naviTaskCheckingDetailScreen(context, snapshot.data![index].task_id, snapshot.data![index].completionInfo);}
                        ),
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

  Widget completePastReportTasksScreenUI(){
    return Expanded(
        child: FutureBuilder<List<IncompleteTask>>(
            future: futureIncompleteTask2,
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
                        SizedBox(height: deviceHeight*0.01,),
                        TaskCheckingCard(
                            taskName: snapshot.data![index].taskTitle,
                            assignmentDate: snapshot.data![index].taskAssigmentDate,
                            taskType: snapshot.data![index].taskType,
                            shopCode: snapshot.data![index].shopCode,
                            shopName: snapshot.data![index].shopName,
                            bsName: snapshot.data![index].bsName,
                            onTaps: (){naviTaskCheckingDetailScreen(context, snapshot.data![index].task_id, snapshot.data![index].completionInfo);}
                        ),
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



