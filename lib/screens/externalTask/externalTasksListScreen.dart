import 'package:deneme/constants/constants.dart';
import 'package:deneme/routing/bottomNavigationBar.dart';
import 'package:flutter/material.dart';
import '../../constants/bottomNaviBarLists.dart';
import '../../constants/pagesLists.dart';
import '../../main.dart';
import '../../models/externalWork.dart';
import '../../routing/landing.dart';
import '../../services/externalWorkServices.dart';
import '../../styles/styleConst.dart';
import '../../widgets/cards/externalWorkCard.dart';

class ExternalTasksListScreen extends StatefulWidget {
  const ExternalTasksListScreen({super.key});

  @override
  State<ExternalTasksListScreen> createState() =>
      _ExternalTasksListScreenState();
}

class _ExternalTasksListScreenState extends State<ExternalTasksListScreen> with TickerProviderStateMixin  {

  late Future<List<ExternalWork>> futureExternalWork;

  int _selectedIndex = 0;

  List<BottomNavigationBarItem> naviBarList = [];
  List<Widget> pageList = [];

  late double deviceHeight;
  late double deviceWidth;

  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    futureExternalWork = fetchExternalWork('${constUrl}api/HariciIs/$urlWorkFilter=${userID}&tamamlandi_bilgisi=0');
    controller = AnimationController(
      /// [AnimationController]s can be created with `vsync: this` because of
      /// [TickerProviderStateMixin].
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
      //setState(() {});
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

    void userCondition(String user){
      if(user=="BS" && box.get("groupNo") == 3){
        naviBarList = itemListTZ;
        if(isStartShiftObs.value==false&&isRegionCenterVisitInProgress.value==false){
          pageList = pagesTZ;
        }
        else if(isStartShiftObs.value&&isRegionCenterVisitInProgress.value==false){
          pageList = pagesTZ2;
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
          title: const Text('Harici İşlerim'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              naviExternalTaskMainScreen(context);
            },
          ),
        ),
        body: PopScope(
          canPop: false,
          onPopInvoked: (bool didPop) {},
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: deviceHeight*0.02,),
              externalTasksMainScreenUI()
            ],
          )
        ),
        bottomNavigationBar: BottomNaviBar(selectedIndex: _selectedIndex,itemList: naviBarList,pageList: pageList,)
    );
  }

  Widget externalTasksMainScreenUI(){
    return Expanded(
        child: FutureBuilder<List<ExternalWork>>(
            future: futureExternalWork,
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
                        ExternalWorkCard(
                          taskName: snapshot.data![index].workTitle,
                          taskAssignmentDate: snapshot.data![index].workAssignmentDate,
                          workPlace: snapshot.data![index].workPlace,
                          onTaps: (){
                            naviExternalTaskDetailScreen(context,snapshot.data![index].external_work_id);
                          }
                        ) ,
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


