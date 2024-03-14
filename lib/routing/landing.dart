import 'package:deneme/screens/authScreens/loginScreen/loginMainScreen.dart';
import 'package:deneme/screens/navigation/navigationMainScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../screens/authScreens/loginScreen/forgetPasswordScreen.dart';
import '../screens/externalTask/enterExternalTaskScreen.dart';
import '../screens/externalTask/externalTaskDetailScreen.dart';
import '../screens/externalTask/externalTaskMainScreen.dart';
import '../screens/externalTask/externalTasksListScreen.dart';
import '../screens/externalTask/externalWorkPlaceSelectionScreen.dart';
import '../screens/photoScreen/answerDownloadedPhoto.dart';
import '../screens/photoScreen/taskDownloadedPhoto.dart';
import '../screens/photoScreen/taskPhoto.dart';
import '../screens/photoScreen/taskPhotoGalleryView.dart';
import '../screens/regionCenterVisiting/manavDepoFormScreen.dart';
import '../screens/regionCenterVisiting/regionCenterVisitingMainScreen.dart';
import '../screens/remoteTasks/remoteTaskDetailScreen.dart';
import '../screens/remoteTasks/remoteTasksMainScreen.dart';
import '../screens/shopVisiting/commonScreens/cashCountingScreen.dart';
import '../screens/shopVisiting/commonScreens/processesScreen.dart';
import '../screens/shopVisiting/commonScreens/shopClosingCheckingScreen.dart';
import '../screens/shopVisiting/commonScreens/shopOpeningCheckingScreen.dart';
import '../screens/shopVisiting/commonScreens/shopsScreenBS.dart';
import '../screens/shopVisiting/commonScreens/shopsScreenPM.dart';
import '../screens/shopVisiting/manavForms/manavShopFormScreen.dart';
import '../screens/shopVisiting/userBS/inPlaceTasks/inPlaceTaskDetailScreen.dart';
import '../screens/shopVisiting/userBS/inPlaceTasks/inPlaceTasksMainScreen.dart';
import '../screens/shopVisiting/userBS/visitingReportTasks/visitingReportTaskDetailScreen.dart';
import '../screens/shopVisiting/userBS/visitingReportTasks/visitingReportTasksMainScreen.dart';
import '../screens/shopVisiting/userPM/visitingReport/pastReportTaskDetailScreen.dart';
import '../screens/shopVisiting/userPM/visitingReport/pastReportTasksScreen.dart';
import '../screens/shopVisiting/userPM/visitingReport/visitingReportMainScreen.dart';
import '../screens/startWork/shiftTypeScreen.dart';
import '../screens/startWork/startWorkMainScreen.dart';
import '../screens/submitTask/submitTaskMainScreen.dart';
import '../screens/submitTask/submitTaskShopPhotoSelectionScreen.dart';
import '../screens/taskChecking/taskCheckingDetailScreen.dart';
import '../screens/taskChecking/taskCheckingMainScreenBM.dart';


void naviShopVisitingShopsScreen(BuildContext context){
  Navigator.push(context, MaterialPageRoute(builder: (context) => ShopVisitingShopsScreen()));
}

void naviShopVisitingShopsScreenPM(BuildContext context){
  Navigator.push(context, MaterialPageRoute(builder: (context) => ShopVisitingShopsScreenPM()));
}

void naviStartWorkMainScreen(BuildContext context){
  Navigator.push(context, MaterialPageRoute(builder: (context) => StartWorkMainScreen()));
}

void naviExternalTaskDetailScreen(BuildContext context, int id){
  Navigator.push(context, MaterialPageRoute(builder: (context) => ExternalTaskDetailScreen(work_id:id)));
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

void naviRemoteTasksMainScreen(BuildContext context){
  Navigator.push(context, MaterialPageRoute(builder: (context) => RemoteTaskMainScreen()));
}

void naviShopOpeningCheckingScreen(BuildContext context, id){
  Navigator.push(context, MaterialPageRoute(builder: (context) => ShopOpeningCheckingScreen(shop_code: id,)));
}

void naviShopClosingCheckingScreen(BuildContext context, id){
  Navigator.push(context, MaterialPageRoute(builder: (context) => ShopClosingCheckingScreen(shop_code: id)));
}

void naviVisitingReportTaskMainScreen(BuildContext context, id){
  Navigator.push(context, MaterialPageRoute(builder: (context) => VisitingReportTaskMainScreen(shop_code: id,)));
}

void naviInPlaceTaskMainScreen(BuildContext context, id){
  Navigator.push(context, MaterialPageRoute(builder: (context) => InPlaceTaskMainScreen(shop_code:id)));
}

void naviCashCountingScreen(BuildContext context, id, name){
  Navigator.push(context, MaterialPageRoute(builder: (context) => CashCountingScreen(shop_code:id, shopName: name,)));
}

void naviVisitingReportMainScreen(BuildContext context, id){
  Navigator.push(context, MaterialPageRoute(builder: (context) => VisitingRaportMainScreen(shop_code: id,)));
}

void naviInPlaceTaskDetailScreen(BuildContext context, id){
  Navigator.push(context, MaterialPageRoute(builder: (context) => InPlaceTaskDetailScreen(task_id: id)));
}

void naviVisitingReportTaskDetailScreen(BuildContext context, id){
  Navigator.push(context, MaterialPageRoute(builder: (context) => VisitingReportTaskDetailScreen(task_id: id)));
}

void naviPastReportTasksScreen(BuildContext context, id){
  Navigator.push(context, MaterialPageRoute(builder: (context) => PastReportTasksScreen(report_id: id,)));
}

void naviPastReportTaskDetailScreen(BuildContext context, id,completionInfo){
  Navigator.push(context, MaterialPageRoute(builder: (context) => PastReportTaskDetailScreen(task_id: id,completionInfo: completionInfo,)));
}

void naviSubmitTaskMainScreen(BuildContext context){
  Navigator.push(context, MaterialPageRoute(builder: (context) => SubmitTaskMainScreen()));
}

void naviSubmitTaskShopPhotoSelectionScreen(BuildContext context){
  Navigator.push(context, MaterialPageRoute(builder: (context) => SubmitTaskShopPhotoSelectionScreen()));
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

void naviForgetPasswordScreen(BuildContext context){
  Navigator.push(context, MaterialPageRoute(builder: (context) => ForgetPasswordScreen()));
}

void naviShopVisitingProcessesScreen(BuildContext context, id, name){
  Navigator.push(context, MaterialPageRoute(builder: (context) => ShopVisitingProcessesScreen(shop_code:id, shopName: name,)));
}

void naviTaskDownloadedPhotoScreen(BuildContext context, id){
  Navigator.push(context, MaterialPageRoute(builder: (context) => TaskDownloadedPhotoScreen(photo_id: id)));
}

void naviAnswerDownloadedPhotoScreen(BuildContext context, id){
  Navigator.push(context, MaterialPageRoute(builder: (context) => AnswerDownloadedPhotoScreen(complete_task_id: id)));
}

void naviTaskPhotoScreen(BuildContext context, photo_file){
  Navigator.push(context, MaterialPageRoute(builder: (context) => TaskPhotoScreen(photo_file: photo_file)));
}

void naviTaskPhotoGalleryView(BuildContext context, imageList){
  Navigator.push(context, MaterialPageRoute(builder: (context) => TaskPhotoGalleryView(imageList: imageList)));
}

void naviTaskCheckingDetailScreen(BuildContext context, id, completionInfo){
  Navigator.push(context, MaterialPageRoute(builder: (context) => TaskCheckingDetailScreen(task_id: id,completionInfo: completionInfo,)));
}

void naviTaskCheckingMainScreenBM(BuildContext context){
  Navigator.push(context, MaterialPageRoute(builder: (context) => TaskCheckingMainScreenBM()));
}

void naviPlaceSelectionScreen(BuildContext context){
  Navigator.push(context, MaterialPageRoute(builder: (context) => PlaceSelectionScreen()));
}

void naviRegionCenterVisitingMainScreen(BuildContext context, id, name){
  Navigator.push(context, MaterialPageRoute(builder: (context) => RegionCenterVisitingMainScreen(region_code:id, regionName: name,)));
}

void naviShiftTypeScreen(BuildContext context){
  Navigator.push(context, MaterialPageRoute(builder: (context) => ShiftTypeScreen()));
}

void naviManavDepoFormScreen(BuildContext context, id){
  Navigator.push(context, MaterialPageRoute(builder: (context) => ManavDepoFormScreen(shop_code: id,)));
}

void naviManavShopFormScreen(BuildContext context, id){
  Navigator.push(context, MaterialPageRoute(builder: (context) => ManavShopFormScreen(shop_code: id,)));
}
