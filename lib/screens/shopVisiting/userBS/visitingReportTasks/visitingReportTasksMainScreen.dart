import 'package:deneme/constants/constants.dart';
import 'package:deneme/styles/styleConst.dart';
import 'package:flutter/material.dart';
import '../../../../main.dart';
import '../../../../models/incompleteTask.dart';
import '../../../../routing/landing.dart';
import '../../../../services/inCompleteTaskServices.dart';
import '../../../../widgets/cards/taskCard.dart';


class VisitingReportTaskMainScreen extends StatefulWidget {
  int shop_code = 0;
  VisitingReportTaskMainScreen({super.key, required this.shop_code});

  @override
  State<VisitingReportTaskMainScreen> createState() =>
      _VisitingReportTaskMainScreenState();
}

class _VisitingReportTaskMainScreenState extends State<VisitingReportTaskMainScreen> with TickerProviderStateMixin {

  late Future<List<IncompleteTask>> futureIncompleteTask;

  late double deviceHeight;
  late double deviceWidth;

  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    futureIncompleteTask = fetchIncompleteTask('${constUrl}api/TamamlanmamisGorev/filterTask1?magaza_kodu=${widget.shop_code}&tamamlandi_bilgisi=0&gorev_turu=Rapor&grup_no=${groupNo}');
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
          foregroundColor: appbarForeground,
          backgroundColor: appbarBackground,
          title: const Text('Ziyaret Raporu Görevleri'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              naviShopVisitingProcessesScreen(context,box.get("currentShopID"),box.get("currentShopName"));
            },
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: deviceHeight*0.02,),
            visitingReportTaskMainScreenUI()
          ],
        ),
    );
  }

  Widget visitingReportTaskMainScreenUI(){
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
                        TaskCard(taskName: snapshot.data![index].taskTitle, taskAssignmentDate: snapshot.data![index].taskAssigmentDate,  taskType: snapshot.data![index].taskType , shop_code:snapshot.data![index].shopCode, onTaps: (){naviVisitingReportTaskDetailScreen(context,snapshot.data![index].task_id);}),
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


