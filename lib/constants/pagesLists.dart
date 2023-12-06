import 'package:deneme/screens/shopVisiting/commonScreens/processesScreen.dart';
import 'package:flutter/cupertino.dart';
import '../screens/navigation/navigationMainScreen.dart';
import '../screens/nearShops/nearShopsMainScreen.dart';
import '../screens/other/otherMainScreen.dart';
import '../screens/remoteTasks/remoteTasksMainScreen.dart';
import '../screens/startWork/startWorkMainScreen.dart';
import '../screens/submitTask/submitTaskMainScreen.dart';
import '../screens/taskChecking/taskCheckingMainScreen.dart';
import 'constants.dart';

late List<Widget> pagesBS = [
  StartWorkMainScreen(),
  NavigationMainScreen(),
  NearShopsMainScreen(),
  RemoteTaskMainScreen(),
  OtherMainScreen()
];

late List<Widget> pagesBS2 = [
  ShopVisitingProcessesScreen(shop_code: 5000, shopName: "shopName / shopname"),
  NavigationMainScreen(),
  NearShopsMainScreen(),
  RemoteTaskMainScreen(),
  OtherMainScreen()
];

late List<Widget> pagesPM = [
  StartWorkMainScreen(),
  NavigationMainScreen(),
  NearShopsMainScreen(),
  TaskCheckingMainScreen(),
  SubmitTaskMainScreen(),
  OtherMainScreen()
];

late List<Widget> pagesPM2 = [
  ShopVisitingProcessesScreen(shop_code: 5000, shopName: "shopName / shopname"),
  NavigationMainScreen(),
  NearShopsMainScreen(),
  TaskCheckingMainScreen(),
  SubmitTaskMainScreen(),
  OtherMainScreen()
];

late List<Widget> pagesBMGK = [
  NavigationMainScreen(),
  NearShopsMainScreen(),
  TaskCheckingMainScreen(),
  SubmitTaskMainScreen(),
  OtherMainScreen()
];

late List<Widget> pagesNK = [
  NavigationMainScreen(),
  NearShopsMainScreen(),
];