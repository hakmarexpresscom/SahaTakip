import 'dart:async';
import 'package:deneme/models/userBM.dart';
import 'package:deneme/models/userBS.dart';
import 'package:deneme/models/userPM.dart';
import 'package:deneme/screens/navigation/navigationMainScreen.dart';
import 'package:deneme/screens/submitTask/submitTaskMainScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/shop.dart';
import '../screens/other/otherMainScreen.dart';
import '../screens/remoteTasks/remoteTasksMainScreen.dart';
import '../screens/nearShops/nearShopsMainScreen.dart';
import '../screens/startWork/startWorkMainScreen.dart';
import '../services/shopServices.dart';
import '../services/userBMServices.dart';
import '../services/userBSServices.dart';
import '../services/userPMServices.dart';

class GoogleMapMarkerList {
  static List<Map<String, dynamic>> list = [
    {"id": "1", "lat": "37.4219983", "long": "-122.090"},
    {"id": "2", "lat": "37.4219983", "long": "-122.095"},
    {"id": "3", "lat": "37.4219983", "long": "-122.097"},
  ];
}

Future<List<Shop>> futureShopList = fetchShop('http://172.23.21.112:7042/api/magaza');

int id=1;
Future<List<Shop>> futureShopList2 = fetchShop('https://651bb092194f77f2a5aeb616.mockapi.io/magaza?bs_id=${id}');

int workDurationHour = 0;
int workDurationMin = 0;
bool isWorking = false;
String userType = "PM";
bool isBSorPM = true;
bool isBS = false;
bool isReportCreated = false;
List<String> shiftType = <String>['Mağaza Ziyareti', 'Harici İş'];
List<String> userTypeList = <String>['Bölge Sorumlusu', 'Pazarlama Müdürü','Bölge Müdürü'];
String email="";
String password="";

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
];



