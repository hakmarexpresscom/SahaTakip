import 'package:get/get.dart';
import '../constants/constants.dart';
import '../main.dart';

class ShopVisitWorkManager extends GetxController {

  void startShopVisitWork() {
    isStartShopVisitWorkObs.value = true;
    boxStateManagement.put('isStartShopVisitWork', true);
  }

  void endShopVisitWork() {
    isStartShopVisitWorkObs.value = false;
    boxStateManagement.put('isStartShopVisitWork', false);
  }
}


class ExternalTaskWorkManager extends GetxController {

  void startExternalTaskWork() {
    isStartExternalTaskWorkObs.value = true;
    boxStateManagement.put('isStartExternalTaskWork', true);
  }

  void endExternalTaskWork() {
    isStartExternalTaskWorkObs.value = false;
    boxStateManagement.put('isStartExternalTaskWork', false);
  }
}


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

