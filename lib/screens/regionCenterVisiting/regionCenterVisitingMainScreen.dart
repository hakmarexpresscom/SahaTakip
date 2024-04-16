import 'package:deneme/constants/constants.dart';
import 'package:deneme/services/visitingDurationsServices.dart';
import 'package:deneme/styles/styleConst.dart';
import 'package:deneme/widgets/button_widget.dart';
import 'package:deneme/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../main.dart';
import '../../../routing/landing.dart';
import '../../../utils/appStateManager.dart';
import '../../../utils/generalFunctions.dart';
import '../../constants/bottomNaviBarLists.dart';
import '../../constants/pagesLists.dart';
import '../../routing/bottomNavigationBar.dart';
import '../../widgets/cards/shopVisitingProcessCard.dart';

class RegionCenterVisitingMainScreen extends StatefulWidget {
  int region_code = 0;
  String regionName = "";

  RegionCenterVisitingMainScreen({super.key, required this.region_code,required this.regionName});

  @override
  State<RegionCenterVisitingMainScreen> createState() =>
      _RegionCenterVisitingMainScreenState();
}

class _RegionCenterVisitingMainScreenState extends State<RegionCenterVisitingMainScreen> {

  int _selectedIndex = 0;

  late double deviceHeight;
  late double deviceWidth;

  List<BottomNavigationBarItem> naviBarList = [];
  List<Widget> pageList = [];

  DateTime now = DateTime.now();

  final RegionCenterVisitManager regionCenterVisitManager = Get.put(RegionCenterVisitManager());

  @override
  void initState() {
    super.initState();
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
        title: const Text('Bölge Merkezi Ziyareti'),
      ),
      body: PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) {},
        child:SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child:Container(
              alignment: Alignment.center,
              child: regionCenterVisitingMainScreenUI(),
            ),
        )
      ),
      bottomNavigationBar: BottomNaviBar(selectedIndex: _selectedIndex,itemList: naviBarList,pageList: pageList,)
    );
  }

  Widget regionCenterVisitingMainScreenUI(){
    return Builder(builder: (BuildContext context){
      return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                color: Colors.grey.withOpacity(0.4),
                height: deviceHeight*0.13,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        shopCodeInfo(),
                        shopNameInfo(),
                      ],
                    ),
                    stopVisitingButton(),
                  ],
                ),
              ),
              (isBS==false&&groupNo==1)?SizedBox(height: deviceHeight*0.02,):SizedBox(height: deviceHeight*0,),
              (isBS==false&&groupNo==1)?Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        ShopVisitingProcessCard(heightConst: 0.25, widthConst: 0.47, processName: "Manav\nDepo\nFormu", processIcon: Icons.checklist,onTaps: (){naviManavDepoFormScreen(context, widget.region_code);}),
                      ]
                  ),
                ],
              ):Container()
            ],
          ));
    });
  }

  Widget shopNameInfo(){
    return TextWidget(text: widget.regionName, size: 18, fontWeight: FontWeight.w600, color: textColor);
  }
  Widget shopCodeInfo(){
    return TextWidget(text: "${widget.region_code}", size: 20, fontWeight: FontWeight.w600, color: textColor);
  }
  Widget stopVisitingButton(){
    return ButtonWidget(
      text: "Ziyareti Bitir",
      heightConst: 0.055,
      widthConst: 0.25,
      size: 15,
      radius: 20,
      fontWeight: FontWeight.w600,
      onTaps: (){
        regionCenterVisitManager.endRegionCenterVisit();
        box.put("visitingFinishTime",DateTime.now());
        String visitingDuration = calculateElapsedTime(box.get("visitingStartTime"),box.get("visitingFinishTime"));
        updateFinishHourWorkDurationVisitingDurations(
          visitingDurationsCount,
          box.get('currentCenterID'),
          (isBS==true)?userID:null,
          (isBS==true)?null:userID,
          box.get("visitingStartTime").toIso8601String(),
          box.get("visitingFinishTime").toIso8601String(),
          box.get("shiftDate"),
          visitingDuration,
          "${constUrl}api/ZiyaretSureleri"
        );
        naviShiftTypeScreen(context);
      },
      borderWidht: 1,
      backgroundColor: redColor,
      borderColor: redColor,
      textColor: textColor);
  }

}



