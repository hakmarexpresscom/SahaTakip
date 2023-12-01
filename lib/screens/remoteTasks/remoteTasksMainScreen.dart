import 'package:deneme/constants/constants.dart';
import 'package:deneme/models/incompleteTask.dart';
import 'package:deneme/routing/bottomNavigationBar.dart';
import 'package:deneme/screens/remoteTasks/remoteTaskDetailScreen.dart';
import 'package:deneme/services/inCompleteTaskServices.dart';
import 'package:flutter/material.dart';
import '../../constants/bottomNaviBarLists.dart';
import '../../constants/pagesLists.dart';
import '../../routing/landing.dart';
import '../../utils/generalFunctions.dart';
import '../../widgets/cards/taskCard.dart';

class RemoteTaskMainScreen extends StatefulWidget {
  const RemoteTaskMainScreen({super.key});

  @override
  State<RemoteTaskMainScreen> createState() =>
      _RemoteTaskMainScreenState();
}

class _RemoteTaskMainScreenState extends State<RemoteTaskMainScreen> with TickerProviderStateMixin {

  late Future<List<IncompleteTask>> futureIncompleteTask;

  int _selectedIndex = 3;

  List<BottomNavigationBarItem> naviBarList = [];
  List<Widget> pageList = [];

  late double deviceHeight;
  late double deviceWidth;

  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    futureIncompleteTask = fetchIncompleteTask('http://172.23.21.112:7042/api/TamamlanmamisGorev/filterTask1?$urlTaskShops&tamamlandi_bilgisi=0&gorev_turu=Uzaktan');
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
          automaticallyImplyLeading: false,
          foregroundColor: Colors.white,
          backgroundColor: Colors.indigo,
          title: const Text('Uzaktan Görevler'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: deviceHeight*0.02,),
              remoteTaskMainScreenUI()
            ],
          ),
        bottomNavigationBar: BottomNaviBar(selectedIndex: _selectedIndex,itemList: naviBarList,pageList: pageList,)
    );
  }

  Widget remoteTaskMainScreenUI(){
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
                      TaskCard(heightConst: 0.15, widthConst: 0.95, taskName: snapshot.data![index].taskTitle,onTaps: (){naviRemoteTaskDetailScreen(context,snapshot.data![index].task_id);}),
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