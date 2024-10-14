import 'package:get/get.dart';
import '../constants/constants.dart';
import '../main.dart';

class ShiftManager extends GetxController {

  void startShift() {
    isStartShiftObs.value = true;
    boxStateManagement.put('isStartShift', true);
  }

  void endShift() {
    isStartShiftObs.value = false;
    boxStateManagement.put('isStartShift', false);
  }
}

//------------

class StoreVisitManager extends GetxController {

  void startStoreVisit() {
    isStoreVisitInProgress.value = true;
    boxStateManagement.put('isStoreVisit', true);
  }

  void endStoreVisit() {
    isStoreVisitInProgress.value = false;
    boxStateManagement.put('isStoreVisit', false);
  }
}

//------------

class RegionCenterVisitManager extends GetxController {

  void startRegionCenterVisit() {
    isRegionCenterVisitInProgress.value = true;
    boxStateManagement.put('isRegionCenterVisit', true);
  }

  void endRegionCenterVisit() {
    isRegionCenterVisitInProgress.value = false;
    boxStateManagement.put('isRegionCenterVisit', false);
  }
}

//------------

class ReportManager extends GetxController {

  void createReport() {
    isReportCreated.value = true;
    boxStateManagement.put('isReport', true);
  }

  void noReport() {
    isReportCreated.value = false;
    boxStateManagement.put('isReport', false);
  }
}

//------------

class PhotoManager1 extends GetxController {

  void uploadeBeforePhoto() {
    beforePhoto.value = true;
    boxStateManagement.put('isBefore', true);
  }

  void noBeforePhoto() {
    beforePhoto.value = false;
    boxStateManagement.put('isBefore', false);
  }
}

//------------

class PhotoManager2 extends GetxController {

  void uploadeAfterPhoto() {
    afterPhoto.value = true;
    boxStateManagement.put('isAftere', true);
  }

  void noAfterPhoto() {
    afterPhoto.value = false;
    boxStateManagement.put('isAfter', false);
  }
}

