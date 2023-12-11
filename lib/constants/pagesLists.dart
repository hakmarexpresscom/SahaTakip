import 'package:deneme/screens/externalTask/externalTaskMainScreen.dart';
import 'package:deneme/screens/shopVisiting/commonScreens/processesScreen.dart';
import 'package:deneme/screens/shopVisiting/commonScreens/shopsScreen.dart';
import 'package:deneme/screens/shopVisiting/commonScreens/shopsScreenPM.dart';
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
  ShopVisitingShopsScreen(),
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
  TaskCheckingMainScreen(),
  SubmitTaskMainScreen(),
  OtherMainScreen()
];

late List<Widget> pagesPM2 = [
  ShopVisitingShopsScreenPM(),
  NavigationMainScreen(),
  NearShopsMainScreen(),
  TaskCheckingMainScreen(),
  SubmitTaskMainScreen(),
  OtherMainScreen()
];

late List<Widget> pagesPM3 = [
  ExternalTaskMainScreen(),
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