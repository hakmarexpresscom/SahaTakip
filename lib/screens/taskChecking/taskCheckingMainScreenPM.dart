import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../constants/bottomNaviBarLists.dart';
import '../../constants/constants.dart';
import '../../constants/pagesLists.dart';
import '../../main.dart';
import '../../models/incompleteTask.dart';
import '../../routing/bottomNavigationBar.dart';
import '../../routing/landing.dart';
import '../../services/inCompleteTaskServices.dart';
import '../../widgets/cards/taskCheckingCard.dart';
import '../../widgets/text_widget.dart';

class TaskCheckingMainScreenPM extends StatefulWidget {
  const TaskCheckingMainScreenPM({super.key});

  @override
  State<TaskCheckingMainScreenPM> createState() => _TaskCheckingMainScreenPMState();
}

class _TaskCheckingMainScreenPMState extends State<TaskCheckingMainScreenPM> with TickerProviderStateMixin  {

  late Future<List<IncompleteTask>> futureIncompleteTask;
  late Future<List<IncompleteTask>> futureIncompleteTask2;

  int taskType = 0;
  int taskType2 = 0;

  int shop = 0;
  int shop2 = 0;

  int _selectedIndex = 3;

  List<BottomNavigationBarItem> naviBarList = [];
  List<Widget> pageList = [];

  late double deviceHeight;
  late double deviceWidth;

  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    futureIncompleteTask = fetchIncompleteTask('${constUrl}api/TamamlanmamisGorev/filterTask1?$urlTaskShops&tamamlandi_bilgisi=1&gorev_turu=${taskListCompleteTask[taskType].split(" ")[0]}&grup_no=${groupNo}');
    futureIncompleteTask2 = fetchIncompleteTask('${constUrl}api/TamamlanmamisGorev/filterTask1?$urlTaskShops&tamamlandi_bilgisi=0&gorev_turu=${taskListCompleteTask[taskType2].split(" ")[0]}&grup_no=${groupNo}');

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

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    void userCondition(String user){
      if(user=="BS"){
        naviBarList = itemListBS;
        if(isStartShopVisitWorkObs.value==false&&isStartExternalTaskWorkObs.value==false){
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
        if(isStartShopVisitWorkObs.value==false&&isStartExternalTaskWorkObs.value==false){
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

    return DefaultTabController(
        initialIndex: 0,
        length: 2,
        child:Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              foregroundColor: Colors.white,
              backgroundColor: Colors.indigo,
              title: const Text('Görev Kontrol'),
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
                  children: [
                    SizedBox(height: deviceHeight*0.03,),
                    taskTypeInfo(),
                    SizedBox(height: deviceHeight*0.02,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Card(
                          //color: Colors.lightGreen.withOpacity(0.6),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: BorderSide(
                                  color: Colors.indigo,
                                  width: 1.5
                              )
                          ),
                          child: CupertinoButton(
                            padding: EdgeInsets.fromLTRB(3, 0, 3, 0),
                            // Display a CupertinoPicker with list of fruits.
                            onPressed: () => _showDialog(
                              CupertinoPicker(
                                magnification: 1.22,
                                squeeze: 1.2,
                                useMagnifier: true,
                                itemExtent: kItemExtent,
                                // This sets the initial item.
                                scrollController: FixedExtentScrollController(
                                  initialItem: taskType,
                                ),
                                // This is called when selected item is changed.
                                onSelectedItemChanged: (int selectedItem) {
                                  setState(() {
                                    taskType = selectedItem;
                                    if(shop==0){
                                      futureIncompleteTask = fetchIncompleteTask('${constUrl}api/TamamlanmamisGorev/filterTask1?$urlTaskShops&tamamlandi_bilgisi=1&gorev_turu=${taskTypeListCompleteTask[taskType].split(" ")[0]}&grup_no=${groupNo}');
                                    }
                                    else{
                                      futureIncompleteTask = fetchIncompleteTask('${constUrl}api/TamamlanmamisGorev/filterTask4?magaza_kodu=${createShopFilterList()[shop]}&tamamlandi_bilgisi=1&gorev_turu=${taskTypeListCompleteTask[taskType].split(" ")[0]}&grup_no=${groupNo}');
                                    }
                                  });
                                },
                                children:
                                List<Widget>.generate(taskListCompleteTask.length, (int index) {
                                  return Center(child: Text(taskListCompleteTask[index]));
                                }),
                              ),
                            ),
                            // This displays the selected fruit name.
                            child: Text(
                              taskListCompleteTask[taskType],
                              style: const TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                          )
                        ),
                        SizedBox(width: deviceWidth*0.04,),
                        Card(
                          //color: Colors.lightGreen.withOpacity(0.6),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: BorderSide(
                                  color: Colors.indigo,
                                  width: 1.5
                              )
                          ),
                          child: CupertinoButton(
                            padding: EdgeInsets.fromLTRB(3, 0, 3, 0),
                            // Display a CupertinoPicker with list of fruits.
                            onPressed: () => _showDialog(
                              CupertinoPicker(
                                magnification: 1.22,
                                squeeze: 1.2,
                                useMagnifier: true,
                                itemExtent: kItemExtent,
                                // This sets the initial item.
                                scrollController: FixedExtentScrollController(
                                  initialItem: shop,
                                ),
                                // This is called when selected item is changed.
                                onSelectedItemChanged: (int selectedItem) {
                                  setState(() {
                                    shop = selectedItem;
                                    if(shop==0){
                                      futureIncompleteTask = fetchIncompleteTask('${constUrl}api/TamamlanmamisGorev/filterTask1?$urlTaskShops&tamamlandi_bilgisi=1&gorev_turu=${taskTypeListCompleteTask[taskType].split(" ")[0]}&grup_no=${groupNo}');
                                    }
                                    else{
                                      futureIncompleteTask = fetchIncompleteTask('${constUrl}api/TamamlanmamisGorev/filterTask4?magaza_kodu=${createShopFilterList()[shop]}&tamamlandi_bilgisi=1&gorev_turu=${taskTypeListCompleteTask[taskType].split(" ")[0]}&grup_no=${groupNo}');
                                    }
                                  });
                                },
                                children:
                                List<Widget>.generate(createShopFilterList().length, (int index) {
                                  return Center(child: Text(createShopFilterList()[index]));
                                }),
                              ),
                            ),
                            // This displays the selected fruit name.
                            child: Text(
                              (shop==0)?createShopFilterList()[shop]:"Mağaza Kodu: "+createShopFilterList()[shop],
                              style: const TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                          )
                        ),
                      ],
                    ),
                    SizedBox(height: deviceHeight*0.02,),
                    completeTasksScreenUI()
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: deviceHeight*0.03,),
                    taskTypeInfo(),
                    SizedBox(height: deviceHeight*0.02,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Card(
                          //color: Colors.lightGreen.withOpacity(0.6),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: BorderSide(
                                  color: Colors.indigo,
                                  width: 1.5
                              )
                          ),
                          child: CupertinoButton(
                            padding: EdgeInsets.fromLTRB(3, 0, 3, 0),
                            // Display a CupertinoPicker with list of fruits.
                            onPressed: () => _showDialog(
                              CupertinoPicker(
                                magnification: 1.22,
                                squeeze: 1.2,
                                useMagnifier: true,
                                itemExtent: kItemExtent,
                                // This sets the initial item.
                                scrollController: FixedExtentScrollController(
                                  initialItem: taskType2,
                                ),
                                // This is called when selected item is changed.
                                onSelectedItemChanged: (int selectedItem) {
                                  setState(() {
                                    taskType2 = selectedItem;
                                    if(shop2==0){
                                      futureIncompleteTask2 = fetchIncompleteTask('${constUrl}api/TamamlanmamisGorev/filterTask1?$urlTaskShops&tamamlandi_bilgisi=0&gorev_turu=${taskTypeListIncompleteTask[taskType2].split(" ")[0]}&grup_no=${groupNo}');
                                    }
                                    else{
                                      futureIncompleteTask2 = fetchIncompleteTask('${constUrl}api/TamamlanmamisGorev/filterTask4?magaza_kodu=${createShopFilterList()[shop2]}&tamamlandi_bilgisi=0&gorev_turu=${taskTypeListIncompleteTask[taskType2].split(" ")[0]}&grup_no=${groupNo}');
                                    }
                                  });
                                },
                                children:
                                List<Widget>.generate(taskListIncompleteTask.length, (int index) {
                                  return Center(child: Text(taskListIncompleteTask[index]));
                                }),
                              ),
                            ),
                            // This displays the selected fruit name.
                            child: Text(
                              taskListIncompleteTask[taskType2],
                              style: const TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                          )
                        ),
                        SizedBox(width: deviceWidth*0.04,),
                        Card(
                          //color: Colors.lightGreen.withOpacity(0.6),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: BorderSide(
                                  color: Colors.indigo,
                                  width: 1.5
                              )
                          ),
                          child: CupertinoButton(
                            padding: EdgeInsets.fromLTRB(3, 0, 3, 0),
                            // Display a CupertinoPicker with list of fruits.
                            onPressed: () => _showDialog(
                              CupertinoPicker(
                                magnification: 1.22,
                                squeeze: 1.2,
                                useMagnifier: true,
                                itemExtent: kItemExtent,
                                // This sets the initial item.
                                scrollController: FixedExtentScrollController(
                                  initialItem: shop2,
                                ),
                                // This is called when selected item is changed.
                                onSelectedItemChanged: (int selectedItem) {
                                  setState(() {
                                    shop2 = selectedItem;
                                    if(shop2==0){
                                      futureIncompleteTask2 = fetchIncompleteTask('${constUrl}api/TamamlanmamisGorev/filterTask1?$urlTaskShops&tamamlandi_bilgisi=0&gorev_turu=${taskTypeListIncompleteTask[taskType2].split(" ")[0]}&grup_no=${groupNo}');
                                    }
                                    else{
                                      futureIncompleteTask2 = fetchIncompleteTask('${constUrl}api/TamamlanmamisGorev/filterTask4?magaza_kodu=${createShopFilterList()[shop2]}&tamamlandi_bilgisi=0&gorev_turu=${taskTypeListIncompleteTask[taskType2].split(" ")[0]}&grup_no=${groupNo}');
                                    }
                                  });
                                },
                                children:
                                List<Widget>.generate(createShopFilterList().length, (int index) {
                                  return Center(child: Text(createShopFilterList()[index]));
                                }),
                              ),
                            ),
                            // This displays the selected fruit name.
                            child: Text(
                              (shop2==0)?createShopFilterList()[shop2]:"Mağaza Kodu: "+createShopFilterList()[shop2],
                              style: const TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                          )
                        ),
                      ],
                    ),
                    SizedBox(height: deviceHeight*0.02,),
                    incompleteTasksScreenUI()
                  ],
                ),
              ],
            ),
            bottomNavigationBar: BottomNaviBar(selectedIndex: _selectedIndex,itemList: naviBarList,pageList: pageList,)
        ));
  }

  Widget completeTasksScreenUI(){
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
                        TaskCheckingCard(heightConst: 0.2, widthConst: 0.95, taskName: snapshot.data![index].taskTitle,assignmentDate: snapshot.data![index].taskAssigmentDate,taskType: snapshot.data![index].taskType,shopCode: snapshot.data![index].shopCode,onTaps: (){naviTaskCheckingDetailScreen(context, snapshot.data![index].task_id, snapshot.data![index].completionInfo);}),
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

  Widget incompleteTasksScreenUI(){
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
                        TaskCheckingCard(heightConst: 0.2, widthConst: 0.95, taskName: snapshot.data![index].taskTitle,assignmentDate: snapshot.data![index].taskAssigmentDate,taskType: snapshot.data![index].taskType,shopCode: snapshot.data![index].shopCode,onTaps: (){naviTaskCheckingDetailScreen(context, snapshot.data![index].task_id, snapshot.data![index].completionInfo);}),
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

  Widget taskTypeInfo(){
    return TextWidget(text: "Görevleri görüntülerken görev türünü ve mağaza\nkodunu aşağıdaki butonlara basarak filtreleyebilirsiniz.", size: 16, fontWeight: FontWeight.w400, color: Colors.black);
  }

}
