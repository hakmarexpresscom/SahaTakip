import 'dart:async';
import 'package:deneme/screens/authScreens/loginScreen/loginMainScreen.dart';
import 'package:deneme/screens/externalTask/externalTaskMainScreen.dart';
import 'package:deneme/screens/navigation/navigationMainScreen.dart';
import 'package:deneme/screens/shopVisiting/commonScreens/processesScreen.dart';
import 'package:deneme/screens/shopVisiting/commonScreens/shopVisitingMainScreen.dart';
import 'package:deneme/screens/startWork/startWorkMainScreen.dart';
import 'package:deneme/screens/warning/warningScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants/constants.dart';

var appConstants = Hive.box('appConstants');
var stateManagementConstants = Hive.box('stateManagementConstants');
var shopTaskPhotoConstants = Hive.box('shopTaskPhotoConstants');

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

  DateTime now = DateTime.now();

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

      if(boxStateManagement.get('isStoreVisit')==true){
        page = ShopVisitingProcessesScreen(shop_code: box.get('currentShopID'), shopName: box.get('currentShopName'));
      }

      else if(boxStateManagement.get('isStartShopVisitWork')==true && isWithinTimeRange && box.get("shiftDate")==now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString()){
        page = ShopVisitingMainScreen();
      }

      else if(boxStateManagement.get('isStartExternalTaskWork')==true && isWithinTimeRange && box.get("shiftDate")==now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString()){
        page = ExternalTaskMainScreen();
      }

      else if(boxStateManagement.get('isStartShopVisitWork')==true && isWithinTimeRange2 && box.get("shiftDate")==now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString()){
        page = WarningScreen();
      }
      else if(boxStateManagement.get('isStartShopVisitWork')==true && box.get("shiftDate")!=now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString()){
        page = WarningScreen();
      }

      else if(boxStateManagement.get('isStoreVisit')==true && isWithinTimeRange2 && box.get("shiftDate")==now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString()){
        page = WarningScreen();
      }
      else if(boxStateManagement.get('isStoreVisit')==true && box.get("shiftDate")!=now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString()){
        page = WarningScreen();
      }

      else if(boxStateManagement.get('isStartExternalTaskWork')==true && isWithinTimeRange2 && box.get("shiftDate")==now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString()){
        page = WarningScreen();
      }
      else if(boxStateManagement.get('isStartExternalTaskWork')==true && box.get("shiftDate")!=now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString()){
        page = WarningScreen();
      }
    }

    pageCondition();

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: (isLoggedIn)? (isBSorPM?page:page2) : LoginMainScreen(),
    );
  }
}

// ----------------------------------------------------------------------

