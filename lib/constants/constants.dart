import 'dart:async';
import 'package:deneme/screens/navigation/navigationMainScreen.dart';
import 'package:deneme/screens/submitTask/submitTaskMainScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/sampleDataSet.dart';
import '../screens/other/otherMainScreen.dart';
import '../screens/remoteTasks/remoteTasksMainScreen.dart';
import '../screens/nearShops/nearShopsMainScreen.dart';
import '../screens/startWork/startWorkMainScreen.dart';


String userType = "PM";
bool isBSorPM = true;
bool isBS = false;
bool isReportCreated = false;

late List<BottomNavigationBarItem> itemListBS = [
  BottomNavigationBarItem(
    icon: Icon(Icons.work),
    label: 'Mesaiye Başla',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.location_on),
    label: 'Navigasyon',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.near_me),
    label: 'Çevre Mağazalar',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.task_alt),
    label: 'Uzaktan Görevler',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.menu),
    label: 'Diğer',
  ),
];

late List<BottomNavigationBarItem> itemListPM = [
  BottomNavigationBarItem(
    icon: Icon(Icons.work),
    label: 'Mesaiye Başla',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.location_on),
    label: 'Navigasyon',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.near_me),
    label: 'Çevre Mağazalar',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.task_alt),
    label: 'Uzaktan Görevler',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.assignment_outlined),
    label: 'Görev Atama',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.menu),
    label: 'Diğer',
  ),
];

late List<BottomNavigationBarItem> itemListBMandGK = [
  BottomNavigationBarItem(
    icon: Icon(Icons.location_on),
    label: 'Navigasyon',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.near_me),
    label: 'Çevre Mağazalar',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.assignment_outlined),
    label: 'Görev Atama',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.menu),
    label: 'Diğer',
  ),
];

late List<BottomNavigationBarItem> itemListNK = [
  BottomNavigationBarItem(
    icon: Icon(Icons.location_on),
    label: 'Navigasyon',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.near_me),
    label: 'Çevre Mağazalar',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.menu),
    label: 'Diğer',
  ),
];

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
  OtherMainScreen()
];



