import 'package:deneme/screens/authScreens/loginScreen/loginMainScreen.dart';
import 'package:deneme/screens/navigation/navigationMainScreen.dart';
import 'package:deneme/screens/other/otherMainScreen.dart';
import 'package:deneme/screens/regionCenterVisiting/tedarikZinciri/regionCenterVisitingProcessesScreenTedarikZinciri.dart';
import 'package:deneme/screens/shopVisiting/manav/userBSManav/inPlaceTasksManav/inPlaceTaskDetailScreenManav.dart';
import 'package:deneme/screens/shopVisiting/manav/userPMManav/visitingReportManav/pastReportTaskDetailScreenManav.dart';
import 'package:deneme/screens/shopVisiting/manav/userPMManav/visitingReportManav/pastReportTasksScreenManav.dart';
import 'package:deneme/screens/shopVisiting/satisOperasyon/shopVisitingProcessesScreenSatisOperasyon.dart';
import 'package:deneme/screens/shopVisiting/satisOperasyon/userBSSatisOperasyon/inPlaceTasksSatisOperasyon/inPlaceTaskDetailScreenSatisOperasyon.dart';
import 'package:deneme/screens/shopVisiting/satisOperasyon/userBSSatisOperasyon/visitingReportTasksSatisOperasyon/visitingReportTasksMainScreenSatisOperasyon.dart';
import 'package:deneme/screens/shopVisiting/satisOperasyon/userPMSatisOperasyon/visitingReportSatisOperasyon/pastReportTaskDetailScreenSatisOperasyon.dart';
import 'package:deneme/screens/shopVisiting/satisOperasyon/userPMSatisOperasyon/visitingReportSatisOperasyon/pastReportTasksScreenSatisOperasyon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../screens/authScreens/loginScreen/forgetPasswordScreen.dart';
import '../screens/externalTask/enterExternalTaskScreen.dart';
import '../screens/externalTask/externalTaskDetailScreen.dart';
import '../screens/externalTask/externalTaskMainScreen.dart';
import '../screens/externalTask/externalTasksListScreen.dart';
import '../screens/externalTask/externalWorkPlaceSelectionScreen.dart';
import '../screens/photoScreen/answerDownloadedPhoto.dart';
import '../screens/photoScreen/shopVisitingBeforeAfterPhotoScreen.dart';
import '../screens/photoScreen/taskDownloadedPhoto.dart';
import '../screens/photoScreen/taskPhoto.dart';
import '../screens/photoScreen/taskPhotoGalleryView.dart';
import '../screens/regionCenterVisiting/manav/formsManav/manavDepoFormScreen.dart';
import '../screens/regionCenterVisiting/manav/regionCenterVisitingProcessesScreenManav.dart';
import '../screens/regionCenterVisiting/satisOperasyon/regionCenterVisitingProcessesScreenSatisOperasyon.dart';
import '../screens/regionCenterVisiting/unkar/regionCenterVisitingProcessesScreenUnkar.dart';
import '../screens/remoteTasks/remoteTaskDetailScreen.dart';
import '../screens/remoteTasks/remoteTasksMainScreen.dart';
import '../screens/shopVisiting/manav/formsManav/manavShopFormScreen.dart';
import '../screens/shopVisiting/manav/shopVisitingProcessesScreenManav.dart';
import '../screens/shopVisiting/manav/userBSManav/inPlaceTasksManav/inPlaceTasksMainScreenManav.dart';
import '../screens/shopVisiting/manav/userBSManav/visitingReportTasksManav/visitingReportTaskDetailScreenManav.dart';
import '../screens/shopVisiting/manav/userBSManav/visitingReportTasksManav/visitingReportTasksMainScreenManav.dart';
import '../screens/shopVisiting/manav/userPMManav/visitingReportManav/visitingReportMainScreenManav.dart';
import '../screens/shopVisiting/satisOperasyon/formsSatisOperasyon/cashCountingScreen.dart';
import '../screens/shopVisiting/satisOperasyon/formsSatisOperasyon/shopClosingCheckingScreen.dart';
import '../screens/shopVisiting/satisOperasyon/formsSatisOperasyon/shopOpeningCheckingScreen.dart';
import '../screens/shopVisiting/commonScreens/shopsScreenBS.dart';
import '../screens/shopVisiting/commonScreens/shopsScreenPM.dart';
import '../screens/shopVisiting/satisOperasyon/userBSSatisOperasyon/inPlaceTasksSatisOperasyon/inPlaceTasksMainScreenSatisOperasyon.dart';
import '../screens/shopVisiting/satisOperasyon/userBSSatisOperasyon/shopVisitingFormSatisOperasyon/shopVisitingFormDetailScreenBSSatisOperasyon.dart';
import '../screens/shopVisiting/satisOperasyon/userBSSatisOperasyon/shopVisitingFormSatisOperasyon/shopVisitingFormMainScreenBSSatisOperasyon.dart';
import '../screens/shopVisiting/satisOperasyon/userBSSatisOperasyon/visitingReportTasksSatisOperasyon/visitingReportTaskDetailScreenSatisOperasyon.dart';
import '../screens/shopVisiting/satisOperasyon/userPMSatisOperasyon/shopVisitingFormSatisOperasyon/shopVisitingFormDetailScreenPMSatisOperasyon.dart';
import '../screens/shopVisiting/satisOperasyon/userPMSatisOperasyon/shopVisitingFormSatisOperasyon/shopVisitingFormMainScreenPMSatisOperasyon.dart';
import '../screens/shopVisiting/satisOperasyon/userPMSatisOperasyon/visitingReportSatisOperasyon/visitingReportMainScreenSatisOperasyon.dart';
import '../screens/shopVisiting/tedarikZinciri/formsTedarikZinciri/tedarikZinciriShopFormScreen.dart';
import '../screens/shopVisiting/tedarikZinciri/shopVisitingProcessesScreenTedarikZinciri.dart';
import '../screens/shopVisiting/unkar/formsUnkar/breadGroupFormScreen.dart';
import '../screens/shopVisiting/unkar/formsUnkar/frozenGroupFormScreen.dart';
import '../screens/shopVisiting/unkar/formsUnkar/tatbakGroupFormScreen.dart';
import '../screens/shopVisiting/unkar/shopVisitingProcessesScreenUnkar.dart';
import '../screens/startWork/shiftTypeScreen.dart';
import '../screens/startWork/startWorkMainScreen.dart';
import '../screens/submitTask/submitTaskMainScreen.dart';
import '../screens/submitTask/submitTaskShopPhotoSelectionScreen.dart';
import '../screens/taskChecking/taskCheckingDetailScreen.dart';


void naviStartWorkMainScreen(BuildContext context){
  Navigator.push(context, MaterialPageRoute(builder: (context) => StartWorkMainScreen()));
}

void naviShiftTypeScreen(BuildContext context){
  Navigator.push(context, MaterialPageRoute(builder: (context) => ShiftTypeScreen()));
}

void naviNavigationMainScreen(BuildContext context){
  Navigator.push(context, MaterialPageRoute(builder: (context) => NavigationMainScreen()));
}

void naviOtherMainScreen(BuildContext context){
  Navigator.push(context, MaterialPageRoute(builder: (context) => OtherMainScreen()));
}

void naviTaskCheckingDetailScreen(BuildContext context, id, completion_info){
  Navigator.push(context, MaterialPageRoute(builder: (context) => TaskCheckingDetailScreen(task_id: id,completion_info: completion_info,)));
}


//-------------------------------------Auth Screens
void naviLoginMainScreen(BuildContext context){
  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginMainScreen()));
}
void naviForgetPasswordScreen(BuildContext context){
  Navigator.push(context, MaterialPageRoute(builder: (context) => ForgetPasswordScreen()));
}
//-------------------------------------Auth Screens



//-------------------------------------Shop Visiting Shops
void naviShopVisitingShopsScreenBS(BuildContext context){
  Navigator.push(context, MaterialPageRoute(builder: (context) => ShopVisitingShopsScreenBS()));
}
void naviShopVisitingShopsScreenPM(BuildContext context){
  Navigator.push(context, MaterialPageRoute(builder: (context) => ShopVisitingShopsScreenPM()));
}
//-------------------------------------Shop Visiting Shops



//-------------------------------------External Task
void naviExternalTaskDetailScreen(BuildContext context, int id){
  Navigator.push(context, MaterialPageRoute(builder: (context) => ExternalTaskDetailScreen(work_id:id)));
}
void naviExternalTasksListScreen(BuildContext context){
  Navigator.push(context, MaterialPageRoute(builder: (context) => ExternalTasksListScreen()));
}
void naviEnterExternalTaskScreen(BuildContext context){
  Navigator.push(context, MaterialPageRoute(builder: (context) => EnterExternalTaskScreen()));
}
void naviExternalTaskMainScreen(BuildContext context){
  Navigator.push(context, MaterialPageRoute(builder: (context) => ExternalTaskMainScreen()));
}
void naviPlaceSelectionScreen(BuildContext context){
  Navigator.push(context, MaterialPageRoute(builder: (context) => PlaceSelectionScreen()));
}
//-------------------------------------External Task



//-------------------------------------Remote Task
void naviRemoteTaskDetailScreen(BuildContext context, id){
  Navigator.push(context, MaterialPageRoute(builder: (context) => RemoteTaskDetailScreen(task_id: id,)));
}
void naviRemoteTasksMainScreen(BuildContext context){
  Navigator.push(context, MaterialPageRoute(builder: (context) => RemoteTaskMainScreen()));
}
//-------------------------------------Remote Task



//-------------------------------------InPlace Task
void naviInPlaceTaskMainScreen(BuildContext context, id, groupNo){
  if(groupNo == 0){
    Navigator.push(context, MaterialPageRoute(builder: (context) => InPlaceTaskMainScreenSatisOperasyon(shop_code: id,)));
  }
  else if(groupNo == 1){
    Navigator.push(context, MaterialPageRoute(builder: (context) => InPlaceTaskMainScreenManav(shop_code: id,)));
  }
}
void naviInPlaceTaskDetailScreen(BuildContext context, id, groupNo){
  if(groupNo == 0){
    Navigator.push(context, MaterialPageRoute(builder: (context) => InPlaceTaskDetailScreenSatisOperasyon(task_id: id)));
  }
  else if(groupNo == 1){
    Navigator.push(context, MaterialPageRoute(builder: (context) => InPlaceTaskDetailScreenManav(task_id: id)));
  }
}
//-------------------------------------InPlace Task



//-------------------------------------Visiting Report
void naviVisitingReportTaskMainScreen(BuildContext context, id, groupNo){
  if(groupNo == 0){
    Navigator.push(context, MaterialPageRoute(builder: (context) => VisitingReportTaskMainScreenSatisOperasyon(shop_code: id,)));
  }
  else if(groupNo == 1){
    Navigator.push(context, MaterialPageRoute(builder: (context) => VisitingReportTaskMainScreenManav(shop_code: id,)));
  }
}
void naviVisitingReportMainScreen(BuildContext context, id, groupNo){
  if(groupNo == 0){
    Navigator.push(context, MaterialPageRoute(builder: (context) => VisitingRaportMainScreenSatisOperasyon(shop_code: id,)));
  }
  else if(groupNo == 1){
    Navigator.push(context, MaterialPageRoute(builder: (context) => VisitingRaportMainScreenManav(shop_code: id,)));
  }
}
void naviVisitingReportTaskDetailScreen(BuildContext context, id, groupNo){
  if(groupNo == 0){
    Navigator.push(context, MaterialPageRoute(builder: (context) => VisitingReportTaskDetailScreenSatisOperasyon(task_id: id)));
  }
  else if(groupNo == 1){
    Navigator.push(context, MaterialPageRoute(builder: (context) => VisitingReportTaskDetailScreenManav(task_id: id)));
  }
}
void naviPastReportTasksScreen(BuildContext context, id, groupNo){
  if(groupNo == 0){
    Navigator.push(context, MaterialPageRoute(builder: (context) => PastReportTasksScreenSatisOperasyon(report_id: id,)));
  }
  else if(groupNo == 1){
    Navigator.push(context, MaterialPageRoute(builder: (context) => PastReportTasksScreenManav(report_id: id,)));
  }
}
void naviPastReportTaskDetailScreen(BuildContext context, id,completion_info, groupNo){
  if(groupNo == 0){
    Navigator.push(context, MaterialPageRoute(builder: (context) => PastReportTaskDetailScreenSatisOperasyon(task_id: id,completion_info: completion_info,)));
  }
  else if(groupNo == 1){
    Navigator.push(context, MaterialPageRoute(builder: (context) => PastReportTaskDetailScreenManav(task_id: id,completion_info: completion_info,)));
  }
}
//-------------------------------------Visiting Report



//-------------------------------------Submit Task
void naviSubmitTaskMainScreen(BuildContext context){
  Navigator.push(context, MaterialPageRoute(builder: (context) => SubmitTaskMainScreen()));
}
void naviSubmitTaskShopPhotoSelectionScreen(BuildContext context){
  Navigator.push(context, MaterialPageRoute(builder: (context) => SubmitTaskShopPhotoSelectionScreen()));
}
//-------------------------------------Submit Task



//-------------------------------------ShopVisitingProcessesScreen
void naviShopVisitingProcessesScreen(BuildContext context, id, name, groupNo){
  if(groupNo == 0){
    Navigator.push(context, MaterialPageRoute(builder: (context) => ShopVisitingProcessesScreenSatisOperasyon(shop_code:id, shop_name: name,)));
  }
  else if(groupNo == 1){
    Navigator.push(context, MaterialPageRoute(builder: (context) => ShopVisitingProcessesScreenManav(shop_code:id, shop_name: name,)));
  }
  else if(groupNo == 2){
    Navigator.push(context, MaterialPageRoute(builder: (context) => ShopVisitingProcessesScreenUnkar(shop_code:id, shop_name: name,)));
  }
  else if(groupNo == 3){
    Navigator.push(context, MaterialPageRoute(builder: (context) => ShopVisitingProcessesScreenTedarikZinciri(shop_code:id, shop_name: name,)));
  }
}
//-------------------------------------ShopVisitingProcessesScreen



//-------------------------------------RegionCenterVisitingProcessesScreen
void naviRegionCenterVisitingProcessesScreen(BuildContext context, id, name, groupNo){
  if(groupNo == 0){
    Navigator.push(context, MaterialPageRoute(builder: (context) => RegionCenterVisitingProcessesScreenSatisOperasyon(region_code:id, region_name: name,)));
  }
  else if(groupNo == 1){
    Navigator.push(context, MaterialPageRoute(builder: (context) => RegionCenterVisitingProcessesScreenManav(region_code:id, region_name: name,)));
  }
  else if(groupNo == 2){
    Navigator.push(context, MaterialPageRoute(builder: (context) => RegionCenterVisitingProcessesScreenUnkar(region_code:id, region_name: name,)));
  }
  else if(groupNo == 3){
    Navigator.push(context, MaterialPageRoute(builder: (context) => RegionCenterVisitingProcessesScreenTedarikZinciri(region_code:id, region_name: name,)));
  }
}
//-------------------------------------RegionCenterVisitingProcessesScreen



//-------------------------------------Shop Open Close and Cash Sounting Forms
void naviShopOpeningCheckingScreen(BuildContext context, id){
  Navigator.push(context, MaterialPageRoute(builder: (context) => ShopOpeningCheckingScreen(shop_code: id,)));
}
void naviShopClosingCheckingScreen(BuildContext context, id){
  Navigator.push(context, MaterialPageRoute(builder: (context) => ShopClosingCheckingScreen(shop_code: id)));
}
void naviCashCountingScreen(BuildContext context, id, name){
  Navigator.push(context, MaterialPageRoute(builder: (context) => CashCountingScreen(shop_code:id, shop_name: name,)));
}
//-------------------------------------Shop Open Close Forms



//-------------------------------------Manav Forms
void naviManavDepoFormScreen(BuildContext context, id){
  Navigator.push(context, MaterialPageRoute(builder: (context) => ManavDepoFormScreen(region_code: id,)));
}
void naviManavShopFormScreen(BuildContext context, id){
  Navigator.push(context, MaterialPageRoute(builder: (context) => ManavShopFormScreen(shop_code: id,)));
}
//-------------------------------------Manav Forms



//-------------------------------------Unkar Forms
void naviBreadGroupFormScreen(BuildContext context, id){
  Navigator.push(context, MaterialPageRoute(builder: (context) => BreadGroupFormScreen(shop_code: id,)));
}
void naviTatbakGroupFormScreen(BuildContext context, id){
  Navigator.push(context, MaterialPageRoute(builder: (context) => TatbakGroupFormScreen(shop_code: id,)));
}
void naviFrozenGroupFormScreen(BuildContext context, id){
  Navigator.push(context, MaterialPageRoute(builder: (context) => FrozenGroupFormScreen(shop_code: id,)));
}
//-------------------------------------Unkar Forms



//-------------------------------------Tedarik Zinciri Forms
void naviTedarikZinciriShopFormScreen(BuildContext context, id){
  Navigator.push(context, MaterialPageRoute(builder: (context) => TedarikZinciriShopFormScreen(shop_code: id,)));
}
//-------------------------------------Tedarik Zinciri Forms



//-------------------------------------Shop Visiting Form
void naviShopVisitingFormMainScreenBSSatisOperasyon(BuildContext context, id){
  Navigator.push(context, MaterialPageRoute(builder: (context) => ShopVisitingFormMainScreenBSSatisOperasyon(shop_code: id,)));
}
void naviShopVisitingFormMainScreenPMSatisOperasyon(BuildContext context, id){
  Navigator.push(context, MaterialPageRoute(builder: (context) => ShopVisitingFormMainScreenPMSatisOperasyon(shop_code: id,)));
}
void naviShopVisitingFormDetailScreenBSSatisOperasyon(BuildContext context, id, name){
  Navigator.push(context, MaterialPageRoute(builder: (context) => ShopVisitingFormDetailScreenBSSatisOperasyon(item_id: id, item_name: name)));
}
void naviShopVisitingFormDetailScreenPMSatisOperasyon(BuildContext context, id, name){
  Navigator.push(context, MaterialPageRoute(builder: (context) => ShopVisitingFormDetailScreenPMSatisOperasyon(item_id: id, item_name: name,)));
}
//-------------------------------------Shop Visiting Form



//-------------------------------------Photo Screens
void naviTaskDownloadedPhotoScreen(BuildContext context, id){
  Navigator.push(context, MaterialPageRoute(builder: (context) => TaskDownloadedPhotoScreen(photo_id: id)));
}
void naviAnswerDownloadedPhotoScreen(BuildContext context, id){
  Navigator.push(context, MaterialPageRoute(builder: (context) => AnswerDownloadedPhotoScreen(complete_task_id: id)));
}
void naviTaskPhotoScreen(BuildContext context, photo_file){
  Navigator.push(context, MaterialPageRoute(builder: (context) => TaskPhotoScreen(photo_file: photo_file)));
}
void naviTaskPhotoGalleryView(BuildContext context, image_list){
  Navigator.push(context, MaterialPageRoute(builder: (context) => TaskPhotoGalleryView(image_list: image_list)));
}
void naviShopVisitingBeforeAfterPhotoScreen(BuildContext context, bool isBefore){
  Navigator.push(context, MaterialPageRoute(builder: (context) => ShopVisitingBeforeAfterPhotoScreen(isBefore: isBefore,)));
}
//-------------------------------------Photo Screens