import 'package:deneme/constants/constants.dart';
import 'package:deneme/models/externalWork.dart';
import 'package:deneme/routing/bottomNavigationBar.dart';
import 'package:deneme/routing/landing.dart';
import 'package:deneme/styles/styleConst.dart';
import 'package:deneme/widgets/cards/externalWorkDetailCard.dart';
import 'package:flutter/material.dart';
import '../../constants/bottomNaviBarLists.dart';
import '../../constants/pagesLists.dart';
import '../../main.dart';
import '../../services/externalWorkServices.dart';

class ExternalTaskDetailScreen extends StatefulWidget {

  int work_id = 0;
  ExternalTaskDetailScreen({super.key, required this.work_id});

  @override
  State<ExternalTaskDetailScreen> createState() =>
      _ExternalTaskDetailScreenState();
}

class _ExternalTaskDetailScreenState extends State<ExternalTaskDetailScreen> with TickerProviderStateMixin {

  late Future<ExternalWork> futureExternalWork;

  int _selectedIndex = 0;

  List<BottomNavigationBarItem> naviBarList = [];
  List<Widget> pageList = [];

  late double deviceHeight;
  late double deviceWidth;

  DateTime now = DateTime.now();

  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    futureExternalWork = fetchExternalWork2('${constUrl}api/HariciIs/${widget.work_id}');
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
      if(user=="BS" && box.get("groupNo") == 2 && box.get("groupNo") == 3){
        naviBarList = itemListTZ;
        if(isStartShiftObs.value==false&&isRegionCenterVisitInProgress.value==false){
          pageList = pagesUnkarTZ;
        }
        else if(isStartShiftObs.value&&isRegionCenterVisitInProgress.value==false){
          pageList = pagesUnkarTZ2;
        }
      }
      else if(user=="BS"){
        naviBarList = itemListBS;
        if(isStartShiftObs.value==false&&isRegionCenterVisitInProgress.value==false){
          pageList = pagesBS;
        }
        else if(isStartShiftObs.value&&isRegionCenterVisitInProgress.value==false){
          pageList = pagesBS2;
        }
      }
      else if(user=="PM"){
        naviBarList = itemListPM;
        if(isStartShiftObs.value==false&&isRegionCenterVisitInProgress.value==false){
          pageList = pagesPM;
        }
        else if(isStartShiftObs.value&&isRegionCenterVisitInProgress.value==false){
          pageList = pagesPM2;
        }
      }
      else if(user=="BM" || user=="GK"){
        naviBarList = itemListBMandGK;
        pageList = pagesBMGK;
      }
      else if(user=="NK"){
        naviBarList = itemListNK;
        pageList = pagesNK;
      }
    }


    userCondition(userType);

    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          foregroundColor: appbarForeground,
          backgroundColor: appbarBackground,
          title: const Text('Harici İş Detayı'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              naviExternalTasksListScreen(context);
            },
          ),
        ),
        body: PopScope(
          canPop: false,
          onPopInvoked: (bool didPop) {},
          child:SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(0, deviceHeight*0.04, 0, 0),
            child:Container(
              alignment: Alignment.center,
              child: externalTaskDetailScreenUI(),
            ),
          )
        ),
        bottomNavigationBar: BottomNaviBar(selectedIndex: _selectedIndex,itemList: naviBarList,pageList: pageList,)
    );
  }

  Widget externalTaskDetailScreenUI(){
    return Column(
        children: [FutureBuilder<ExternalWork>(
            future: futureExternalWork,
            builder: (context, snapshot){
              if(snapshot.hasData){
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ExternalWorkDetailCard(
                      heightConst: 0.7,
                      widthConst: 0.9,
                      taskName: snapshot.data!.workTitle,
                      taskDescription: snapshot.data!.workDetail,
                      startHour: snapshot.data!.workStartHour.toString(),
                      finishHour: snapshot.data!.workFinishHour.toString(),
                      workPlace: snapshot.data!.workPlace,
                      isCompleted: (snapshot.data!.completionInfo==1)?true:false,
                      id: snapshot.data!.external_work_id,
                      user_id: userID,
                      assignmentDate: snapshot.data!.workAssignmentDate,
                      onTaps: (){naviExternalTasksListScreen(context);},
                      lat: snapshot.data!.Lat,
                      long: snapshot.data!.Long,
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
}


