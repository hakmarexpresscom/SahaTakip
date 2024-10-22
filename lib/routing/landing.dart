import 'package:deneme/screens/authScreens/loginScreen/loginMainScreen.dart';
import 'package:deneme/screens/navigation/navigationMainScreen.dart';
import 'package:deneme/screens/other/otherMainScreen.dart';
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
import '../screens/shopVisiting/satisOperasyon/userBSSatisOperasyon/visitingReportTasksSatisOperasyon/visitingReportTaskDetailScreenSatisOperasyon.dart';
import '../screens/shopVisiting/satisOperasyon/userPMSatisOperasyon/visitingReportSatisOperasyon/visitingReportMainScreenSatisOperasyon.dart';
import '../screens/shopVisiting/unkar/formsUnkar/breadGroupFormScreen.dart';
import '../screens/shopVisiting/unkar/formsUnkar/frozenGroupFormScreen.dart';
import '../screens/shopVisiting/unkar/formsUnkar/tatbakGroupFormScreen.dart';
import '../screens/shopVisiting/unkar/shopVisitingProcessesScreenUnkar.dart';
import '../screens/startWork/shiftTypeScreen.dart';
import '../screens/startWork/startWorkMainScreen.dart';
import '../screens/submitTask/submitTaskMainScreen.dart';
import '../screens/submitTask/submitTaskShopPhotoSelectionScreen.dart';
import '../screens/taskChecking/taskCheckingDetailScreen.dart';


void naviShopVisitingShopsScreenBS(BuildContext context){
  Navigator.push(context, MaterialPageRoute(builder: (context) => ShopVisitingShopsScreenBS()));
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

void naviVisitingReportTaskMainScreen(BuildContext context, id, groupNo){
  if(groupNo == 0){
    Navigator.push(context, MaterialPageRoute(builder: (context) => VisitingReportTaskMainScreenSatisOperasyon(shop_code: id,)));
  }
  else if(groupNo == 1){
    Navigator.push(context, MaterialPageRoute(builder: (context) => VisitingReportTaskMainScreenManav(shop_code: id,)));
  }
}

void naviInPlaceTaskMainScreen(BuildContext context, id, groupNo){
  if(groupNo == 0){
    Navigator.push(context, MaterialPageRoute(builder: (context) => InPlaceTaskMainScreenSatisOperasyon(shop_code: id,)));
  }
  else if(groupNo == 1){
    Navigator.push(context, MaterialPageRoute(builder: (context) => InPlaceTaskMainScreenManav(shop_code: id,)));
  }
}

void naviCashCountingScreen(BuildContext context, id, name){
  Navigator.push(context, MaterialPageRoute(builder: (context) => CashCountingScreen(shop_code:id, shopName: name,)));
}

void naviVisitingReportMainScreen(BuildContext context, id, groupNo){
  if(groupNo == 0){
    Navigator.push(context, MaterialPageRoute(builder: (context) => VisitingRaportMainScreenSatisOperasyon(shop_code: id,)));
  }
  else if(groupNo == 1){
    Navigator.push(context, MaterialPageRoute(builder: (context) => VisitingRaportMainScreenManav(shop_code: id,)));
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

void naviPastReportTaskDetailScreen(BuildContext context, id,completionInfo, groupNo){
  if(groupNo == 0){
    Navigator.push(context, MaterialPageRoute(builder: (context) => PastReportTaskDetailScreenSatisOperasyon(task_id: id,completionInfo: completionInfo,)));
  }
  else if(groupNo == 1){
    Navigator.push(context, MaterialPageRoute(builder: (context) => PastReportTaskDetailScreenManav(task_id: id,completionInfo: completionInfo,)));
  }
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

void naviShopVisitingProcessesScreen(BuildContext context, id, name, groupNo){
  if(groupNo == 0){
    Navigator.push(context, MaterialPageRoute(builder: (context) => ShopVisitingProcessesScreenSatisOperasyon(shop_code:id, shopName: name,)));
  }
  else if(groupNo == 1){
    Navigator.push(context, MaterialPageRoute(builder: (context) => ShopVisitingProcessesScreenManav(shop_code:id, shopName: name,)));
  }
  else if(groupNo == 2){
    Navigator.push(context, MaterialPageRoute(builder: (context) => ShopVisitingProcessesScreenUnkar(shop_code:id, shopName: name,)));
  }
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

void naviPlaceSelectionScreen(BuildContext context){
  Navigator.push(context, MaterialPageRoute(builder: (context) => PlaceSelectionScreen()));
}

void naviRegionCenterVisitingProcessesScreen(BuildContext context, id, name, groupNo){
  if(groupNo == 0){
    Navigator.push(context, MaterialPageRoute(builder: (context) => RegionCenterVisitingProcessesScreenSatisOperasyon(region_code:id, regionName: name,)));
  }
  else if(groupNo == 1){
    Navigator.push(context, MaterialPageRoute(builder: (context) => RegionCenterVisitingProcessesScreenManav(region_code:id, regionName: name,)));
  }
  else if(groupNo == 2){
    Navigator.push(context, MaterialPageRoute(builder: (context) => RegionCenterVisitingProcessesScreenUnkar(region_code:id, regionName: name,)));
  }
}

void naviShiftTypeScreen(BuildContext context){
  Navigator.push(context, MaterialPageRoute(builder: (context) => ShiftTypeScreen()));
}

void naviManavDepoFormScreen(BuildContext context, id){
  Navigator.push(context, MaterialPageRoute(builder: (context) => ManavDepoFormScreen(region_code: id,)));
}

void naviManavShopFormScreen(BuildContext context, id){
  Navigator.push(context, MaterialPageRoute(builder: (context) => ManavShopFormScreen(shop_code: id,)));
}

void naviBreadGroupFormScreen(BuildContext context, id){
  Navigator.push(context, MaterialPageRoute(builder: (context) => BreadGroupFormScreen(shop_code: id,)));
}

void naviTatbakGroupFormScreen(BuildContext context, id){
  Navigator.push(context, MaterialPageRoute(builder: (context) => TatbakGroupFormScreen(shop_code: id,)));
}

void naviFrozenGroupFormScreen(BuildContext context, id){
  Navigator.push(context, MaterialPageRoute(builder: (context) => FrozenGroupFormScreen(shop_code: id,)));
}

void naviOtherMainScreen(BuildContext context){
  Navigator.push(context, MaterialPageRoute(builder: (context) => OtherMainScreen()));
}

void naviShopVisitingBeforeAfterPhotoScreen(BuildContext context, bool isBefore){
  Navigator.push(context, MaterialPageRoute(builder: (context) => ShopVisitingBeforeAfterPhotoScreen(isBefore: isBefore,)));
}

