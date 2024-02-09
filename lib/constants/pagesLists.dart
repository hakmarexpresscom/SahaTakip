import 'package:deneme/screens/externalTask/externalTaskMainScreen.dart';
import 'package:flutter/cupertino.dart';
import '../screens/navigation/navigationMainScreen.dart';
import '../screens/nearShops/nearShopsMainScreen.dart';
import '../screens/other/otherMainScreen.dart';
import '../screens/remoteTasks/remoteTasksMainScreen.dart';
import '../screens/shopVisiting/commonScreens/shopVisitingMainScreen.dart';
import '../screens/startWork/startWorkMainScreen.dart';
import '../screens/submitTask/submitTaskMainScreen.dart';
import '../screens/taskChecking/taskCheckingMainScreenBM.dart';
import '../screens/taskChecking/taskCheckingMainScreenPM.dart';

late List<Widget> pagesBS = [
  StartWorkMainScreen(),
  NavigationMainScreen(),
  NearShopsMainScreen(),
  RemoteTaskMainScreen(),
  OtherMainScreen()
];

late List<Widget> pagesBS2 = [
  ShopVisitingMainScreen(),
  NavigationMainScreen(),
  NearShopsMainScreen(),
  RemoteTaskMainScreen(),
  OtherMainScreen()
];

late List<Widget> pagesBS3 = [
  ExternalTaskMainScreen(),
  NavigationMainScreen(),
  NearShopsMainScreen(),
  RemoteTaskMainScreen(),
  OtherMainScreen()
];

late List<Widget> pagesPM = [
  StartWorkMainScreen(),
  NavigationMainScreen(),
  NearShopsMainScreen(),
  TaskCheckingMainScreenPM(),
  SubmitTaskMainScreen(),
  OtherMainScreen()
];

late List<Widget> pagesPM2 = [
  ShopVisitingMainScreen(),
  NavigationMainScreen(),
  NearShopsMainScreen(),
  TaskCheckingMainScreenPM(),
  SubmitTaskMainScreen(),
  OtherMainScreen()
];

late List<Widget> pagesPM3 = [
  ExternalTaskMainScreen(),
  NavigationMainScreen(),
  NearShopsMainScreen(),
  TaskCheckingMainScreenPM(),
  SubmitTaskMainScreen(),
  OtherMainScreen()
];

late List<Widget> pagesBMGK = [
  NavigationMainScreen(),
  NearShopsMainScreen(),
  TaskCheckingMainScreenBM(),
  SubmitTaskMainScreen(),
  OtherMainScreen()
];

late List<Widget> pagesNK = [
  NavigationMainScreen(),
  NearShopsMainScreen(),
  OtherMainScreen()
];