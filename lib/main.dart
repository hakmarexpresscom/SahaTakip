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
var visitTimer = Hive.box('visitTimer');
var shopVisitingPhoto = Hive.box('shopVisitingPhoto');
var shopVisitingForms = Hive.box('shopVisitingForms');
var versions1;
var internetConnection;

bool isLoggedIn = false;

var box;
var boxStateManagement;
var boxShopTaskPhoto;
var boxVisitTimer;
var boxshopVisitingPhoto;
var boxShopVisitingForms;

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  var connectivityResult = await (Connectivity().checkConnectivity());
  internetConnection = connectivityResult;

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
  var hiveVisitTimer = await Hive.openBox('visitTimer');
  boxVisitTimer = hiveVisitTimer;

  final appDocumentDir5 = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir5.path,backendPreference: HiveStorageBackendPreference.native);
  var hiveShopVisitingPhoto = await Hive.openBox('shopVisitingPhoto');
  boxshopVisitingPhoto = hiveShopVisitingPhoto;

  final appDocumentDir6 = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir6.path,backendPreference: HiveStorageBackendPreference.native);
  var hiveShopVisitingForms = await Hive.openBox('shopVisitingForms');
  boxShopVisitingForms = hiveShopVisitingForms;

  if(internetConnection[0] != ConnectivityResult.none){
    final List<Version> versions2 = await fetchVersion2('${constUrl}api/Versiyon');
    versions1 = versions2;
  }

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => Platform.isAndroid==true ? _MyAppState(): _MyAppState2();
}

class _MyAppState extends State<MyApp> {

  late Widget page = StartWorkMainScreen();
  late Widget page2 = NavigationMainScreen();
  late Widget page3 = LoginMainScreen();

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

      if(internetConnection[0] == ConnectivityResult.none){
        page = InternetWarningScreen();
        page2 = InternetWarningScreen();
        page3 = InternetWarningScreen();
      }


      else if(116<int.parse((versions1[0].version)[0]+(versions1[0].version)[2]+(versions1[0].version)[4])){
        page = VersionWarningScreen();
        page2 = VersionWarningScreen();
        page3 = VersionWarningScreen();
      }


      else if(116>=int.parse((versions1[0].version)[0]+(versions1[0].version)[2]+(versions1[0].version)[4]) && boxStateManagement.get('isStoreVisit')==true&& isWithinTimeRange && "${int.parse(box.get("shiftDate").split("T")[0].split("-")[2])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[1])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[0])}"==now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString()){
        if(box.get("groupNo")==0){
          page = ShopVisitingProcessesScreenSatisOperasyon(shop_code: box.get('currentShopID'), shopName: box.get('currentShopName'));
        }
        else if(box.get("groupNo")==1){
          page = (boxStateManagement.get('isBefore')==true)?ShopVisitingProcessesScreenManav(shop_code: box.get('currentShopID'), shopName: box.get('currentShopName')):ShopVisitingBeforeAfterPhotoScreen(isBefore: true);
        }
        else if(box.get("groupNo")==2){
          page = ShopVisitingProcessesScreenUnkar(shop_code: box.get('currentShopID'), shopName: box.get('currentShopName'));
        }
        else if(box.get("groupNo")==3){
          page = ShopVisitingProcessesScreenTedarikZinciri(shop_code: box.get('currentShopID'), shopName: box.get('currentShopName'));
        }
      }


      else if(116>=int.parse((versions1[0].version)[0]+(versions1[0].version)[2]+(versions1[0].version)[4]) && boxStateManagement.get('isStoreVisit')==false && boxStateManagement.get('isBefore')==true && boxStateManagement.get('isAfter')==false && isWithinTimeRange && "${int.parse(box.get("shiftDate").split("T")[0].split("-")[2])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[1])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[0])}"==now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString()){
        if(box.get("groupNo")==0){
          page = ShopVisitingProcessesScreenSatisOperasyon(shop_code: box.get('currentShopID'), shopName: box.get('currentShopName'));
        }
        else if(box.get("groupNo")==1){
          page = ShopVisitingBeforeAfterPhotoScreen(isBefore: false);
        }
        else if(box.get("groupNo")==2){
          page = ShopVisitingProcessesScreenUnkar(shop_code: box.get('currentShopID'), shopName: box.get('currentShopName'));
        }
        else if(box.get("groupNo")==3){
          page = ShopVisitingProcessesScreenTedarikZinciri(shop_code: box.get('currentShopID'), shopName: box.get('currentShopName'));
        }
      }


      else if(116>=int.parse((versions1[0].version)[0]+(versions1[0].version)[2]+(versions1[0].version)[4]) && boxStateManagement.get('isRegionCenterVisit')==true&& isWithinTimeRange && "${int.parse(box.get("shiftDate").split("T")[0].split("-")[2])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[1])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[0])}"==now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString()){
        if(box.get("groupNo")==0){
          page = RegionCenterVisitingProcessesScreenSatisOperasyon(region_code: box.get('currentCenterID'), regionName: box.get('currentCenterName'));
        }
        else if(box.get("groupNo")==1){
          page = RegionCenterVisitingProcessesScreenManav(region_code: box.get('currentCenterID'), regionName: box.get('currentCenterName'));
        }
        else if(box.get("groupNo")==2){
          page = RegionCenterVisitingProcessesScreenUnkar(region_code: box.get('currentCenterID'), regionName: box.get('currentCenterName'));
        }
        else if(box.get("groupNo")==3){
          page = RegionCenterVisitingProcessesScreenTedarikZinciri(region_code: box.get('currentCenterID'), regionName: box.get('currentCenterName'));
        }
      }


      else if(116>=int.parse((versions1[0].version)[0]+(versions1[0].version)[2]+(versions1[0].version)[4]) && boxStateManagement.get('isStartShift')==true && isWithinTimeRange && "${int.parse(box.get("shiftDate").split("T")[0].split("-")[2])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[1])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[0])}"==now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString()){
        page = ShiftTypeScreen();
      }


      else if(116>=int.parse((versions1[0].version)[0]+(versions1[0].version)[2]+(versions1[0].version)[4]) && boxStateManagement.get('isStartShift')==true && isWithinTimeRange2 && "${int.parse(box.get("shiftDate").split("T")[0].split("-")[2])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[1])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[0])}"==now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString()){
        page = StartWorkMainScreen();
        shiftManager.endShift();
      }
      else if(116>=int.parse((versions1[0].version)[0]+(versions1[0].version)[2]+(versions1[0].version)[4]) && boxStateManagement.get('isStartShift')==true && "${int.parse(box.get("shiftDate").split("T")[0].split("-")[2])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[1])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[0])}"!=now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString()){
        page = StartWorkMainScreen();
        shiftManager.endShift();
      }


      else if(116>=int.parse((versions1[0].version)[0]+(versions1[0].version)[2]+(versions1[0].version)[4]) && boxStateManagement.get('isStoreVisit')==true && isWithinTimeRange2 && "${int.parse(box.get("shiftDate").split("T")[0].split("-")[2])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[1])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[0])}"==now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString()){
        page = StartWorkMainScreen();
        storeVisitManager.endStoreVisit();
      }
      else if(116>=int.parse((versions1[0].version)[0]+(versions1[0].version)[2]+(versions1[0].version)[4]) && boxStateManagement.get('isStoreVisit')==true && "${int.parse(box.get("shiftDate").split("T")[0].split("-")[2])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[1])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[0])}"!=now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString()){
        page = StartWorkMainScreen();
        storeVisitManager.endStoreVisit();
      }


      else if(116>=int.parse((versions1[0].version)[0]+(versions1[0].version)[2]+(versions1[0].version)[4]) && boxStateManagement.get('isRegionCenterVisit')==true && isWithinTimeRange2 && "${int.parse(box.get("shiftDate").split("T")[0].split("-")[2])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[1])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[0])}"==now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString()){
        page = StartWorkMainScreen();
        regionCenterVisitManager.endRegionCenterVisit();
      }
      else if(116>=int.parse((versions1[0].version)[0]+(versions1[0].version)[2]+(versions1[0].version)[4]) && boxStateManagement.get('isRegionCenterVisit')==true && "${int.parse(box.get("shiftDate").split("T")[0].split("-")[2])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[1])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[0])}"!=now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString()){
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

class _MyAppState2 extends State<MyApp> {

  late Widget page = StartWorkMainScreen();
  late Widget page2 = NavigationMainScreen();
  late Widget page3 = LoginMainScreen();

  DateTime now = DateTime.now();

  final ShiftManager shiftManager = Get.put(ShiftManager());
  final StoreVisitManager storeVisitManager = Get.put(StoreVisitManager());
  final RegionCenterVisitManager regionCenterVisitManager = Get.put(RegionCenterVisitManager());
  final PhotoManager1 photoManager1 = Get.put(PhotoManager1());
  final PhotoManager2 photoManager2 = Get.put(PhotoManager2());

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

      if(internetConnection[0] == ConnectivityResult.none){
        page = InternetWarningScreen();
        page2 = InternetWarningScreen();
        page3 = InternetWarningScreen();
      }

      else if(114<int.parse((versions1[1].version)[0]+(versions1[1].version)[2]+(versions1[1].version)[4])){
        page = VersionWarningScreen();
        page2 = VersionWarningScreen();
        page3 = VersionWarningScreen();
      }

      else if(114>=int.parse((versions1[1].version)[0]+(versions1[1].version)[2]+(versions1[1].version)[4]) && boxStateManagement.get('isStoreVisit')==true&& isWithinTimeRange && "${int.parse(box.get("shiftDate").split("T")[0].split("-")[2])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[1])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[0])}"==now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString()){
        if(box.get("groupNo")==0){
          page = ShopVisitingProcessesScreenSatisOperasyon(shop_code: box.get('currentShopID'), shopName: box.get('currentShopName'));
        }
        else if(box.get("groupNo")==1){
          page = (boxStateManagement.get('isBefore')==true)?ShopVisitingProcessesScreenManav(shop_code: box.get('currentShopID'), shopName: box.get('currentShopName')):ShopVisitingBeforeAfterPhotoScreen(isBefore: true);
        }
        else if(box.get("groupNo")==2){
          page = ShopVisitingProcessesScreenUnkar(shop_code: box.get('currentShopID'), shopName: box.get('currentShopName'));
        }
        else if(box.get("groupNo")==3){
          page = ShopVisitingProcessesScreenTedarikZinciri(shop_code: box.get('currentShopID'), shopName: box.get('currentShopName'));
        }
      }


      else if(114>=int.parse((versions1[1].version)[0]+(versions1[1].version)[2]+(versions1[1].version)[4]) && boxStateManagement.get('isStoreVisit')==false && boxStateManagement.get('isBefore')==true && boxStateManagement.get('isAfter')==false && isWithinTimeRange && "${int.parse(box.get("shiftDate").split("T")[0].split("-")[2])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[1])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[0])}"==now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString()){
        if(box.get("groupNo")==0){
          page = ShopVisitingProcessesScreenSatisOperasyon(shop_code: box.get('currentShopID'), shopName: box.get('currentShopName'));
        }
        else if(box.get("groupNo")==1){
          page = ShopVisitingBeforeAfterPhotoScreen(isBefore: false);
        }
        else if(box.get("groupNo")==2){
          page = ShopVisitingProcessesScreenUnkar(shop_code: box.get('currentShopID'), shopName: box.get('currentShopName'));
        }
        else if(box.get("groupNo")==3){
          page = ShopVisitingProcessesScreenTedarikZinciri(shop_code: box.get('currentShopID'), shopName: box.get('currentShopName'));
        }
      }


      else if(114>=int.parse((versions1[1].version)[0]+(versions1[1].version)[2]+(versions1[1].version)[4]) && boxStateManagement.get('isRegionCenterVisit')==true&& isWithinTimeRange && "${int.parse(box.get("shiftDate").split("T")[0].split("-")[2])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[1])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[0])}"==now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString()){
        if(box.get("groupNo")==0){
          page = RegionCenterVisitingProcessesScreenSatisOperasyon(region_code: box.get('currentCenterID'), regionName: box.get('currentCenterName'));
        }
        else if(box.get("groupNo")==1){
          page = RegionCenterVisitingProcessesScreenManav(region_code: box.get('currentCenterID'), regionName: box.get('currentCenterName'));
        }
        else if(box.get("groupNo")==2){
          page = RegionCenterVisitingProcessesScreenUnkar(region_code: box.get('currentCenterID'), regionName: box.get('currentCenterName'));
        }
        else if(box.get("groupNo")==3){
          page = RegionCenterVisitingProcessesScreenTedarikZinciri(region_code: box.get('currentCenterID'), regionName: box.get('currentCenterName'));
        }
      }


      else if(114>=int.parse((versions1[1].version)[0]+(versions1[1].version)[2]+(versions1[1].version)[4]) && boxStateManagement.get('isStartShift')==true && isWithinTimeRange && "${int.parse(box.get("shiftDate").split("T")[0].split("-")[2])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[1])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[0])}"==now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString()){
        page = ShiftTypeScreen();
      }


      else if(114>=int.parse((versions1[1].version)[0]+(versions1[1].version)[2]+(versions1[1].version)[4]) && boxStateManagement.get('isStartShift')==true && isWithinTimeRange2 && "${int.parse(box.get("shiftDate").split("T")[0].split("-")[2])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[1])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[0])}"==now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString()){
        page = StartWorkMainScreen();
        shiftManager.endShift();
      }
      else if(114>=int.parse((versions1[1].version)[0]+(versions1[1].version)[2]+(versions1[1].version)[4]) && boxStateManagement.get('isStartShift')==true && "${int.parse(box.get("shiftDate").split("T")[0].split("-")[2])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[1])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[0])}"!=now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString()){
        page = StartWorkMainScreen();
        shiftManager.endShift();
      }


      else if(114>=int.parse((versions1[1].version)[0]+(versions1[1].version)[2]+(versions1[1].version)[4]) && boxStateManagement.get('isStoreVisit')==true && isWithinTimeRange2 && "${int.parse(box.get("shiftDate").split("T")[0].split("-")[2])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[1])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[0])}"==now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString()){
        page = StartWorkMainScreen();
        storeVisitManager.endStoreVisit();
      }
      else if(114>=int.parse((versions1[1].version)[0]+(versions1[1].version)[2]+(versions1[1].version)[4]) && boxStateManagement.get('isStoreVisit')==true && "${int.parse(box.get("shiftDate").split("T")[0].split("-")[2])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[1])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[0])}"!=now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString()){
        page = StartWorkMainScreen();
        storeVisitManager.endStoreVisit();
      }


      else if(114>=int.parse((versions1[1].version)[0]+(versions1[1].version)[2]+(versions1[1].version)[4]) && boxStateManagement.get('isRegionCenterVisit')==true && isWithinTimeRange2 && "${int.parse(box.get("shiftDate").split("T")[0].split("-")[2])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[1])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[0])}"==now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString()){
        page = StartWorkMainScreen();
        regionCenterVisitManager.endRegionCenterVisit();
      }
      else if(114>=int.parse((versions1[1].version)[0]+(versions1[1].version)[2]+(versions1[1].version)[4]) && boxStateManagement.get('isRegionCenterVisit')==true && "${int.parse(box.get("shiftDate").split("T")[0].split("-")[2])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[1])}-${int.parse(box.get("shiftDate").split("T")[0].split("-")[0])}"!=now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString()){
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

// ----------------------------------------------------------------------

