import 'dart:convert';
import 'package:deneme/utils/generalFunctions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/constants.dart';
import '../main.dart';
import '../models/bmPassword.dart';
import '../models/bsPassword.dart';
import '../models/nkPassword.dart';
import '../models/pmPassword.dart';
import '../models/userBM.dart';
import '../models/userBS.dart';
import '../models/userNK.dart';
import '../models/userPM.dart';
import '../routing/landing.dart';
import '../services/bmPasswordServices.dart';
import '../services/bsPasswordServices.dart';
import '../services/nkPasswordServices.dart';
import '../services/pmPasswordServices.dart';
import '../services/userBMServices.dart';
import '../services/userBSServices.dart';
import '../services/userNKServices.dart';
import '../services/userPMServices.dart';
import 'package:crypto/crypto.dart';

int sayac = 0;
int sayac_2 = 0;

login(String user, String email, String password, BuildContext context) async {
  if(user=="Bölge Sorumlusu") {

    box.put("userType","BS");
    userType=box.get("userType");

    box.put("isBSorPM",true);
    isBSorPM=box.get("isBSorPM");

    box.put("isBS",true);
    isBS=box.get("isBS");

    box.put("urlWorkFilter","filterHariciIs1?bs_id");
    urlWorkFilter = box.get("urlWorkFilter");

    box.put("urlShiftFilter", "byBsIdDate?bs_id");
    urlShiftFilter = box.get("urlShiftFilter");

    box.put("shopCodes",[]);
    shopCodes = box.get("shopCodes");

    box.put("currentShopName","");
    box.put("currentShopID",0);

    box.put("startHour",0);
    box.put("startMinute",0);
    box.put("startSecond",0);
    box.put("finishHour",0);
    box.put("finishMinute",0);
    box.put("finishSecond",0);
    box.put("shiftDate","");

    boxStateManagement.put('isStartShopVisitWork', false);
    isStartShopVisitWork = boxStateManagement.get('isStartShopVisitWork');

    boxStateManagement.put('isStartExternalTaskWork', false);
    isStartExternalTaskWork = boxStateManagement.get('isStartExternalTaskWork');

    boxStateManagement.put('isStoreVisit', false);
    isStoreVisit = boxStateManagement.get('isStoreVisit');

    boxStateManagement.put('isReport', false);
    isReport = boxStateManagement.get('isReport');

    checkEmailBS(email, 'http://172.23.21.112:7042/api/KullaniciBS', context);
    checkPasswordBS(password,'http://172.23.21.112:7042/api/KullaniciBS', sayac,context);
  }
  else if(user=="Pazarlama Müdürü") {

    box.put("userType","PM");
    userType=box.get("userType");

    box.put("isBSorPM",true);
    isBSorPM=box.get("isBSorPM");

    box.put("isBS",false);
    isBS=box.get("isBS");

    box.put("urlShopFilter","/byPmId?pm_id");
    urlShopFilter = box.get("urlShopFilter");

    box.put("urlWorkFilter","filterHariciIs2?pm_id");
    urlWorkFilter = box.get("urlWorkFilter");

    box.put("urlShiftFilter", "byPmIdDate?pm_id");
    urlShiftFilter = box.get("urlShiftFilter");

    box.put("shopCodes",[]);
    shopCodes = box.get("shopCodes");

    box.put("currentShopName","");
    box.put("currentShopID",0);

    box.put("startHour",0);
    box.put("startMinute",0);
    box.put("startSecond",0);
    box.put("finishHour",0);
    box.put("finishMinute",0);
    box.put("finishSecond",0);
    box.put("shiftDate","");

    boxStateManagement.put('isStartShopVisitWork', false);
    isStartShopVisitWork = boxStateManagement.get('isStartShopVisitWork');

    boxStateManagement.put('isStartExternalTaskWork', false);
    isStartExternalTaskWork = boxStateManagement.get('isStartExternalTaskWork');

    boxStateManagement.put('isStoreVisit', false);
    isStoreVisit = boxStateManagement.get('isStoreVisit');

    boxStateManagement.put('isReport', false);
    isReport = boxStateManagement.get('isReport');

    checkEmailPM(email, 'http://172.23.21.112:7042/api/KullaniciPM', context);
    checkPasswordPM(password,'http://172.23.21.112:7042/api/KullaniciPM', sayac,context);
  }
  else if(user=="Bölge Müdürü") {

    box.put("userType","BM");
    userType=box.get("userType");

    box.put("isBSorPM",false);
    isBSorPM=box.get("isBSorPM");

    box.put("isBS",false);
    isBS=box.get("isBS");

    box.put("urlShopFilter","/byBmId?bm_id");
    urlShopFilter = box.get("urlShopFilter");

    box.put("shopCodes",[]);
    shopCodes = box.get("shopCodes");

    boxStateManagement.put('isStoreVisit', false);
    isStoreVisit = boxStateManagement.get('isStoreVisit');

    boxStateManagement.put('isReport', false);
    isReport = boxStateManagement.get('isReport');

    checkEmailBM(email, 'http://172.23.21.112:7042/api/KullaniciBM', context);
    checkPasswordBM(password,'http://172.23.21.112:7042/api/KullaniciBM', sayac,context);
  }

  else if(user=="Normal Kullanıcı"){
    box.put("userType","NK");
    userType=box.get("userType");

    box.put("isBSorPM",false);
    isBSorPM=box.get("isBSorPM");

    box.put("isBS",false);
    isBS=box.get("isBS");

    checkEmailNK(email, 'http://172.23.21.112:7042/api/KullaniciNK', context);
    checkPasswordNK(password,'http://172.23.21.112:7042/api/KullaniciNK', sayac,context);
  }
}

Future checkEmailBS(String email, String url,BuildContext context) async {
  final List<UserBS> users = await fetchUserBS2(url);
  for(int i=0; i<users.length;i++){
    if(users[i].email==email&&users[i].isActive==1){

      box.put("userID",users[i].bs_id);
      userID=box.get("userID");

      box.put("groupNo",users[i].group_no);
      groupNo=box.get("groupNo");

      sayac=i;
    }
  }
}

Future checkPasswordBS(String password, String urlUser, int sayac, BuildContext context) async {
  final List<UserBS> users = await fetchUserBS2(urlUser);
  final BSPassword hashedPw = await fetchBSPassword2('http://172.23.21.112:7042/api/BSSifre/${userID}');

  List<int> binaryHashedPassword = base64Decode(hashedPw.hashed_pw);
  var bytes = utf8.encode(password);
  var digest = sha256.convert(bytes);
  var hashedPassword = digest.bytes;

  if(listEquals(binaryHashedPassword, hashedPassword)){

    box.put("yoneticiID",users[sayac].manager_id);
    yoneticiID=box.get("yoneticiID");

    (users[sayac].group_no==0)?box.put("urlShopFilter","/byBsId?bs_id"):box.put("urlShopFilter","/byBsManavId?bs_manav_id");
    urlShopFilter = box.get("urlShopFilter");

    await saveShopCodes("http://172.23.21.112:7042/api/magaza${urlShopFilter}=${userID}");
    createShopTaskPhotoMap();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    (isBSorPM)?naviStartWorkMainScreen(context):naviNavigationMainScreen(context);
  }
}


Future checkEmailPM(String email, String url,BuildContext context) async {
  final List<UserPM> users = await fetchUserPM2(url);
  for(int i=0; i<users.length;i++){
    if(users[i].email==email&&users[i].isActive==1){

      box.put("userID",users[i].pm_id);
      userID=box.get("userID");

      box.put("groupNo",users[i].group_no);
      groupNo=box.get("groupNo");

      sayac=i;
    }
  }
}

Future checkPasswordPM(String password, String urlUser, int sayac, BuildContext context) async {
  final List<UserPM> users = await fetchUserPM2(urlUser);
  final PMPassword hashedPw = await fetchPMPassword2('http://172.23.21.112:7042/api/PMSifre/${userID}');

  List<int> binaryHashedPassword = base64Decode(hashedPw.hashed_pw);
  var bytes = utf8.encode(password);
  var digest = sha256.convert(bytes);
  var hashedPassword = digest.bytes;

  if(listEquals(binaryHashedPassword, hashedPassword)){

    box.put("yoneticiID",users[sayac].manager_id);
    yoneticiID=box.get("yoneticiID");

    (users[sayac].group_no==0)?box.put("urlShopFilter","/byPmId?pm_id"):box.put("urlShopFilter","/byPmManavId?pm_manav_id");
    urlShopFilter = box.get("urlShopFilter");

    await saveShopCodes("http://172.23.21.112:7042/api/magaza${urlShopFilter}=${userID}");
    createShopTaskPhotoMap();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    (isBSorPM)?naviStartWorkMainScreen(context):naviNavigationMainScreen(context);
  }
}

Future checkEmailBM(String email, String url,BuildContext context) async {
  final List<UserBM> users = await fetchUserBM2(url);
  for(int i=0; i<users.length;i++){
    if(users[i].email==email&&users[i].isActive==1){

      box.put("userID",users[i].bm_id);
      userID=box.get("userID");

      box.put("groupNo",0);
      groupNo=box.get("groupNo");

      isCorrectEmail=true;

      sayac = i;
    }
  }
  if(sayac==0) {
    isCorrectEmail = false;
  }
}

Future checkPasswordBM(String password, String urlUser, int sayac, BuildContext context) async {
  final List<UserBM> users = await fetchUserBM2(urlUser);
  final BMPassword hashedPw = await fetchBMPassword2('http://172.23.21.112:7042/api/BMSifre/${userID}');

  List<int> binaryHashedPassword = base64Decode(hashedPw.hashed_pw);
  var bytes = utf8.encode(password);
  var digest = sha256.convert(bytes);
  var hashedPassword = digest.bytes;

  if(listEquals(binaryHashedPassword, hashedPassword)){

    await saveShopCodes("http://172.23.21.112:7042/api/magaza$urlShopFilter=${userID}");
    createShopTaskPhotoMap();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    (isBSorPM)?naviStartWorkMainScreen(context):naviNavigationMainScreen(context);
  }
}

Future checkEmailNK(String email, String url,BuildContext context) async {
  final List<UserNK> users = await fetchUserNK2(url);
  for(int i=0; i<users.length;i++){
    if(users[i].email==email&&users[i].isActive==1){

      box.put("userID",users[i].nk_id);
      userID=box.get("userID");

      isCorrectEmail=true;

      sayac = i;
    }
  }
  if(sayac==0) {
    isCorrectEmail = false;
  }
}

Future checkPasswordNK(String password, String urlUser, int sayac, BuildContext context) async {
  final NKPassword hashedPw = await fetchNKPassword2('http://172.23.21.112:7042/api/NKSifre/${userID}');

  List<int> binaryHashedPassword = base64Decode(hashedPw.hashed_pw);
  var bytes = utf8.encode(password);
  var digest = sha256.convert(bytes);
  var hashedPassword = digest.bytes;

  if(listEquals(binaryHashedPassword, hashedPassword)){
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    (isBSorPM)?naviStartWorkMainScreen(context):naviNavigationMainScreen(context);
  }
}