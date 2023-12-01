import 'package:flutter/cupertino.dart';

class StoreVisitManager extends ChangeNotifier {
  bool isStoreVisitInProgress = false;

  void startStoreVisit() {
    isStoreVisitInProgress = true;
    notifyListeners();
  }

  void endStoreVisit() {
    isStoreVisitInProgress = false;
    notifyListeners();
  }
}


class ReportManager extends ChangeNotifier {
  bool isReportCreated = false;

  void createReport() {
    isReportCreated = true;
    notifyListeners();
  }

  void noReport() {
    isReportCreated = false;
    notifyListeners();
  }
}


class InShopOpenFormManager extends ChangeNotifier {
  bool isFormFilled = false;

  void createForm() {
    isFormFilled = true;
    notifyListeners();
  }

  void noForm() {
    isFormFilled = false;
    notifyListeners();
  }
}


class OutShopOpenFormManager extends ChangeNotifier {
  bool isFormFilled = false;

  void createForm() {
    isFormFilled = true;
    notifyListeners();
  }

  void noForm() {
    isFormFilled = false;
    notifyListeners();
  }
}


class InShopCloseFormManager extends ChangeNotifier {
  bool isFormFilled = false;

  void createForm() {
    isFormFilled = true;
    notifyListeners();
  }

  void noForm() {
    isFormFilled = false;
    notifyListeners();
  }
}


class OutShopCloseFormManager extends ChangeNotifier {
  bool isFormFilled = false;

  void createForm() {
    isFormFilled = true;
    notifyListeners();
  }

  void noForm() {
    isFormFilled = false;
    notifyListeners();
  }
}


class CashCountFormManager extends ChangeNotifier {
  bool isFormFilled = false;

  void createForm() {
    isFormFilled = true;
    notifyListeners();
  }

  void noForm() {
    isFormFilled = false;
    notifyListeners();
  }
}

