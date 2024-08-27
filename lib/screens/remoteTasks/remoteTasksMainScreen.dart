import 'package:deneme/constants/constants.dart';
import 'package:deneme/models/incompleteTask.dart';
import 'package:deneme/routing/bottomNavigationBar.dart';
import 'package:deneme/services/inCompleteTaskServices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../constants/bottomNaviBarLists.dart';
import '../../constants/pagesLists.dart';
import '../../routing/landing.dart';
import '../../styles/styleConst.dart';
import '../../widgets/cards/taskCard.dart';
import '../../widgets/text_widget.dart';

class RemoteTaskMainScreen extends StatefulWidget {
  const RemoteTaskMainScreen({super.key});

  @override
  State<RemoteTaskMainScreen> createState() =>
      _RemoteTaskMainScreenState();
}

class _RemoteTaskMainScreenState extends State<RemoteTaskMainScreen> with TickerProviderStateMixin {

  late Future<List<IncompleteTask>> futureIncompleteTask;

  int shop = 0;

  int bs = 0;

  int _selectedIndex = 3;

  List<BottomNavigationBarItem> naviBarList = [];
  List<Widget> pageList = [];

  late double deviceHeight;
  late double deviceWidth;

  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    futureIncompleteTask = fetchIncompleteTask('${constUrl}api/TamamlanmamisGorev/filterTask1?$urlTaskShops&tamamlandi_bilgisi=0&gorev_turu=Uzaktan&grup_no=${groupNo}');
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
          foregroundColor: appbarForeground,
          backgroundColor: appbarBackground,
          title: const Text('Uzaktan Görevler'),
        ),
        body: PopScope(
          canPop: false,
          onPopInvoked: (bool didPop) {},
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: deviceHeight*0.03,),
                shopTypeInfo(),
                SizedBox(height: deviceHeight*0.02,),
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
                                futureIncompleteTask = fetchIncompleteTask('${constUrl}api/TamamlanmamisGorev/filterTask1?$urlTaskShops&tamamlandi_bilgisi=0&gorev_turu=Uzaktan&grup_no=${groupNo}');
                              }
                              else{
                                futureIncompleteTask = fetchIncompleteTask('${constUrl}api/TamamlanmamisGorev/filterTask4?magaza_kodu=${createShopFilterList2()[shop]}&tamamlandi_bilgisi=0&gorev_turu=Uzaktan&grup_no=${groupNo}');
                              }
                            });
                          },
                          children:
                          List<Widget>.generate(createShopFilterList2().length, (int index) {
                            return Center(child: Text(createShopFilterList2()[index]));
                          }),
                        ),
                      ),
                      // This displays the selected fruit name.
                      child: Text(
                        (shop==0)?createShopFilterList2()[shop]:"Mağaza Kodu: "+createShopFilterList2()[shop],
                        style: const TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    )
                ),
                SizedBox(height: deviceHeight*0.02,),
                remoteTaskMainScreenUI()
              ],
          )
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
                      TaskCard(taskName: snapshot.data![index].taskTitle, taskAssignmentDate: snapshot.data![index].taskAssigmentDate ,taskType: snapshot.data![index].taskType , shop_code:snapshot.data![index].shopCode, onTaps: (){naviRemoteTaskDetailScreen(context,snapshot.data![index].task_id);}),
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

  Widget shopTypeInfo(){
    return TextWidget(text: "Görevleri görüntülerken mağaza kodunu aşağıdaki\nbutona basarak filtreleyebilirsiniz.", size: 16, fontWeight: FontWeight.w400, color: textColor);
  }
}