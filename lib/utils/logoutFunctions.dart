import 'package:flutter/cupertino.dart';

import '../constants/constants.dart';
import '../routing/landing.dart';

logout(BuildContext context){
  userID=0;
  yoneticiID=0;
  workDurationHour = 0;
  workDurationMin = 0;
  isWorking = false;
  userType = "PM";
  isBSorPM = true;
  isBS = false;
  isReportCreated = false;
  email="";
  password="";
  urlTaskShops ="";
  shopCodes = [];
  urlShopFilter = "";
  naviLoginMainScreen(context);
}

