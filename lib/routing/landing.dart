import 'package:deneme/screens/authScreens/loginScreen/loginMainScreen.dart';
import 'package:deneme/screens/navigation/navigationMainScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../screens/externalTask/enterExternalTaskScreen.dart';
import '../screens/externalTask/externalTaskDetailScreen.dart';
import '../screens/externalTask/externalTaskMainScreen.dart';
import '../screens/externalTask/externalTasksListScreen.dart';
import '../screens/remoteTasks/remoteTaskDetailScreen.dart';
import '../screens/shopVisiting/commonScreens/cashCountingScreen.dart';
import '../screens/shopVisiting/commonScreens/processesScreen.dart';
import '../screens/shopVisiting/commonScreens/shopClosingCheckingScreen.dart';
import '../screens/shopVisiting/commonScreens/shopOpeningCheckingScreen.dart';
import '../screens/shopVisiting/commonScreens/shopsScreen.dart';
import '../screens/shopVisiting/commonScreens/shopsScreenPM.dart';
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

void naviShopVisitingShopsScreenPM(BuildContext context){
  Navigator.push(context, MaterialPageRoute(builder: (context) => ShopVisitingShopsScreenPM()));
}

void naviStartWorkMainScreen(BuildContext context){
  Navigator.push(context, MaterialPageRoute(builder: (context) => StartWorkMainScreen()));
}

void naviExternalTaskDetailScreen(BuildContext context){
  Navigator.push(context, MaterialPageRoute(builder: (context) => ExternalTaskDetailScreen()));
}

void naviExternalTasksListScreen(BuildContext context){
  Navigator.push(context, MaterialPageRoute(builder: (context) => ExternalTasksListScreen()));
}

void naviEnterExternalTaskScreen(BuildContext context){
  Navigator.push(context, MaterialPageRoute(builder: (context) => EnterExternalTaskScreen()));
}

void naviRemoteTaskDetailScreen(BuildContext context, id){
  Navigator.push(context, MaterialPageRoute(builder: (context) => RemoteTaskDetailScreen(task_id: id,)));
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

void naviInPlaceTaskMainScreen(BuildContext context, id){
  Navigator.push(context, MaterialPageRoute(builder: (context) => InPlaceTaskMainScreen(shop_code:id)));
}

void naviCashCountingScreen(BuildContext context){
  Navigator.push(context, MaterialPageRoute(builder: (context) => CashCountingScreen()));
}

void naviVisitingReportMainScreen(BuildContext context){
  Navigator.push(context, MaterialPageRoute(builder: (context) => VisitingRaportMainScreen()));
}

void naviInPlaceTaskDetailScreen(BuildContext context, id){
  Navigator.push(context, MaterialPageRoute(builder: (context) => InPlaceTaskDetailScreen(task_id: id)));
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

void naviExternalTaskMainScreen(BuildContext context){
  Navigator.push(context, MaterialPageRoute(builder: (context) => ExternalTaskMainScreen()));
}

void naviLoginMainScreen(BuildContext context){
  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginMainScreen()));
}

void naviShopVisitingProcessesScreen(BuildContext context, id){
  Navigator.push(context, MaterialPageRoute(builder: (context) => ShopVisitingProcessesScreen(shop_code:id)));
}

