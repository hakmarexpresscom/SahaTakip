import 'package:deneme/screens/navigation/navigationMainScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../screens/other/otherMainScreen.dart';
import '../screens/remoteTasks/remoteTasksMainScreen.dart';
import '../screens/nearShops/nearShopsMainScreen.dart';
import '../screens/startWork/startWorkMainScreen.dart';



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

late List<Widget> pages = [
  StartWorkMainScreen(),
  NavigationMainScreen(),
  NearShopsMainScreen(),
  RemoteTaskMainScreen(),
  OtherMainScreen()
];
