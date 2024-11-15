import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:deneme/constants/constants.dart';
import 'package:deneme/routing/bottomNavigationBar.dart';
import 'package:deneme/services/shiftServices.dart';
import 'package:deneme/styles/styleConst.dart';
import 'package:deneme/widgets/button_widget.dart';
import 'package:deneme/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../constants/bottomNaviBarLists.dart';
import '../../constants/pagesLists.dart';
import '../../main.dart';
import '../../models/shift.dart';
import '../../routing/landing.dart';
import '../../utils/appStateManager.dart';
import '../../utils/generalFunctions.dart';

class StartWorkMainScreen extends StatefulWidget {

  const StartWorkMainScreen({super.key});

  @override
  State<StartWorkMainScreen> createState() =>
      _StartWorkMainScreenState();
}

class _StartWorkMainScreenState extends State<StartWorkMainScreen> {

  late Future<List<Shift>> futureShift;

  int _selectedIndex = 0;

  List<BottomNavigationBarItem> naviBarList = [];
  List<Widget> pageList = [];

  late double deviceHeight;
  late double deviceWidth;

  DateTime now = DateTime.now();

  final ShiftManager shiftManager = Get.put(ShiftManager());

  @override
  void initState() {
    super.initState();
    futureShift = fetchShift('${constUrl}api/Mesai/${urlShiftFilter}=${userID}&mesai_tarihi=${DateTime.now().toIso8601String()}');
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
        _selectedIndex = 0;
      }
      else if(user=="PM"){
        naviBarList = itemListPM;
        if(isStartShiftObs.value==false&&isRegionCenterVisitInProgress.value==false){
          pageList = pagesPM;
        }
        else if(isStartShiftObs.value&&isRegionCenterVisitInProgress.value==false){
          pageList = pagesPM2;
        }
        _selectedIndex = 0;
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
        automaticallyImplyLeading: false,
        foregroundColor: appbarForeground,
        backgroundColor: appbarBackground,
        title: const Text('Mesaiye Başla'),
      ),
      body: PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) {},
          child:SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child:Container(
              alignment: Alignment.center,
              child: startWorkMainScreenUI(),
            ),
          )
      ),
      bottomNavigationBar: BottomNaviBar(selectedIndex: _selectedIndex,itemList: naviBarList,pageList: pageList,)
    );
  }

  Widget startWorkMainScreenUI(){
    return Builder(builder: (BuildContext context){
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: deviceHeight*0.25,),
            workDurationInfo(),
            SizedBox(height: deviceHeight*0.07,),
            startWorkButton(context),
          ],
        ),
      );
    });
  }


  Widget workDurationInfo(){
    return FutureBuilder<List<Shift>>(
        future: futureShift,
        builder: (context, snapshot){
          if(snapshot.hasData){
            return TextWidget(text:"En son kaydettiğiniz mesai süreniz:\n"+calculateElapsedTime(box.get("startTime"),box.get("finishTime")), size: 25, fontWeight: FontWeight.w400, color: textColor);
          }
          else{
            return TextWidget(text:"En sonki çalışma süreniz:\n0 saat 0 dakika 0 saniye\nBugün hiç mesai başlatmadınız.", size: 25, fontWeight: FontWeight.w400, color: textColor);
          }
        }
    );
  }

  Widget startWorkButton(BuildContext context){
    return ButtonWidget(
        text: "Mesai Türleri",
        heightConst: 0.06,
        widthConst: 0.8,
        size: 18,
        radius: 20,
        fontWeight:
        FontWeight.w600,
        onTaps: () async {
          DateTime startTime = DateTime(now.year, now.month, now.day, 8, 30);
          DateTime endTime = DateTime(now.year, now.month, now.day, 18, 30);

          bool isWithinTimeRange = now.isAfter(startTime) && now.isBefore(endTime);

          var connectivityResult = await (Connectivity().checkConnectivity());

          if(connectivityResult[0] == ConnectivityResult.none){
            showAlertDialogWidget(context, 'Internet Bağlantı Hatası', 'Telefonunuzun internet bağlantısı bulunmamaktadır. Lütfen telefonunuzu internete bağlayınız.', (){Navigator.of(context).pop();});
          }

          else if(isWithinTimeRange && connectivityResult[0] != ConnectivityResult.none){
            await onDayShift('${constUrl}api/Mesai/${urlShiftFilter}=${userID}&mesai_tarihi=${DateTime.now().toIso8601String()}');
            naviShiftTypeScreen(context);
          }

          else if(isWithinTimeRange==false && connectivityResult[0] != ConnectivityResult.none){
            showAlertDialogWidget(context, 'Mesai Saati Kontrolü', '08.30-18.30 saatleri arasında mesai başlatabilirsiniz!', (){naviStartWorkMainScreen(context);});
          }
        },
        borderWidht: 1,
        backgroundColor: secondaryColor,
        borderColor: secondaryColor,
        textColor: textColor
    );
  }

}

