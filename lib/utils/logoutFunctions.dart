import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/constants.dart';
import '../main.dart';
import '../routing/landing.dart';

logout(BuildContext context) async {
  box.put("userID",0);
  box.put("yoneticiID",0);
  box.put("groupNo",0);
  box.put("userType","PM");
  box.put("isBSorPM",true);
  box.put("isBS",false);
  box.put("urlShopFilter","");
  box.put("urlWorkFilter","");
  box.put("shopCodes",[]);
  boxShopTaskPhoto.clear();
  box.put('currentShopName', "");
  box.put('currentShopID', 0);
  box.put("startHour",0);
  box.put("startMinute",0);
  box.put("startSecond",0);
  box.put("finishHour",0);
  box.put("finishMinute",0);
  box.put("finishSecond",0);
  boxStateManagement.put('isStartShopVisitWork', false);
  boxStateManagement.put('isStartExternalTaskWork', false);
  boxStateManagement.put("isStoreVisit", false);
  boxStateManagement.put('isReport', false);
  userID=0;
  yoneticiID=0;
  userType = "PM";
  isBSorPM = true;
  isBS = false;
  email="";
  password="";
  urlTaskShops ="";
  shopCodes = [];
  taskPhotos = [];
  urlShopFilter = "";
  urlWorkFilter = "";
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isLoggedIn', false);
  naviLoginMainScreen(context);
}

