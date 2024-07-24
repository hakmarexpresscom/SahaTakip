import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:deneme/services/visitingDurationsServices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../constants/bottomNaviBarLists.dart';
import '../../constants/constants.dart';
import '../../constants/pagesLists.dart';
import '../../main.dart';
import '../../models/center.dart';
import '../../routing/bottomNavigationBar.dart';
import '../../routing/landing.dart';
import '../../services/centerServices.dart';
import '../../services/shiftServices.dart';
import '../../styles/styleConst.dart';
import '../../utils/appStateManager.dart';
import '../../utils/distanceFunctions.dart';
import '../../utils/generalFunctions.dart';
import '../../widgets/alert_dialog.dart';
import '../../widgets/alert_dialog_without_button.dart';
import '../../widgets/button_widget.dart';

class ShiftTypeScreen extends StatefulWidget {
  const ShiftTypeScreen({super.key});

  @override
  State<ShiftTypeScreen> createState() => _ShiftTypeScreenState();
}

class _ShiftTypeScreenState extends State<ShiftTypeScreen> with TickerProviderStateMixin {

  int _selectedIndex = 0;

  late Future<RegionCenter> futureRegionCenter;

  List<BottomNavigationBarItem> naviBarList = [];
  List<Widget> pageList = [];

  late double deviceHeight;
  late double deviceWidth;

  DateTime now = DateTime.now();

  late AnimationController controller;

  final ShiftManager shiftManager = Get.put(ShiftManager());
  final StoreVisitManager storeVisitManager = Get.put(StoreVisitManager());
  final RegionCenterVisitManager regionCenterVisitManager = Get.put(RegionCenterVisitManager());

  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;
  String long = "1", lat = "1";
  late StreamSubscription<Position> positionStream;

  @override
  void initState() {
    super.initState();
    futureRegionCenter = fetchRegionCenter2('${constUrl}api/BolgeMerkezleri/${regionCode}');
    checkGps();
    controller = AnimationController(
      /// [AnimationController]s can be created with `vsync: this` because of
      /// [TickerProviderStateMixin].
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
    });
    controller.repeat(reverse: true);
  }

  checkGps() async {
    servicestatus = await Geolocator.isLocationServiceEnabled();
    if(servicestatus){
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Location permissions are denied');
        }else if(permission == LocationPermission.deniedForever){
          print("'Location permissions are permanently denied");
        }else{
          haspermission = true;
        }
      }else{
        haspermission = true;
      }

      if(haspermission){
        setState(() {
          //refresh the UI
        });

        getLocation();
      }
    }else{
      print("GPS Service is not enabled, turn on GPS location");
    }

    setState(() {
      //refresh the UI
    });
  }

  getLocation() async {
    position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position.longitude);
    print(position.latitude);

    long = position.longitude.toString();
    lat = position.latitude.toString();

    setState(() {
      //refresh UI
    });

    LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );

    StreamSubscription<Position> positionStream = Geolocator.getPositionStream(
        locationSettings: locationSettings).listen((Position position) {
      print(position.longitude);
      print(position.latitude);

      long = position.longitude.toString();
      lat = position.latitude.toString();

      setState(() {
        //refresh UI on update
      });
    });
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
          title: const Text('Mesai Türleri'),
        ),
        body: PopScope(
            canPop: false,
            onPopInvoked: (bool didPop) {},
            child:SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child:Container(
                alignment: Alignment.center,
                child: shiftTypeScreenUI(),
              ),
            )
        ),
        bottomNavigationBar: BottomNaviBar(selectedIndex: _selectedIndex,itemList: naviBarList,pageList: pageList,)
    );
  }

  Widget shiftTypeScreenUI(){
    return Builder(builder: (BuildContext context){
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: deviceHeight*0.08,),
            shopVisitingButton(),
            SizedBox(height: deviceHeight*0.03,),
            regionCenterVisitingButton(),
            SizedBox(height: deviceHeight*0.03,),
            externalWorkButton(),
            SizedBox(height: deviceHeight*0.03,),
            stopShiftButton()
          ],
        ),
      );
    });
  }

  Widget shopVisitingButton(){
    return ButtonWidget(
        text: "Mağaza Ziyareti",
        heightConst: 0.06,
        widthConst: 0.8,
        size: 18,
        radius: 20,
        fontWeight: FontWeight.w600,
        onTaps: (){
          (isBS) ? naviShopVisitingShopsScreen(context):naviShopVisitingShopsScreenPM(context);
        },
        borderWidht: 1,
        backgroundColor: secondaryColor,
        borderColor: secondaryColor,
        textColor: textColor);
  }

  Widget externalWorkButton(){
    return ButtonWidget(
        text: "Harici İş",
        heightConst: 0.06,
        widthConst: 0.8,
        size: 18,
        radius: 20,
        fontWeight: FontWeight.w600,
        onTaps: (){
          naviExternalTaskMainScreen(context);
        },
        borderWidht: 1,
        backgroundColor: primaryColor,
        borderColor: primaryColor,
        textColor: textColor);
  }

  Widget regionCenterVisitingButton(){
    return FutureBuilder<RegionCenter>(
        future: futureRegionCenter,
        builder: (context, snapshot){
          if(snapshot.hasData){
            return ButtonWidget(
                text: snapshot.data!.centerName+" Ziyareti",
                heightConst: 0.06,
                widthConst: 0.8,
                size: 18,
                radius: 20,
                fontWeight: FontWeight.w600,
                onTaps: () async{

                  var connectivityResult = await (Connectivity().checkConnectivity());

                  if(connectivityResult[0] == ConnectivityResult.none){
                    showAlertDialogWidget(context, 'Internet Bağlantı Hatası', 'Telefonunuzun internet bağlantısı bulunmamaktadır. Lütfen telefonunuzu internete bağlayınız.', (){Navigator.of(context).pop();});
                  }

                  else if(getDistance(double.parse(lat), double.parse(long), double.parse(snapshot.data!.Lat), double.parse(snapshot.data!.Long))<=250.0  && connectivityResult[0] != ConnectivityResult.none) {

                    showAlertDialogWithoutButtonWidget(context,"Ziyaret Başlatılıyor","Ziyaretiniz başlatılıyor, lütfen bekleyiniz.");

                    regionCenterVisitManager.startRegionCenterVisit();
                    box.put("currentCenterName", snapshot.data!.centerName);
                    box.put("currentCenterID", snapshot.data!.centerCode);
                    box.put("visitingStartTime",DateTime.now());
                    await createVisitingDurations(
                      box.get('currentCenterID'),
                      (isBS==true)?userID:null,
                      (isBS==true)?null:userID,
                      box.get("visitingStartTime").toIso8601String(),
                      null,
                      box.get("shiftDate"),
                      null,
                      "${constUrl}api/ZiyaretSureleri"
                    );
                    await countVisitingDurations("${constUrl}api/ZiyaretSureleri");

                    Navigator.of(context).pop(); // Close the dialog
                    naviRegionCenterVisitingMainScreen(context,snapshot.data!.centerCode,snapshot.data!.centerName);
                  }

                  else if (getDistance(double.parse(lat), double.parse(long), double.parse(snapshot.data!.Lat), double.parse(snapshot.data!.Long))>250.0  && connectivityResult[0] != ConnectivityResult.none){
                    showShopDistanceDialog(context);
                  }
                },
                borderWidht: 1,
                backgroundColor: secondaryColor,
                borderColor: secondaryColor,
                textColor: textColor);
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
    );
  }

  Widget stopShiftButton(){
    return ButtonWidget(
        text: "Mesaiyi Bitir",
        heightConst: 0.06,
        widthConst: 0.8,
        size: 18,
        radius: 20,
        fontWeight: FontWeight.w600,
        onTaps: () async{

          var connectivityResult = await (Connectivity().checkConnectivity());

          if(connectivityResult[0] == ConnectivityResult.none){
            showAlertDialogWidget(context, 'Internet Bağlantı Hatası', 'Telefonunuzun internet bağlantısı bulunmamaktadır. Lütfen telefonunuzu internete bağlayınız.', (){Navigator.of(context).pop();});
          }

          else if(connectivityResult[0] != ConnectivityResult.none){

            showAlertDialogWithoutButtonWidget(context,"Mesai Bitiriliyor","Mesainiz bitiriliyor, lütfen bekleyiniz.");

            shiftManager.endShift();
            box.put("finishTime",DateTime.now());
            String workDuration = calculateElapsedTime(box.get("startTime"),box.get("finishTime"));
            updateFinishHourWorkDurationShift(
                box.get("shiftCount"),
                (isBS)?userID:null,
                (isBS)?null:userID,
                "Mesai",
                box.get("shiftDate"),
                box.get("startTime").toIso8601String(),
                box.get("finishTime").toIso8601String(),
                workDuration,
                "${constUrl}api/mesai/${box.get("shiftCount")}"
            );

            Navigator.of(context).pop(); // Close the dialog
            naviStartWorkMainScreen(context);
          }
        },
        borderWidht: 1,
        backgroundColor: redColor,
        borderColor: redColor,
        textColor: textColor);
  }

  showShopDistanceDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialogWidget(
            title: 'Mesafe Kontrolü',
            content: 'Ziyaret etmek istediğiniz merkezin en az 250 metre yakınında olmanız gerekmektedir!',
            onTaps: (){
              naviShiftTypeScreen(context);
            },
          );
        }
    );
  }

}