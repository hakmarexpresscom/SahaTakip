import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../constants/bottomNaviBarLists.dart';
import '../../constants/constants.dart';
import '../../constants/pagesLists.dart';
import '../../models/incompleteTask.dart';
import '../../routing/bottomNavigationBar.dart';
import '../../routing/landing.dart';
import '../../services/inCompleteTaskServices.dart';
import '../../widgets/cards/taskCheckingCard.dart';

class TaskCheckingMainScreen extends StatefulWidget {
  const TaskCheckingMainScreen({super.key});

  @override
  State<TaskCheckingMainScreen> createState() => _TaskCheckingMainScreenState();
}

class _TaskCheckingMainScreenState extends State<TaskCheckingMainScreen> with TickerProviderStateMixin  {

  late Future<List<IncompleteTask>> futureIncompleteTask;
  late Future<List<IncompleteTask>> futureIncompleteTask2;

  int _selectedIndex = 3;

  List<BottomNavigationBarItem> naviBarList = [];
  List<Widget> pageList = [];

  late double deviceHeight;
  late double deviceWidth;

  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    futureIncompleteTask = fetchIncompleteTask('http://172.23.21.112:7042/api/TamamlanmamisGorev/filterTask3?$urlTaskShops&tamamlandi_bilgisi=0');
    futureIncompleteTask2 = fetchIncompleteTask('http://172.23.21.112:7042/api/TamamlanmamisGorev/filterTask3?$urlTaskShops&tamamlandi_bilgisi=1');
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
        _selectedIndex = 2;
      }
      if(user=="NK"){
        naviBarList = itemListNK;
        pageList = pagesNK;
      }
    }

    userCondition(userType);

    return DefaultTabController(
        initialIndex: 0,
        length: 2,
        child:Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              backgroundColor: Colors.indigo,
              title: const Text('Görev Kontrol'),
              bottom: TabBar(
                tabs: [
                  Tab(text: "Tamamlanmış Görevler"),
                  Tab(text: "Tamamlanmamış Görevler")
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                completeTasksScreenUI(),
                incompleteTasksScreenUI(),
              ],
            ),
            bottomNavigationBar: BottomNaviBar(selectedIndex: _selectedIndex,itemList: naviBarList,pageList: pageList,)
        ));
  }

  Widget incompleteTasksScreenUI(){
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
                    if(snapshot.data![index].report_id==null){
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: deviceHeight*0.01,),
                          TaskCheckingCard(heightConst: 0.15, widthConst: 0.95, taskName: snapshot.data![index].taskTitle,onTaps: (){naviTaskCheckingDetailScreen(context, snapshot.data![index].task_id, snapshot.data![index].completionInfo);}),
                        ],
                      );
                    }
                    else{
                      return Container();
                    }
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

  Widget completeTasksScreenUI(){
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
                    if(snapshot.data![index].report_id==null){
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: deviceHeight*0.01,),
                          TaskCheckingCard(heightConst: 0.15, widthConst: 0.95, taskName: snapshot.data![index].taskTitle,onTaps: (){}),
                        ],
                      );
                    }
                    else{
                      return Container();
                    }
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
