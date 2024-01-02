import 'package:deneme/constants/constants.dart';
import 'package:deneme/routing/bottomNavigationBar.dart';
import 'package:flutter/material.dart';
import '../../../../constants/bottomNaviBarLists.dart';
import '../../../../constants/pagesLists.dart';
import '../../../../main.dart';
import '../../../../models/incompleteTask.dart';
import '../../../../routing/landing.dart';
import '../../../../services/inCompleteTaskServices.dart';
import '../../../../widgets/cards/taskCard.dart';


class InPlaceTaskMainScreen extends StatefulWidget {
  int shop_code = 0;
  InPlaceTaskMainScreen({super.key, required this.shop_code});

  @override
  State<InPlaceTaskMainScreen> createState() =>
      _InPlaceTaskMainScreenState();
}

class _InPlaceTaskMainScreenState extends State<InPlaceTaskMainScreen> with TickerProviderStateMixin {

  late Future<List<IncompleteTask>> futureIncompleteTask;

  late double deviceHeight;
  late double deviceWidth;

  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    futureIncompleteTask = fetchIncompleteTask('http://172.23.21.112:7042/api/TamamlanmamisGorev/filterTask1?magaza_kodu=${widget.shop_code}&tamamlandi_bilgisi=0&gorev_turu=Yerinde&grup_no=${groupNo}');
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
          title: const Text('Yerinde Görevler'),
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
            inPlaceTaskMainScreenUI()
          ],
        ),
    );
  }

  Widget inPlaceTaskMainScreenUI(){
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
                        TaskCard(heightConst: 0.15, widthConst: 0.95, taskName: snapshot.data![index].taskTitle,onTaps: (){naviInPlaceTaskDetailScreen(context,snapshot.data![index].task_id);}),
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