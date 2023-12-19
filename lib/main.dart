import 'dart:async';
import 'package:deneme/screens/authScreens/loginScreen/loginMainScreen.dart';
import 'package:deneme/screens/externalTask/externalTaskMainScreen.dart';
import 'package:deneme/screens/shopVisiting/commonScreens/processesScreen.dart';
import 'package:deneme/screens/shopVisiting/commonScreens/shopVisitingMainScreen.dart';
import 'package:deneme/screens/shopVisiting/commonScreens/shopsScreen.dart';
import 'package:deneme/screens/shopVisiting/commonScreens/shopsScreenPM.dart';
import 'package:deneme/screens/startWork/startWorkMainScreen.dart';
import 'package:deneme/utils/appStateManager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants/constants.dart';

var appConstants = Hive.box('appConstants');
var stateManagementConstants = Hive.box('stateManagementConstants');

bool isLoggedIn = false;

var box;
var boxStateManagement;

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

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  late Widget page = StartWorkMainScreen();

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final loggedIn = prefs.getBool('isLoggedIn') ?? false;
    /*final hour = prefs.getInt('workHour') ?? 0;
    final minute = prefs.getInt('workMinute') ?? 0;*/
    setState(() {
      isLoggedIn = loggedIn;
      /*workHour = hour;
      workMinute = minute;*/
    });
  }

  @override
  Widget build(BuildContext context) {

    void pageCondition(){
      if(boxStateManagement.get('isStoreVisit')){
        page = ShopVisitingProcessesScreen(shop_code: box.get('currentShopID'), shopName: box.get('currentShopName'));
      }
      else if(boxStateManagement.get('isStartShopVisitWork')){
        page = ShopVisitingMainScreen();
      }
      else if(boxStateManagement.get('isStartExternalTaskWork')){
        page = ExternalTaskMainScreen();
      }
    }

    pageCondition();

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: (isLoggedIn)? page : LoginMainScreen(),
    );
  }
}

// ----------------------------------------------------------------------