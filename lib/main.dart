import 'dart:async';
import 'dart:io';
import 'package:deneme/screens/authScreens/loginScreen/loginMainScreen.dart';
import 'package:deneme/screens/navigation/navigationMainScreen.dart';
import 'package:deneme/screens/regionCenterVisiting/regionCenterVisitingMainScreen.dart';
import 'package:deneme/screens/shopVisiting/commonScreens/processesScreen.dart';
import 'package:deneme/screens/startWork/shiftTypeScreen.dart';
import 'package:deneme/screens/startWork/startWorkMainScreen.dart';
import 'package:deneme/screens/warning/versionWarningScreen.dart';
import 'package:deneme/services/versionServices.dart';
import 'package:deneme/utils/appStateManager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants/constants.dart';
import 'models/version.dart';

var appConstants = Hive.box('appConstants');
var stateManagementConstants = Hive.box('stateManagementConstants');
var shopTaskPhotoConstants = Hive.box('shopTaskPhotoConstants');
var visitBox = Hive.box('visitBox');
var versions1;

bool isLoggedIn = false;

var box;
var boxStateManagement;
var boxShopTaskPhoto;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path,backendPreference: HiveStorageBackendPreference.native);
  var hive = await Hive.openBox('appConstants');
  box = hive;

  final appDocumentDir2 = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir2.path,backendPreference: HiveStorageBackendPreference.native);
  var hiveStateManagement = await Hive.openBox<bool>('stateManagementConstants');
  boxStateManagement = hiveStateManagement;

  final appDocumentDir3 = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir3.path,backendPreference: HiveStorageBackendPreference.native);
  var hiveShopTaskPhoto = await Hive.openBox('shopTaskPhotoConstants');
  boxShopTaskPhoto = hiveShopTaskPhoto;

  final appDocumentDir4 = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir4.path,backendPreference: HiveStorageBackendPreference.native);
  var hiveVisitBox = await Hive.openBox('appConstants');
  visitBox = hiveVisitBox;

  final List<Version> versions2 = await fetchVersion2('${constUrl}api/Versiyon');
  versions1 = versions2;

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => Platform.isAndroid==true ? _MyAppState(): _MyAppState2();
}

class _MyAppState extends State<MyApp> {

  late Widget page = versions1[0].version=="1.0.8+11"?StartWorkMainScreen():VersionWarningScreen();
  late Widget page2 = versions1[0].version=="1.0.8+11"?NavigationMainScreen():VersionWarningScreen();
  late Widget page3 = versions1[0].version=="1.0.8+11"?LoginMainScreen():VersionWarningScreen();

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

      if(versions1[0].version=="1.0.8+11" && boxStateManagement.get('isStoreVisit')==true&& isWithinTimeRange && "${int.parse(box.get("shiftDate").split("T")[0].split("-")[2])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[1])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[0])}"==now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString()){
        page = ShopVisitingProcessesScreen(shop_code: box.get('currentShopID'), shopName: box.get('currentShopName'));
      }

      else if(versions1[0].version=="1.0.8+11" && boxStateManagement.get('isRegionCenterVisit')==true&& isWithinTimeRange && "${int.parse(box.get("shiftDate").split("T")[0].split("-")[2])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[1])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[0])}"==now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString()){
        page = RegionCenterVisitingMainScreen(region_code: box.get('currentCenterID'), regionName: box.get('currentCenterName'));
      }

      else if(versions1[0].version=="1.0.8+11" && boxStateManagement.get('isStartShift')==true && isWithinTimeRange && "${int.parse(box.get("shiftDate").split("T")[0].split("-")[2])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[1])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[0])}"==now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString()){
        page = ShiftTypeScreen();
      }

      else if(versions1[0].version=="1.0.8+11" && boxStateManagement.get('isStartShift')==true && isWithinTimeRange2 && "${int.parse(box.get("shiftDate").split("T")[0].split("-")[2])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[1])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[0])}"==now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString()){
        page = StartWorkMainScreen();
        page2 = NavigationMainScreen();
        shiftManager.endShift();
      }
      else if(versions1[0].version=="1.0.8+11" && boxStateManagement.get('isStartShift')==true && "${int.parse(box.get("shiftDate").split("T")[0].split("-")[2])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[1])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[0])}"!=now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString()){
        page = StartWorkMainScreen();
        page2 = NavigationMainScreen();
        shiftManager.endShift();
      }

      else if(versions1[0].version=="1.0.8+11" && boxStateManagement.get('isStoreVisit')==true && isWithinTimeRange2 && "${int.parse(box.get("shiftDate").split("T")[0].split("-")[2])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[1])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[0])}"==now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString()){
        page = StartWorkMainScreen();
        page2 = NavigationMainScreen();
        storeVisitManager.endStoreVisit();
      }
      else if(versions1[0].version=="1.0.8+11" && boxStateManagement.get('isStoreVisit')==true && "${int.parse(box.get("shiftDate").split("T")[0].split("-")[2])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[1])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[0])}"!=now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString()){
        page = StartWorkMainScreen();
        page2 = NavigationMainScreen();
        storeVisitManager.endStoreVisit();
      }

      else if(versions1[0].version=="1.0.8+11" && boxStateManagement.get('isRegionCenterVisit')==true && isWithinTimeRange2 && "${int.parse(box.get("shiftDate").split("T")[0].split("-")[2])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[1])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[0])}"==now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString()){
        page = StartWorkMainScreen();
        page2 = NavigationMainScreen();
        regionCenterVisitManager.endRegionCenterVisit();
      }
      else if(versions1[0].version=="1.0.8+11" && boxStateManagement.get('isRegionCenterVisit')==true && "${int.parse(box.get("shiftDate").split("T")[0].split("-")[2])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[1])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[0])}"!=now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString()){
        page = StartWorkMainScreen();
        page2 = NavigationMainScreen();
        regionCenterVisitManager.endRegionCenterVisit();
      }

      else if(versions1[0].version!="1.0.8+11"){
        page = VersionWarningScreen();
        page2 = VersionWarningScreen();
      }
    }

    pageCondition();

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: (isLoggedIn)? (isBSorPM?page:page2) : page3,
    );
  }
}

class _MyAppState2 extends State<MyApp> {

  late Widget page = versions1[1].version=="1.0.8+14"?StartWorkMainScreen():VersionWarningScreen();
  late Widget page2 = versions1[1].version=="1.0.8+14"?NavigationMainScreen():VersionWarningScreen();
  late Widget page3 = versions1[1].version=="1.0.8+14"?LoginMainScreen():VersionWarningScreen();

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

      if(versions1[1].version=="1.0.8+14" && boxStateManagement.get('isStoreVisit')==true&& isWithinTimeRange && "${int.parse(box.get("shiftDate").split("T")[0].split("-")[2])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[1])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[0])}"==now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString()){
        page = ShopVisitingProcessesScreen(shop_code: box.get('currentShopID'), shopName: box.get('currentShopName'));
      }

      else if(versions1[1].version=="1.0.8+14" && boxStateManagement.get('isRegionCenterVisit')==true&& isWithinTimeRange && "${int.parse(box.get("shiftDate").split("T")[0].split("-")[2])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[1])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[0])}"==now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString()){
        page = RegionCenterVisitingMainScreen(region_code: box.get('currentCenterID'), regionName: box.get('currentCenterName'));
      }

      else if(versions1[1].version=="1.0.8+14" && boxStateManagement.get('isStartShift')==true && isWithinTimeRange && "${int.parse(box.get("shiftDate").split("T")[0].split("-")[2])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[1])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[0])}"==now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString()){
        page = ShiftTypeScreen();
      }

      else if(versions1[1].version=="1.0.8+14" && boxStateManagement.get('isStartShift')==true && isWithinTimeRange2 && "${int.parse(box.get("shiftDate").split("T")[0].split("-")[2])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[1])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[0])}"==now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString()){
        page = StartWorkMainScreen();
        page2 = NavigationMainScreen();
        shiftManager.endShift();
      }
      else if(versions1[1].version=="1.0.8+14" && boxStateManagement.get('isStartShift')==true && "${int.parse(box.get("shiftDate").split("T")[0].split("-")[2])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[1])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[0])}"!=now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString()){
        page = StartWorkMainScreen();
        page2 = NavigationMainScreen();
        shiftManager.endShift();
      }

      else if(versions1[1].version=="1.0.8+14" && boxStateManagement.get('isStoreVisit')==true && isWithinTimeRange2 && "${int.parse(box.get("shiftDate").split("T")[0].split("-")[2])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[1])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[0])}"==now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString()){
        page = StartWorkMainScreen();
        page2 = NavigationMainScreen();
        storeVisitManager.endStoreVisit();
      }
      else if(versions1[1].version=="1.0.8+14" && boxStateManagement.get('isStoreVisit')==true && "${int.parse(box.get("shiftDate").split("T")[0].split("-")[2])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[1])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[0])}"!=now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString()){
        page = StartWorkMainScreen();
        page2 = NavigationMainScreen();
        storeVisitManager.endStoreVisit();
      }

      else if(versions1[1].version=="1.0.8+14" && boxStateManagement.get('isRegionCenterVisit')==true && isWithinTimeRange2 && "${int.parse(box.get("shiftDate").split("T")[0].split("-")[2])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[1])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[0])}"==now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString()){
        page = StartWorkMainScreen();
        page2 = NavigationMainScreen();
        regionCenterVisitManager.endRegionCenterVisit();
      }
      else if(versions1[1].version=="1.0.8+14" && boxStateManagement.get('isRegionCenterVisit')==true && "${int.parse(box.get("shiftDate").split("T")[0].split("-")[2])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[1])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[0])}"!=now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString()){
        page = StartWorkMainScreen();
        page2 = NavigationMainScreen();
        regionCenterVisitManager.endRegionCenterVisit();
      }

      else if(versions1[1].version!="1.0.8+14"){
        page = VersionWarningScreen();
        page2 = VersionWarningScreen();
      }
    }

    pageCondition();

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: (isLoggedIn)? (isBSorPM?page:page2) : page3,
    );
  }
}

// ----------------------------------------------------------------------

