import 'package:flutter/cupertino.dart';
import '../screens/navigation/navigationMainScreen.dart';
import '../screens/nearShops/nearShopsMainScreen.dart';
import '../screens/other/otherMainScreen.dart';
import '../screens/remoteTasks/remoteTasksMainScreen.dart';
import '../screens/startWork/startWorkMainScreen.dart';
import '../screens/submitTask/submitTaskMainScreen.dart';

late List<Widget> pagesBS = [
  StartWorkMainScreen(),
  NavigationMainScreen(),
  NearShopsMainScreen(),
  RemoteTaskMainScreen(),
  OtherMainScreen()
];

late List<Widget> pagesPM = [
  StartWorkMainScreen(),
  NavigationMainScreen(),
  NearShopsMainScreen(),
  RemoteTaskMainScreen(),
  SubmitTaskMainScreen(),
  OtherMainScreen()
];

late List<Widget> pagesBMGK = [
  NavigationMainScreen(),
  NearShopsMainScreen(),
  SubmitTaskMainScreen(),
  OtherMainScreen()
];

late List<Widget> pagesNK = [
  NavigationMainScreen(),
  NearShopsMainScreen(),
];