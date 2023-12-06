import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/constants.dart';
import '../main.dart';
import '../routing/landing.dart';

logout(BuildContext context) async {
  box.put("userID",0);
  box.put("yoneticiID",0);
  box.put("userType","PM");
  box.put("isBSorPM",true);
  box.put("isBS",false);
  box.put("urlShopFilter","");
  box.put("urlWorkFilter","");
  box.put("shopCodes",[]);
  box.put("shopTaskPhotoMap",{});
  userID=0;
  yoneticiID=0;
  workDurationHour = 0;
  workDurationMin = 0;
  isWorking = false;
  userType = "PM";
  isBSorPM = true;
  isBS = false;
  //isReportCreated = false;
  email="";
  password="";
  urlTaskShops ="";
  shopCodes = [];
  shopTaskPhotoMap = {};
  taskPhotos = [];
  urlShopFilter = "";
  urlWorkFilter = "";
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isLoggedIn', false);
  naviLoginMainScreen(context);
}

