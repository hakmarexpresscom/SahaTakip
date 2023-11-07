import 'dart:convert';

import 'package:deneme/utils/generalFunctions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/constants.dart';
import '../models/bmPassword.dart';
import '../models/bsPassword.dart';
import '../models/pmPassword.dart';
import '../models/userBM.dart';
import '../models/userBS.dart';
import '../models/userPM.dart';
import '../routing/landing.dart';
import '../services/bmPasswordServices.dart';
import '../services/bsPasswordServices.dart';
import '../services/pmPasswordServices.dart';
import '../services/userBMServices.dart';
import '../services/userBSServices.dart';
import '../services/userPMServices.dart';
import 'package:crypto/crypto.dart';

int sayac = 0;

login(String user, String email, String password, BuildContext context){
  if(user=="Bölge Sorumlusu") {
    userType="BS";
    isBSorPM=true;
    isBS=true;
    urlShopFilter = "/byBsId?bs_id";
    urlWorkFilter = "filterHariciIs1?bs_id";
    checkEmailBS(email, 'http://172.23.21.112:7042/api/KullaniciBS', context);
    checkPasswordBS(password, 'http://172.23.21.112:7042/api/BSSifre','http://172.23.21.112:7042/api/KullaniciBS', sayac,context);
  }
  else if(user=="Pazarlama Müdürü") {
    userType="PM";
    isBSorPM=true;
    isBS=false;
    urlShopFilter = "/byPmId?pm_id";
    urlWorkFilter = "filterHariciIs2?pm_id";
    checkEmailPM(email, 'http://172.23.21.112:7042/api/KullaniciPM', context);
    checkPasswordPM(password, 'http://172.23.21.112:7042/api/PMSifre','http://172.23.21.112:7042/api/KullaniciPM', sayac,context);
  }
  else if(user=="Bölge Müdürü") {
    userType="BM";
    isBSorPM=false;
    isBS=false;
    urlShopFilter = "/byBmId?bm_id";
    checkEmailBM(email, 'http://172.23.21.112:7042/api/KullaniciBM', context);
    checkPasswordBM(password, 'http://172.23.21.112:7042/api/BMSifre','http://172.23.21.112:7042/api/KullaniciBM', sayac,context);
  }
}

Future checkEmailBS(String email, String url,BuildContext context) async {
  final List<UserBS> users = await fetchUserBS2(url);
  for(int i=0; i<users.length;i++){
    if(users[i].email==email){
      userID=users[i].bs_id;
      sayac=i;
      isCorrectEmail = true;
    }
  }
}

Future checkPasswordBS(String password, String urlPw, String urlUser, int sayac, BuildContext context) async {
  final List<BSPassword> passwords = await fetchBSPassword(urlPw);
  final List<UserBS> users = await fetchUserBS2(urlUser);
  for(int j=0; j<passwords.length;j++){
    if(passwords[j].bs_id==userID){
      List<int> binaryHashedPassword = base64Decode(passwords[j].hashed_pw);
      var bytes = utf8.encode(password);
      var digest = sha256.convert(bytes);
      var hashedPassword = digest.bytes;
      if(listEquals(binaryHashedPassword, hashedPassword)){
        yoneticiID=users[sayac].manager_id;
        await saveShopCodes("http://172.23.21.112:7042/api/magaza/byBsId?bs_id=${userID}");
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        (isBSorPM)?naviStartWorkMainScreen(context):naviNavigationMainScreen(context);
      }
    }
  }
}


Future checkEmailPM(String email, String url,BuildContext context) async {
  final List<UserPM> users = await fetchUserPM2(url);
  for(int i=0; i<users.length;i++){
    if(users[i].email==email){
      userID=users[i].pm_id;
      sayac=i;
    }
  }
}

Future checkPasswordPM(String password, String urlPw, String urlUser, int sayac, BuildContext context) async {
  final List<PMPassword> passwords = await fetchPMPassword(urlPw);
  final List<UserPM> users = await fetchUserPM2(urlUser);
  for(int j=0; j<passwords.length;j++){
    if(passwords[j].pm_id==userID){
      List<int> binaryHashedPassword = base64Decode(passwords[j].hashed_pw);
      var bytes = utf8.encode(password);
      var digest = sha256.convert(bytes);
      var hashedPassword = digest.bytes;
      if(listEquals(binaryHashedPassword, hashedPassword)){
        yoneticiID=users[sayac].manager_id;
        await saveShopCodes("http://172.23.21.112:7042/api/magaza$urlShopFilter=${userID}");
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        (isBSorPM)?naviStartWorkMainScreen(context):naviNavigationMainScreen(context);
      }
    }
  }
}

Future checkEmailBM(String email, String url,BuildContext context) async {
  final List<UserBM> users = await fetchUserBM2(url);
  for(int i=0; i<users.length;i++){
    if(users[i].email==email){
      userID=users[i].bm_id;
    }
  }
}

Future checkPasswordBM(String password, String urlPw, String urlUser, int sayac, BuildContext context) async {
  final List<BMPassword> passwords = await fetchBMPassword(urlPw);
  for(int j=0; j<passwords.length;j++){
    if(passwords[j].bm_id==userID){
      List<int> binaryHashedPassword = base64Decode(passwords[j].hashed_pw);
      var bytes = utf8.encode(password);
      var digest = sha256.convert(bytes);
      var hashedPassword = digest.bytes;
      if(listEquals(binaryHashedPassword, hashedPassword)){
        await saveShopCodes("http://172.23.21.112:7042/api/magaza$urlShopFilter=${userID}");
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        (isBSorPM)?naviStartWorkMainScreen(context):naviNavigationMainScreen(context);
      }
    }
  }
}