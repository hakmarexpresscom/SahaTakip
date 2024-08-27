import 'package:deneme/styles/styleConst.dart';
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

  int bs = 0;
  int bs2 = 0;

  int _selectedIndex = 3;

  List<BottomNavigationBarItem> naviBarList = [];
  List<Widget> pageList = [];

  late double deviceHeight;
  late double deviceWidth;

  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    futureIncompleteTask = fetchIncompleteTask('${constUrl}api/TamamlanmamisGorev/filterTask1?$urlTaskShops&tamamlandi_bilgisi=1&gorev_turu=${taskTypeListCompleteTask[taskType]}&grup_no=${groupNo}');
    futureIncompleteTask2 = fetchIncompleteTask('${constUrl}api/TamamlanmamisGorev/filterTask1?$urlTaskShops&tamamlandi_bilgisi=0&gorev_turu=${taskTypeListIncompleteTask[taskType2]}&grup_no=${groupNo}');

    print(urlTaskShops);

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
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
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
        if(isStartShiftObs.value==false&&isRegionCenterVisitInProgress.value==false){
          pageList = pagesBS;
        }
        else if(isStartShiftObs.value&&isRegionCenterVisitInProgress.value==false){
          pageList = pagesBS2;
        }
        else if(isRegionCenterVisitInProgress.value){
          pageList = pagesBS3;
        }
      }
      if(user=="PM"){
        naviBarList = itemListPM;
        if(isStartShiftObs.value==false&&isRegionCenterVisitInProgress.value==false){
          pageList = pagesPM;
        }
        else if(isStartShiftObs.value&&isRegionCenterVisitInProgress.value==false){
          pageList = pagesPM2;
        }
        else if(isRegionCenterVisitInProgress.value){
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
              foregroundColor: appbarForeground,
              backgroundColor: appbarBackground,
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
            body: PopScope(
              canPop: false,
              onPopInvoked: (bool didPop) {},
              child:TabBarView(
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
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  side: BorderSide(
                                      color: Colors.indigo,
                                      width: 1.5
                                  )
                              ),
                              child: CupertinoButton(
                                padding: EdgeInsets.fromLTRB(3, 0, 3, 0),
                                onPressed: () => _showDialog(
                                  CupertinoPicker(
                                    magnification: 1.22,
                                    squeeze: 1.2,
                                    useMagnifier: true,
                                    itemExtent: kItemExtent,
                                    scrollController: FixedExtentScrollController(
                                      initialItem: shop,
                                    ),
                                    onSelectedItemChanged: (int selectedItem) {
                                      setState(() {
                                        shop = selectedItem;
                                        if(shop==0&&bs==0){
                                          futureIncompleteTask = fetchIncompleteTask('${constUrl}api/TamamlanmamisGorev/filterTask1?$urlTaskShops&tamamlandi_bilgisi=1&gorev_turu=${taskTypeListCompleteTask[taskType]}&grup_no=${groupNo}');
                                        }
                                        if(shop==0&&bs!=0){
                                          futureIncompleteTask = fetchIncompleteTask('${constUrl}api/TamamlanmamisGorev/filterTask1?${createUrlTaskShopsWithBS(bsIDs[bs])}&tamamlandi_bilgisi=1&gorev_turu=${taskTypeListCompleteTask[taskType]}&grup_no=${groupNo}');
                                        }
                                        if(shop!=0&&bs==0){
                                          futureIncompleteTask = fetchIncompleteTask('${constUrl}api/TamamlanmamisGorev/filterTask4?magaza_kodu=${createShopFilterList(bsIDs[bs])[shop]}&tamamlandi_bilgisi=1&gorev_turu=${taskTypeListCompleteTask[taskType]}&grup_no=${groupNo}');
                                        }
                                        if(shop!=0&&bs!=0){
                                          futureIncompleteTask = fetchIncompleteTask('${constUrl}api/TamamlanmamisGorev/filterTask4?magaza_kodu=${createShopFilterList(bsIDs[bs])[shop]}&tamamlandi_bilgisi=1&gorev_turu=${taskTypeListCompleteTask[taskType]}&grup_no=${groupNo}');
                                        }
                                      });
                                    },
                                    children:
                                    List<Widget>.generate(createShopFilterList(bsIDs[bs]).length, (int index) {
                                      return Center(child: Text(createShopFilterList(bsIDs[bs])[index]));
                                    }),
                                  ),
                                ),
                                child: Text(
                                  (shop==0)?createShopFilterList(bsIDs[bs])[shop]:"Mağaza Kodu:\n"+createShopFilterList(bsIDs[bs])[shop],
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              )
                          ),
                          SizedBox(width: deviceWidth*0.03,),
                          Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  side: BorderSide(
                                      color: Colors.indigo,
                                      width: 1.5
                                  )
                              ),
                              child: CupertinoButton(
                                padding: EdgeInsets.fromLTRB(3, 0, 3, 0),
                                onPressed: () => _showDialog(
                                  CupertinoPicker(
                                    magnification: 1.22,
                                    squeeze: 1.2,
                                    useMagnifier: true,
                                    itemExtent: kItemExtent,
                                    scrollController: FixedExtentScrollController(
                                      initialItem: bs,
                                    ),
                                    onSelectedItemChanged: (int selectedItem) {
                                      setState(() {
                                        bs = selectedItem;
                                        if(shop==0&&bs==0){
                                          futureIncompleteTask = fetchIncompleteTask('${constUrl}api/TamamlanmamisGorev/filterTask1?$urlTaskShops&tamamlandi_bilgisi=1&gorev_turu=${taskTypeListCompleteTask[taskType]}&grup_no=${groupNo}');
                                        }
                                        if(shop==0&&bs!=0){
                                          futureIncompleteTask = fetchIncompleteTask('${constUrl}api/TamamlanmamisGorev/filterTask1?${createUrlTaskShopsWithBS(bsIDs[bs])}&tamamlandi_bilgisi=1&gorev_turu=${taskTypeListCompleteTask[taskType]}&grup_no=${groupNo}');
                                        }
                                        if(shop!=0&&bs==0){
                                          futureIncompleteTask = fetchIncompleteTask('${constUrl}api/TamamlanmamisGorev/filterTask4?magaza_kodu=${createShopFilterList(bsIDs[bs])[shop]}&tamamlandi_bilgisi=1&gorev_turu=${taskTypeListCompleteTask[taskType]}&grup_no=${groupNo}');
                                        }
                                        if(shop!=0&&bs!=0){
                                          futureIncompleteTask = fetchIncompleteTask('${constUrl}api/TamamlanmamisGorev/filterTask4?magaza_kodu=${createShopFilterList(bsIDs[bs])[shop]}&tamamlandi_bilgisi=1&gorev_turu=${taskTypeListCompleteTask[taskType]}&grup_no=${groupNo}');
                                        }
                                      });
                                    },
                                    children:
                                    List<Widget>.generate(bsNames.length, (int index) {
                                      return Center(child: Text(bsNames[index]));
                                    }),
                                  ),
                                ),
                                child: Text(
                                  bsNames[bs],
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              )
                          ),
                        ]
                      ),
                      SizedBox(height: deviceHeight*0.005,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                                side: BorderSide(
                                    color: Colors.indigo,
                                    width: 1.5
                                )
                            ),
                            child: CupertinoButton(
                              padding: EdgeInsets.fromLTRB(3, 0, 3, 0),
                              onPressed: () => _showDialog(
                                CupertinoPicker(
                                  magnification: 1.22,
                                  squeeze: 1.2,
                                  useMagnifier: true,
                                  itemExtent: kItemExtent,
                                  scrollController: FixedExtentScrollController(
                                    initialItem: taskType,
                                  ),
                                  onSelectedItemChanged: (int selectedItem) {
                                    setState(() {
                                      taskType = selectedItem;
                                      if(shop==0&&bs==0){
                                        futureIncompleteTask = fetchIncompleteTask('${constUrl}api/TamamlanmamisGorev/filterTask1?$urlTaskShops&tamamlandi_bilgisi=1&gorev_turu=${taskTypeListCompleteTask[taskType]}&grup_no=${groupNo}');
                                      }
                                      if(shop==0&&bs!=0){
                                        futureIncompleteTask = fetchIncompleteTask('${constUrl}api/TamamlanmamisGorev/filterTask1?${createUrlTaskShopsWithBS(bsIDs[bs])}&tamamlandi_bilgisi=1&gorev_turu=${taskTypeListCompleteTask[taskType]}&grup_no=${groupNo}');
                                      }
                                      if(shop!=0&&bs==0){
                                        futureIncompleteTask = fetchIncompleteTask('${constUrl}api/TamamlanmamisGorev/filterTask4?magaza_kodu=${createShopFilterList(bsIDs[bs])[shop]}&tamamlandi_bilgisi=1&gorev_turu=${taskTypeListCompleteTask[taskType]}&grup_no=${groupNo}');
                                      }
                                      if(shop!=0&&bs!=0){
                                        futureIncompleteTask = fetchIncompleteTask('${constUrl}api/TamamlanmamisGorev/filterTask4?magaza_kodu=${createShopFilterList(bsIDs[bs])[shop]}&tamamlandi_bilgisi=1&gorev_turu=${taskTypeListCompleteTask[taskType]}&grup_no=${groupNo}');
                                      }
                                    });
                                  },
                                  children:
                                  List<Widget>.generate(taskListCompleteTask.length, (int index) {
                                    return Center(child: Text(taskListCompleteTask[index]));
                                  }),
                                ),
                              ),
                              child: Text(
                                taskListCompleteTask[taskType],
                                style: const TextStyle(
                                  fontSize: 14,
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
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  side: BorderSide(
                                      color: Colors.indigo,
                                      width: 1.5
                                  )
                              ),
                              child: CupertinoButton(
                                padding: EdgeInsets.fromLTRB(3, 0, 3, 0),
                                onPressed: () => _showDialog(
                                  CupertinoPicker(
                                    magnification: 1.22,
                                    squeeze: 1.2,
                                    useMagnifier: true,
                                    itemExtent: kItemExtent,
                                    scrollController: FixedExtentScrollController(
                                      initialItem: shop2,
                                    ),
                                    onSelectedItemChanged: (int selectedItem) {
                                      setState(() {
                                        shop2 = selectedItem;
                                        if(shop2==0&&bs2==0){
                                          futureIncompleteTask2 = fetchIncompleteTask('${constUrl}api/TamamlanmamisGorev/filterTask1?$urlTaskShops&tamamlandi_bilgisi=0&gorev_turu=${taskTypeListIncompleteTask[taskType2]}&grup_no=${groupNo}');
                                        }
                                        if(shop2==0&&bs2!=0){
                                          futureIncompleteTask2 = fetchIncompleteTask('${constUrl}api/TamamlanmamisGorev/filterTask1?${createUrlTaskShopsWithBS(bsIDs[bs2])}&tamamlandi_bilgisi=0&gorev_turu=${taskTypeListIncompleteTask[taskType2]}&grup_no=${groupNo}');
                                        }
                                        if(shop2!=0&&bs2==0){
                                          futureIncompleteTask2 = fetchIncompleteTask('${constUrl}api/TamamlanmamisGorev/filterTask4?magaza_kodu=${createShopFilterList(bsIDs[bs2])[shop2]}&tamamlandi_bilgisi=0&gorev_turu=${taskTypeListIncompleteTask[taskType2]}&grup_no=${groupNo}');
                                        }
                                        if(shop2!=0&&bs2!=0){
                                          futureIncompleteTask2 = fetchIncompleteTask('${constUrl}api/TamamlanmamisGorev/filterTask4?magaza_kodu=${createShopFilterList(bsIDs[bs2])[shop2]}&tamamlandi_bilgisi=0&gorev_turu=${taskTypeListIncompleteTask[taskType2]}&grup_no=${groupNo}');
                                        }
                                      });
                                    },
                                    children:
                                    List<Widget>.generate(createShopFilterList((bsIDs[bs2])).length, (int index) {
                                      return Center(child: Text(createShopFilterList((bsIDs[bs2]))[index]));
                                    }),
                                  ),
                                ),
                                child: Text(
                                  (shop2==0)?createShopFilterList((bsIDs[bs2]))[shop2]:"Mağaza Kodu:\n"+createShopFilterList((bsIDs[bs2]))[shop2],
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              )
                          ),
                          SizedBox(width: deviceWidth*0.03,),
                          Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  side: BorderSide(
                                      color: Colors.indigo,
                                      width: 1.5
                                  )
                              ),
                              child: CupertinoButton(
                                padding: EdgeInsets.fromLTRB(3, 0, 3, 0),
                                onPressed: () => _showDialog(
                                  CupertinoPicker(
                                    magnification: 1.22,
                                    squeeze: 1.2,
                                    useMagnifier: true,
                                    itemExtent: kItemExtent,
                                    scrollController: FixedExtentScrollController(
                                      initialItem: bs2,
                                    ),
                                    onSelectedItemChanged: (int selectedItem) {
                                      setState(() {
                                        bs2 = selectedItem;
                                        if(shop2==0&&bs2==0){
                                          futureIncompleteTask2 = fetchIncompleteTask('${constUrl}api/TamamlanmamisGorev/filterTask1?$urlTaskShops&tamamlandi_bilgisi=0&gorev_turu=${taskTypeListCompleteTask[taskType2]}&grup_no=${groupNo}');
                                        }
                                        if(shop2==0&&bs2!=0){
                                          futureIncompleteTask2 = fetchIncompleteTask('${constUrl}api/TamamlanmamisGorev/filterTask1?${createUrlTaskShopsWithBS(bsIDs[bs2])}&tamamlandi_bilgisi=0&gorev_turu=${taskTypeListIncompleteTask[taskType2]}&grup_no=${groupNo}');
                                        }
                                        if(shop2!=0&&bs2==0){
                                          futureIncompleteTask2 = fetchIncompleteTask('${constUrl}api/TamamlanmamisGorev/filterTask4?magaza_kodu=${createShopFilterList(bsIDs[bs2])[shop2]}&tamamlandi_bilgisi=0&gorev_turu=${taskTypeListIncompleteTask[taskType2]}&grup_no=${groupNo}');
                                        }
                                        if(shop2!=0&&bs2!=0){
                                          futureIncompleteTask2 = fetchIncompleteTask('${constUrl}api/TamamlanmamisGorev/filterTask4?magaza_kodu=${createShopFilterList(bsIDs[bs2])[shop2]}&tamamlandi_bilgisi=0&gorev_turu=${taskTypeListCompleteTask[taskType2]}&grup_no=${groupNo}');
                                        }
                                      });
                                    },
                                    children:
                                    List<Widget>.generate(bsNames.length, (int index) {
                                      return Center(child: Text(bsNames[index]));
                                    }),
                                  ),
                                ),
                                child: Text(
                                  bsNames[bs2],
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              )
                          ),
                        ]
                      ),
                      SizedBox(height: deviceHeight*0.005,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                                side: BorderSide(
                                    color: Colors.indigo,
                                    width: 1.5
                                )
                            ),
                            child: CupertinoButton(
                              padding: EdgeInsets.fromLTRB(3, 0, 3, 0),
                              onPressed: () => _showDialog(
                                CupertinoPicker(
                                  magnification: 1.22,
                                  squeeze: 1.2,
                                  useMagnifier: true,
                                  itemExtent: kItemExtent,
                                  scrollController: FixedExtentScrollController(
                                    initialItem: taskType2,
                                  ),
                                  onSelectedItemChanged: (int selectedItem) {
                                    setState(() {
                                      taskType2 = selectedItem;
                                      if(shop2==0&&bs2==0){
                                        futureIncompleteTask2 = fetchIncompleteTask('${constUrl}api/TamamlanmamisGorev/filterTask1?${urlTaskShops}&tamamlandi_bilgisi=0&gorev_turu=${taskTypeListIncompleteTask[taskType2]}&grup_no=${groupNo}');
                                      }
                                      if(shop2==0&&bs2!=0){
                                        futureIncompleteTask2 = fetchIncompleteTask('${constUrl}api/TamamlanmamisGorev/filterTask1?${createUrlTaskShopsWithBS(bsIDs[bs2])}&tamamlandi_bilgisi=0&gorev_turu=${taskTypeListIncompleteTask[taskType2]}&grup_no=${groupNo}');
                                      }
                                      if(shop2!=0&&bs2==0){
                                        futureIncompleteTask2 = fetchIncompleteTask('${constUrl}api/TamamlanmamisGorev/filterTask4?magaza_kodu=${createShopFilterList(bsIDs[bs2])[shop2]}&tamamlandi_bilgisi=0&gorev_turu=${taskTypeListIncompleteTask[taskType2]}&grup_no=${groupNo}');
                                      }
                                      if(shop2!=0&&bs2!=0){
                                        futureIncompleteTask2 = fetchIncompleteTask('${constUrl}api/TamamlanmamisGorev/filterTask4?magaza_kodu=${createShopFilterList(bs2)[shop2]}&tamamlandi_bilgisi=0&gorev_turu=${taskTypeListIncompleteTask[taskType2]}&grup_no=${groupNo}');
                                      }
                                    });
                                  },
                                  children:
                                  List<Widget>.generate(taskListIncompleteTask.length, (int index) {
                                    return Center(child: Text(taskListIncompleteTask[index]));
                                  }),
                                ),
                              ),
                              child: Text(
                                taskListIncompleteTask[taskType2],
                                style: const TextStyle(
                                  fontSize: 14,
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
              )
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

  Widget taskTypeInfo(){
    return TextWidget(text: "Görevleri görüntülerken aşağıdaki butonlaryardımıyla\nfiltreleme yapabilirsiniz.", size: 13, fontWeight: FontWeight.w400, color: textColor);
  }

}
