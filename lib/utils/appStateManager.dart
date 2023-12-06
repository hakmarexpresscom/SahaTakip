import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../constants/constants.dart';

class StoreVisitManager extends GetxController {

  void startStoreVisit() {
    isStoreVisitInProgress.value = true;
  }

  void endStoreVisit() {
    isStoreVisitInProgress.value = false;
  }
}


class ReportManager extends GetxController {

  void createReport() {
    isReportCreated.value = true;
  }

  void noReport() {
    isReportCreated.value = false;
  }
}


class InShopOpenFormManager extends GetxController {

  void createForm() {
    isInShopOpenFormFilled.value = true;
  }

  void noForm() {
    isInShopOpenFormFilled.value = false;
  }
}


class OutShopOpenFormManager extends GetxController {

  void createForm() {
    isOutShopOpenFormFilled.value = true;
  }

  void noForm() {
    isOutShopOpenFormFilled.value = false;
  }
}


class InShopCloseFormManager extends GetxController {

  void createForm() {
    isInShopCloseFormFilled.value = true;
  }

  void noForm() {
    isInShopCloseFormFilled.value = false;
  }
}


class OutShopCloseFormManager extends GetxController {

  void createForm() {
    isOutShopCloseFormFilled.value = true;
  }

  void noForm() {
    isOutShopCloseFormFilled.value = false;
  }
}


class CashCountFormManager extends GetxController {

  void createForm() {
    isCashCountFormFilled.value = true;
  }

  void noForm() {
    isCashCountFormFilled.value = false;
  }
}

