import 'package:deneme/screens/startWork/shiftTypeScreen.dart';
import 'package:flutter/cupertino.dart';
import '../main.dart';
import '../screens/navigation/navigationMainScreen.dart';
import '../screens/nearShops/nearShopsMainScreen.dart';
import '../screens/other/otherMainScreen.dart';
import '../screens/regionCenterVisiting/regionCenterVisitingMainScreen.dart';
import '../screens/remoteTasks/remoteTasksMainScreen.dart';
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
  ShiftTypeScreen(),
  NavigationMainScreen(),
  NearShopsMainScreen(),
  RemoteTaskMainScreen(),
  OtherMainScreen()
];

late List<Widget> pagesBS3 = [
  RegionCenterVisitingMainScreen(region_code:box.get("currentCenterID"),regionName:box.get("currentCenterName")),
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
  ShiftTypeScreen(),
  NavigationMainScreen(),
  NearShopsMainScreen(),
  TaskCheckingMainScreenPM(),
  SubmitTaskMainScreen(),
  OtherMainScreen()
];

late List<Widget> pagesPM3 = [
  RegionCenterVisitingMainScreen(region_code:box.get("currentCenterID"),regionName:box.get("currentCenterName")),
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