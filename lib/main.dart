import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:deneme/screens/authScreens/loginScreen/loginMainScreen.dart';
import 'package:deneme/screens/navigation/navigationMainScreen.dart';
import 'package:deneme/screens/photoScreen/shopVisitingBeforeAfterPhotoScreen.dart';
import 'package:deneme/screens/regionCenterVisiting/manav/regionCenterVisitingProcessesScreenManav.dart';
import 'package:deneme/screens/regionCenterVisiting/satisOperasyon/regionCenterVisitingProcessesScreenSatisOperasyon.dart';
import 'package:deneme/screens/regionCenterVisiting/tedarikZinciri/regionCenterVisitingProcessesScreenTedarikZinciri.dart';
import 'package:deneme/screens/regionCenterVisiting/unkar/regionCenterVisitingProcessesScreenUnkar.dart';
import 'package:deneme/screens/shopVisiting/manav/shopVisitingProcessesScreenManav.dart';
import 'package:deneme/screens/shopVisiting/satisOperasyon/shopVisitingProcessesScreenSatisOperasyon.dart';
import 'package:deneme/screens/shopVisiting/tedarikZinciri/shopVisitingProcessesScreenTedarikZinciri.dart';
import 'package:deneme/screens/shopVisiting/unkar/shopVisitingProcessesScreenUnkar.dart';
import 'package:deneme/screens/startWork/shiftTypeScreen.dart';
import 'package:deneme/screens/startWork/startWorkMainScreen.dart';
import 'package:deneme/screens/warning/internetWarningScreen.dart';
import 'package:deneme/screens/warning/versionWarningScreen.dart';
import 'package:deneme/services/versionServices.dart';
import 'package:deneme/utils/appStateManager.dart';
import 'package:deneme/utils/checkAndUpdateShopVisitingFormData.dart';
import 'package:deneme/utils/generalFunctions.dart';
import 'package:deneme/utils/isFirstLaunchAfterUpdate.dart';
import 'package:deneme/utils/isFirstLoginToday.dart';
import 'package:deneme/utils/synchronizationBoxData.dart';
import 'package:deneme/widgets/alert_dialog_without_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants/constants.dart';
import 'models/version.dart';

late Box box;
late Box boxStateManagement;
late Box boxShopTaskPhoto;
late Box boxVisitTimer;
late Box boxshopVisitingPhoto;
late Box boxShopVisitingForms;
late Box boxBSSatisOperasyonShopVisitingFormShops;
late Box boxPMSatisOperasyonShopVisitingFormShops;

var internetConnection;
List<NewVersion> versions1 = [];
bool isLoggedIn = false;

Future<void> initHiveBoxes() async {
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path, backendPreference: HiveStorageBackendPreference.native);

  box = await Hive.openBox('appConstants');
  boxStateManagement = await Hive.openBox('stateManagementConstants');
  boxShopTaskPhoto = await Hive.openBox('shopTaskPhotoConstants');
  boxVisitTimer = await Hive.openBox('visitTimer');
  boxshopVisitingPhoto = await Hive.openBox('shopVisitingPhoto');
  boxShopVisitingForms = await Hive.openBox('shopVisitingForms');
  boxBSSatisOperasyonShopVisitingFormShops = await Hive.openBox('BSSatisOperasyonShopVisitingFormShops');
  boxPMSatisOperasyonShopVisitingFormShops = await Hive.openBox('PMSatisOperasyonShopVisitingFormShops');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHiveBoxes();

  internetConnection = await Connectivity().checkConnectivity();

  if (internetConnection != ConnectivityResult.none) {
    versions1 = await fetchVersion2('${constUrl}api/NewVersion');
  }

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  late Widget page = StartWorkMainScreen();
  late Widget page2 = NavigationMainScreen();
  late Widget page3 = LoginMainScreen();

  bool isSyncingData = false;

  DateTime now = DateTime.now();

  final ShiftManager shiftManager = Get.put(ShiftManager());
  final StoreVisitManager storeVisitManager = Get.put(StoreVisitManager());
  final RegionCenterVisitManager regionCenterVisitManager = Get.put(RegionCenterVisitManager());

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final loggedIn = prefs.getBool('isLoggedIn') ?? false;
    setState(() {
      isLoggedIn = loggedIn;
    });
    if (isLoggedIn) {
      checkFirstLoginAndSyncData();
    }
  }

  Future<void> checkFirstLoginAndSyncData() async {
    bool isFirstLogin = await isFirstLoginToday();
    bool isFirstLogin2 = await isFirstLaunchAfterUpdate();

    if (isFirstLogin || isFirstLogin2) {

      WidgetsBinding.instance.addPostFrameCallback((_) {

        showDialog(
          context: Get.context!,
          barrierDismissible: false,
          builder: (context) => AlertDialogWithoutButtonWidget(
            title: "Verileriniz senkronize ediliyor",
            content: "Lütfen bekleyiniz...",
          ),
        );
      });

      await synchronizationBoxData(box.get("user"),box.get("groupNo"));
      if(box.get("groupNo")==0){
        await checkAndUpdateVisitingFormData(isBS);
      }

      if (Navigator.canPop(Get.context!)) {
        Navigator.of(Get.context!).pop();
      }
    }
  }


  @override
  Widget build(BuildContext context) {

    void pageCondition(){
      DateTime startTime = DateTime(now.year, now.month, now.day, 8, 30);
      DateTime endTime = DateTime(now.year, now.month, now.day, 18, 30);

      bool isWithinTimeRange = now.isAfter(startTime) && now.isBefore(endTime);

      DateTime startTime2 = DateTime(now.year, now.month, now.day, 18, 31);
      DateTime endTime2 = DateTime(now.year, now.month, now.day, 23, 59);

      bool isWithinTimeRange2 = now.isAfter(startTime2) && now.isBefore(endTime2);

      String versionListRaw = Platform.isAndroid==true ? versions1[0].versiyon_list: versions1[1].versiyon_list;

      List<int> versionList = versionListRaw.split(',').where((e) => e.isNotEmpty).map(int.parse).toList();


      if(internetConnection[0] == ConnectivityResult.none){
        page = InternetWarningScreen();
        page2 = InternetWarningScreen();
        page3 = InternetWarningScreen();
      }


      else if(versionList.contains(122) == false){
        page = VersionWarningScreen();
        page2 = VersionWarningScreen();
        page3 = VersionWarningScreen();
      }


      else if(versionList.contains(122) && boxStateManagement.get('isStoreVisit')==true&& isWithinTimeRange && "${int.parse(box.get("shiftDate").split("T")[0].split("-")[2])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[1])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[0])}"==now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString()){
        if(box.get("groupNo")==0){
          page = ShopVisitingProcessesScreenSatisOperasyon(shop_code: box.get('currentShopID'), shop_name: box.get('currentShopName'));
        }
        else if(box.get("groupNo")==1){
          page = (boxStateManagement.get('isBefore')==true)?ShopVisitingProcessesScreenManav(shop_code: box.get('currentShopID'), shop_name: box.get('currentShopName')):ShopVisitingBeforeAfterPhotoScreen(isBefore: true);
        }
        else if(box.get("groupNo")==2){
          page = ShopVisitingProcessesScreenUnkar(shop_code: box.get('currentShopID'), shop_name: box.get('currentShopName'));
        }
        else if(box.get("groupNo")==3){
          page = ShopVisitingProcessesScreenTedarikZinciri(shop_code: box.get('currentShopID'), shop_name: box.get('currentShopName'));
        }
      }


      else if(versionList.contains(122) && boxStateManagement.get('isStoreVisit')==false && boxStateManagement.get('isBefore')==true && boxStateManagement.get('isAfter')==false && isWithinTimeRange && "${int.parse(box.get("shiftDate").split("T")[0].split("-")[2])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[1])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[0])}"==now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString()){
        if(box.get("groupNo")==0){
          page = ShopVisitingProcessesScreenSatisOperasyon(shop_code: box.get('currentShopID'), shop_name: box.get('currentShopName'));
        }
        else if(box.get("groupNo")==1){
          page = ShopVisitingBeforeAfterPhotoScreen(isBefore: false);
        }
        else if(box.get("groupNo")==2){
          page = ShopVisitingProcessesScreenUnkar(shop_code: box.get('currentShopID'), shop_name: box.get('currentShopName'));
        }
        else if(box.get("groupNo")==3){
          page = ShopVisitingProcessesScreenTedarikZinciri(shop_code: box.get('currentShopID'), shop_name: box.get('currentShopName'));
        }
      }


      else if(versionList.contains(122) && boxStateManagement.get('isRegionCenterVisit')==true&& isWithinTimeRange && "${int.parse(box.get("shiftDate").split("T")[0].split("-")[2])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[1])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[0])}"==now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString()){
        if(box.get("groupNo")==0){
          page = RegionCenterVisitingProcessesScreenSatisOperasyon(region_code: box.get('currentCenterID'), region_name: box.get('currentCenterName'));
        }
        else if(box.get("groupNo")==1){
          page = RegionCenterVisitingProcessesScreenManav(region_code: box.get('currentCenterID'), region_name: box.get('currentCenterName'));
        }
        else if(box.get("groupNo")==2){
          page = RegionCenterVisitingProcessesScreenUnkar(region_code: box.get('currentCenterID'), region_name: box.get('currentCenterName'));
        }
        else if(box.get("groupNo")==3){
          page = RegionCenterVisitingProcessesScreenTedarikZinciri(region_code: box.get('currentCenterID'), region_name: box.get('currentCenterName'));
        }
      }


      else if(versionList.contains(122) && boxStateManagement.get('isStartShift')==true && isWithinTimeRange && "${int.parse(box.get("shiftDate").split("T")[0].split("-")[2])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[1])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[0])}"==now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString()){
        page = ShiftTypeScreen();
      }


      else if(versionList.contains(122) && boxStateManagement.get('isStartShift')==true && isWithinTimeRange2 && "${int.parse(box.get("shiftDate").split("T")[0].split("-")[2])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[1])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[0])}"==now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString()){
        page = StartWorkMainScreen();
        shiftManager.endShift();
      }
      else if(versionList.contains(122) && boxStateManagement.get('isStartShift')==true && "${int.parse(box.get("shiftDate").split("T")[0].split("-")[2])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[1])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[0])}"!=now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString()){
        page = StartWorkMainScreen();
        shiftManager.endShift();
      }


      else if(versionList.contains(122) && boxStateManagement.get('isStoreVisit')==true && boxStateManagement.get('isStoreVisit2')==false && isWithinTimeRange2 && "${int.parse(box.get("shiftDate").split("T")[0].split("-")[2])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[1])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[0])}"==now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString()){
        page = StartWorkMainScreen();
        storeVisitManager.endStoreVisit();
      }
      else if(versionList.contains(122) && boxStateManagement.get('isStoreVisit')==true && boxStateManagement.get('isStoreVisit2')==false && "${int.parse(box.get("shiftDate").split("T")[0].split("-")[2])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[1])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[0])}"!=now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString()){
        page = StartWorkMainScreen();
        storeVisitManager.endStoreVisit();
      }


      else if(versionList.contains(122) && boxStateManagement.get('isStoreVisit')==false && boxStateManagement.get('isStoreVisit2')==true && isWithinTimeRange2 && "${int.parse(DateTime(now.year, now.month, now.day, 21, 0, 0,).toIso8601String().split("T")[0].split("-")[2])}-${int.parse(DateTime(now.year, now.month, now.day, 21, 0, 0,).toIso8601String().split("T")[0].split("-")[1])}-${int.parse(DateTime(now.year, now.month, now.day, 21, 0, 0,).toIso8601String().split("T")[0].split("-")[0])}"==now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString()){
        if(box.get("groupNo")==0){
          page = ShopVisitingProcessesScreenSatisOperasyon(shop_code: box.get('currentShopID'), shop_name: box.get('currentShopName'));
        }
      }
      else if(versionList.contains(122) && boxStateManagement.get('isStoreVisit')==false && boxStateManagement.get('isStoreVisit2')==true && "${int.parse(DateTime(now.year, now.month, now.day, 21, 0, 0,).toIso8601String().split("T")[0].split("-")[2])}-${int.parse(DateTime(now.year, now.month, now.day, 21, 0, 0,).toIso8601String().split("T")[0].split("-")[1])}-${int.parse(DateTime(now.year, now.month, now.day, 21, 0, 0,).toIso8601String().split("T")[0].split("-")[0])}"!=now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString()){
        if(box.get("groupNo")==0){
          page = ShopVisitingProcessesScreenSatisOperasyon(shop_code: box.get('currentShopID'), shop_name: box.get('currentShopName'));
        }
      }


      else if(versionList.contains(122) && boxStateManagement.get('isRegionCenterVisit')==true && isWithinTimeRange2 && "${int.parse(box.get("shiftDate").split("T")[0].split("-")[2])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[1])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[0])}"==now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString()){
        page = StartWorkMainScreen();
        regionCenterVisitManager.endRegionCenterVisit();
      }
      else if(versionList.contains(122) && boxStateManagement.get('isRegionCenterVisit')==true && "${int.parse(box.get("shiftDate").split("T")[0].split("-")[2])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[1])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[0])}"!=now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString()){
        page = StartWorkMainScreen();
        regionCenterVisitManager.endRegionCenterVisit();
      }
    }

    pageCondition();

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: (isLoggedIn)? (isBSorPM?page:page2) : page3,
    );
  }
}