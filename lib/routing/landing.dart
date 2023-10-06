import 'package:deneme/screens/navigation/navigationMainScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../screens/other/externalTasks/enterExternalTaskScreen.dart';
import '../screens/other/externalTasks/externalTaskDetailScreen.dart';
import '../screens/other/externalTasks/externalTasksMainScreen.dart';
import '../screens/remoteTasks/remoteTaskDetailScreen.dart';
import '../screens/shopVisiting/commonScreens/cashCountingScreen.dart';
import '../screens/shopVisiting/commonScreens/shopClosingCheckingScreen.dart';
import '../screens/shopVisiting/commonScreens/shopOpeningCheckingScreen.dart';
import '../screens/shopVisiting/commonScreens/shopsScreen.dart';
import '../screens/shopVisiting/userBS/inPlaceTasks/inPlaceTaskDetailScreen.dart';
import '../screens/shopVisiting/userBS/inPlaceTasks/inPlaceTasksMainScreen.dart';
import '../screens/shopVisiting/userBS/visitingReportTasks/visitingReportTaskDetailScreen.dart';
import '../screens/shopVisiting/userBS/visitingReportTasks/visitingReportTasksMainScreen.dart';
import '../screens/shopVisiting/userPM/visitingReport/pastReports/pastReportDetailScreen.dart';
import '../screens/shopVisiting/userPM/visitingReport/visitingReportMainScreen.dart';
import '../screens/startWork/startWorkMainScreen.dart';
import '../screens/submitTask/submitTaskShopSelectionScreen.dart';

void naviShopVisitingShopsScreen(BuildContext context){
  Navigator.push(context, MaterialPageRoute(builder: (context) => ShopVisitingShopsScreen()));
}

void naviStartWorkMainScreen(BuildContext context){
  Navigator.push(context, MaterialPageRoute(builder: (context) => StartWorkMainScreen()));
}

void naviExternalTaskDetailScreen(BuildContext context){
  Navigator.push(context, MaterialPageRoute(builder: (context) => ExternalTaskDetailScreen()));
}

void naviExternalTasksMainScreen(BuildContext context){
  Navigator.push(context, MaterialPageRoute(builder: (context) => ExternalTasksMainScreen()));
}

void naviEnterExternalTaskScreen(BuildContext context){
  Navigator.push(context, MaterialPageRoute(builder: (context) => EnterExternalTaskScreen()));
}

void naviRemoteTaskDetailScreen(BuildContext context){
  Navigator.push(context, MaterialPageRoute(builder: (context) => RemoteTaskDetailScreen()));
}

void naviShopOpeningCheckingScreen(BuildContext context){
  Navigator.push(context, MaterialPageRoute(builder: (context) => ShopOpeningCheckingScreen()));
}

void naviShopClosingCheckingScreen(BuildContext context){
  Navigator.push(context, MaterialPageRoute(builder: (context) => ShopClosingCheckingScreen()));
}

void naviVisitingReportTaskMainScreen(BuildContext context){
  Navigator.push(context, MaterialPageRoute(builder: (context) => VisitingReportTaskMainScreen()));
}

void naviInPlaceTaskMainScreen(BuildContext context){
  Navigator.push(context, MaterialPageRoute(builder: (context) => InPlaceTaskMainScreen()));
}

void naviCashCountingScreen(BuildContext context){
  Navigator.push(context, MaterialPageRoute(builder: (context) => CashCountingScreen()));
}

void naviVisitingRaportMainScreen(BuildContext context){
  Navigator.push(context, MaterialPageRoute(builder: (context) => VisitingRaportMainScreen()));
}

void naviInPlaceTaskDetailScreen(BuildContext context){
  Navigator.push(context, MaterialPageRoute(builder: (context) => InPlaceTaskDetailScreen()));
}

void naviVisitingReportTaskDetailScreen(BuildContext context){
  Navigator.push(context, MaterialPageRoute(builder: (context) => VisitingReportTaskDetailScreen()));
}

void naviPastReportDetailScreen(BuildContext context){
  Navigator.push(context, MaterialPageRoute(builder: (context) => PastReportDetailScreen()));
}

void naviSubmitTaskBSSelectionScreen(BuildContext context){
  Navigator.push(context, MaterialPageRoute(builder: (context) => SubmitTaskBSSelectionScreen()));
}

void naviNavigationMainScreen(BuildContext context){
  Navigator.push(context, MaterialPageRoute(builder: (context) => NavigationMainScreen()));
}

