import 'package:deneme/constants/constants.dart';
import 'package:deneme/routing/bottomNavigationBar.dart';
import 'package:flutter/material.dart';
import '../../constants/bottomNaviBarLists.dart';
import '../../constants/pagesLists.dart';
import '../../models/externalWork.dart';
import '../../routing/landing.dart';
import '../../services/externalWorkServices.dart';
import '../../widgets/cards/taskCard.dart';

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
          foregroundColor: Colors.white,
          backgroundColor: Colors.indigo,
          title: const Text('Harici İşlerim'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              naviExternalTaskMainScreen(context);
            },
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: deviceHeight*0.02,),
            externalTasksMainScreenUI()
          ],
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
                        TaskCard(heightConst: 0.15, widthConst: 0.95, taskName: snapshot.data![index].workTitle, taskAssignmentDate: "", taskType: "Harici", shop_code: 0, onTaps: (){naviExternalTaskDetailScreen(context,snapshot.data![index].external_work_id);}),
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


