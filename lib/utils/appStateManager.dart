import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../constants/constants.dart';
import '../main.dart';

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


class InShopOpenFormManager extends GetxController {

  void createForm() {
    isInShopOpenFormFilled.value = true;
    boxStateManagement.put('inShopOpenForm', true);
  }

  void noForm() {
    isInShopOpenFormFilled.value = false;
    boxStateManagement.put('inShopOpenForm', false);
  }
}


class OutShopOpenFormManager extends GetxController {

  void createForm() {
    isOutShopOpenFormFilled.value = true;
    boxStateManagement.put('outShopOpenForm', true);
  }

  void noForm() {
    isOutShopOpenFormFilled.value = false;
    boxStateManagement.put('outShopOpenForm', false);
  }
}


class InShopCloseFormManager extends GetxController {

  void createForm() {
    isInShopCloseFormFilled.value = true;
    boxStateManagement.put('inShopCloseForm', true);
  }

  void noForm() {
    isInShopCloseFormFilled.value = false;
    boxStateManagement.put('inShopCloseForm', false);
  }
}


class OutShopCloseFormManager extends GetxController {

  void createForm() {
    isOutShopCloseFormFilled.value = true;
    boxStateManagement.put('outShopCloseForm', true);
  }

  void noForm() {
    isOutShopCloseFormFilled.value = false;
    boxStateManagement.put('outShopCloseForm', false);
  }
}


class CashCountFormManager extends GetxController {

  void createForm() {
    isCashCountFormFilled.value = true;
    boxStateManagement.put('cashCountForm ', true);
  }

  void noForm() {
    isCashCountFormFilled.value = false;
    boxStateManagement.put('cashCountForm ', false);
  }
}

