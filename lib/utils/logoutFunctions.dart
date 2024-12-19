import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/constants.dart';
import '../main.dart';
import '../routing/landing.dart';
import 'loginFunctions.dart';

logout(BuildContext context) async {

  box.put("userID",0);
  box.put("yoneticiID",0);
  box.put("userEmail","email");
  box.put("userFullName","email");
  box.put("BMEmail","email");
  box.put("PMEmail","email");
  box.put("groupNo",0);
  box.put("regionCode",0);

  box.put("userType","PM");
  box.put("isBSorPM",true);
  box.put("isBS",false);

  box.put("urlShopFilter","");
  box.put("urlWorkFilter","");
  box.put("urlShiftFilter","");
  box.put("urlTaskShops","");

  box.put("shopCodes",[]);
  box.put("bsIDs",[]);
  box.put("bsNames",[]);
  box.put("allSelected",[]);

  box.put('currentShopName', "");
  box.put('currentShopID', 0);
  box.put('currentCenterName', "");
  box.put('currentCenterID', 0);

  box.put("visitingStartTime",DateTime.now());
  box.put("visitingFinishTime",DateTime.now());
  box.put("startTime",DateTime.now());
  box.put("finishTime",DateTime.now());
  box.put("shiftDate","");

  boxStateManagement.put('isStartShift', false);
  boxStateManagement.put('isStoreVisit', false);
  boxStateManagement.put("isRegionCenterVisit", false);
  boxStateManagement.put('isReport', false);
  boxStateManagement.put('isBefore', false);
  boxStateManagement.put('isAfter', false);

  boxShopTaskPhoto.clear();

  userID=0;
  yoneticiID=0;
  userEmail="";
  userFullName="";
  BMEmail="";
  PMEmail="";
  groupNo=0;
  regionCode=0;

  userType = "PM";
  isBSorPM = true;
  isBS = false;

  email="";
  password="";

  shopCodes = [];
  bsIDs = [];
  bsNames = [];
  bsEmails = [];
  allSelected = [];
  taskPhotos = [];

  urlShopFilter = "";
  urlWorkFilter = "";
  urlShiftFilter = "";
  urlTaskShops = "";

  sayac = 0;

  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isLoggedIn', false);
  naviLoginMainScreen(context);
}

