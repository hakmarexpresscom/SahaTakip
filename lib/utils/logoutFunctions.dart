import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/constants.dart';
import '../routing/landing.dart';

logout(BuildContext context) async {
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
  urlWorkFilter = "";
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isLoggedIn', false);
  naviLoginMainScreen(context);
}

