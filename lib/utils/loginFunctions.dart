import 'package:deneme/utils/generalFunctions.dart';
import 'package:flutter/cupertino.dart';
import '../constants/constants.dart';
import '../models/userBM.dart';
import '../models/userBS.dart';
import '../models/userPM.dart';
import '../routing/landing.dart';
import '../services/userBMServices.dart';
import '../services/userBSServices.dart';
import '../services/userPMServices.dart';

checkEmail(String user, String email, BuildContext context){
  if(user=="Bölge Sorumlusu") {
    userType="BS";
    isBSorPM=true;
    isBS=true;
    urlShopFilter = "/byBsId?bs_id";
    urlWorkFilter = "filterHariciIs1?bs_id";
    loginUserBS(email, 'http://172.23.21.112:7042/api/KullaniciBS', context);
  }
  else if(user=="Pazarlama Müdürü") {
    userType="PM";
    isBSorPM=true;
    isBS=false;
    urlShopFilter = "/byPmId?pm_id";
    urlWorkFilter = "filterHariciIs2?pm_id";
    loginUserPM(email, 'http://172.23.21.112:7042/api/KullaniciPM', context);
  }
  else if(user=="Bölge Müdürü") {
    userType="BM";
    isBSorPM=false;
    isBS=false;
    urlShopFilter = "/byBmId?bm_id";
    loginUserBM(email, 'http://172.23.21.112:7042/api/KullaniciBM', context);
  }
}

Future loginUserBS(String email,String url,BuildContext context) async {
  final List<UserBS> users = await fetchUserBS2(url);
  for(int i=0; i<users.length;i++){
    if(users[i].email==email){
      userID=users[i].bs_id;
      await saveShopCodes("http://172.23.21.112:7042/api/magaza/byBsId?bs_id=${userID}");
      yoneticiID=users[i].manager_id;
      (isBSorPM)?naviStartWorkMainScreen(context):naviNavigationMainScreen(context);
    }
  }
}

Future loginUserPM(String email, String url,BuildContext context) async {
  final List<UserPM> users = await fetchUserPM2(url);
  for(int i=0; i<users.length;i++){
    if(users[i].email==email){
      userID=users[i].pm_id;
      await saveShopCodes("http://172.23.21.112:7042/api/magaza/byPmId?pm_id=${userID}");
      (isBSorPM)?naviStartWorkMainScreen(context):naviNavigationMainScreen(context);
    }
  }
}

Future loginUserBM(String email, String url,BuildContext context) async {
  final List<UserBM> users = await fetchUserBM2(url);
  for(int i=0; i<users.length;i++){
    if(users[i].email==email){
      userID=users[i].bm_id;
      (isBSorPM)?naviStartWorkMainScreen(context):naviNavigationMainScreen(context);
    }
  }
}