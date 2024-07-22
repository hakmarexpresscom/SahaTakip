import 'dart:convert';
import 'package:deneme/utils/generalFunctions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:retry/retry.dart';
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

import '../widgets/alert_dialog_without_button.dart';

int sayac = 0;

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

    box.put("currentShopName","");
    box.put("currentShopID",0);

    box.put("visitingStartTime",DateTime.now());
    box.put("visitingFinishTime",DateTime.now());

    box.put("startTime",DateTime.now());
    box.put("finishTime",DateTime.now());

    box.put("shiftDate","");

    boxStateManagement.put('isStartShift', false);
    isStartShift = boxStateManagement.get('isStartShift');

    boxStateManagement.put('isStoreVisit', false);
    isStoreVisit = boxStateManagement.get('isStoreVisit');

    boxStateManagement.put('isRegionCenterVisit', false);
    isStoreVisit = boxStateManagement.get('isRegionCenterVisit');

    boxStateManagement.put('isReport', false);
    isReport = boxStateManagement.get('isReport');

    checkEmailBS(email, '${constUrl}api/KullaniciBS', context);
    checkPasswordBS(password,'${constUrl}api/KullaniciBS', sayac,context);
  }
  else if(user=="Pazarlama Müdürü") {

    box.put("userType","PM");
    userType=box.get("userType");

    box.put("isBSorPM",true);
    isBSorPM=box.get("isBSorPM");

    box.put("isBS",false);
    isBS=box.get("isBS");

    box.put("urlWorkFilter","filterHariciIs2?pm_id");
    urlWorkFilter = box.get("urlWorkFilter");

    box.put("urlShiftFilter", "byPmIdDate?pm_id");
    urlShiftFilter = box.get("urlShiftFilter");

    box.put("currentShopName","");
    box.put("currentShopID",0);

    box.put("visitingStartTime",DateTime.now());
    box.put("visitingFinishTime",DateTime.now());

    box.put("startTime",DateTime.now());
    box.put("finishTime",DateTime.now());

    box.put("shiftDate","");

    boxStateManagement.put('isStartShift', false);
    isStartShift = boxStateManagement.get('isStartShift');

    boxStateManagement.put('isStoreVisit', false);
    isStoreVisit = boxStateManagement.get('isStoreVisit');

    boxStateManagement.put('isRegionCenterVisit', false);
    isStoreVisit = boxStateManagement.get('isRegionCenterVisit');

    boxStateManagement.put('isReport', false);
    isReport = boxStateManagement.get('isReport');

    checkEmailPM(email, '${constUrl}api/KullaniciPM', context);
    checkPasswordPM(password,'${constUrl}api/KullaniciPM', sayac,context);
  }
  else if(user=="Bölge Müdürü") {

    box.put("userType","BM");
    userType=box.get("userType");

    box.put("isBSorPM",false);
    isBSorPM=box.get("isBSorPM");

    box.put("isBS",false);
    isBS=box.get("isBS");

    boxStateManagement.put('isStartShift', false);
    isStartShift = boxStateManagement.get('isStartShift');

    boxStateManagement.put('isStoreVisit', false);
    isStoreVisit = boxStateManagement.get('isStoreVisit');

    boxStateManagement.put('isRegionCenterVisit', false);
    isStoreVisit = boxStateManagement.get('isRegionCenterVisit');

    boxStateManagement.put('isReport', false);
    isReport = boxStateManagement.get('isReport');

    checkEmailBM(email, '${constUrl}api/KullaniciBM', context);
    checkPasswordBM(password,'${constUrl}api/KullaniciBM', sayac,context);
  }

  else if(user=="Normal Kullanıcı"){
    box.put("userType","NK");
    userType=box.get("userType");

    box.put("isBSorPM",false);
    isBSorPM=box.get("isBSorPM");

    box.put("isBS",false);
    isBS=box.get("isBS");

    checkEmailNK(email, '${constUrl}api/KullaniciNK', context);
    checkPasswordNK(password,'${constUrl}api/KullaniciNK', sayac,context);
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

      box.put("regionCode",users[i].bolge);
      regionCode=box.get("regionCode");

      sayac=i;
    }
  }
  if(sayac==0) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Yanlış e-posta veya şifre')),
    );
  }
}

Future checkPasswordBS(String password, String urlUser, int sayac, BuildContext context) async {
  try {
    final List<UserBS> users = await fetchUserBS2(urlUser);

    BSPassword hashedPw;
    try {
      hashedPw = await retry(
            () => fetchBSPassword2('${constUrl}api/BSSifre/${userID}'),
        retryIf: (e) => e is Exception,
      );
    } catch (error) {
      throw Exception('Şifre alımında hata oluştu');
    }

    List<int> binaryHashedPassword = base64Decode(hashedPw.hashed_pw);
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);
    var hashedPassword = digest.bytes;

    if (listEquals(binaryHashedPassword, hashedPassword)) {

      showWaitingDialog(context);

      box.put("yoneticiID", users[sayac].manager_id);
      yoneticiID = box.get("yoneticiID");

      urlShopFilter = (users[sayac].group_no == 0) ? "/byBsId?bs_id" : "/byBsManavId?bs_manav_id";
      box.put("urlShopFilter", urlShopFilter);

      try {
        await saveShopCodes("${constUrl}api/magaza${urlShopFilter}=${userID}");

        if (users[sayac].group_no != 0) {
          await saveBSManavID("${constUrl}api/magaza${urlShopFilter}=${userID}");
        }

        await saveBSName();
        await createShopTaskPhotoMap(users[sayac].group_no);

      } catch (error) {
        throw Exception('Veri kaydında hata oluştu');
      }

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      Navigator.of(context).pop();
      (isBSorPM) ? naviStartWorkMainScreen(context) : naviNavigationMainScreen(context);

    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Yanlış e-posta veya şifre')),
      );
    }
  } catch (error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Bir hata oluştu: $error')),
    );
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

      box.put("regionCode",users[i].bolge);
      regionCode=box.get("regionCode");

      sayac=i;
    }
  }
  if(sayac==0) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Yanlış e-posta veya şifre')),
    );
  }
}

Future checkPasswordPM(String password, String urlUser, int sayac, BuildContext context) async {
  try {
    final List<UserPM> users = await fetchUserPM2(urlUser);

    PMPassword hashedPw;
    try {
      hashedPw = await retry(
            () => fetchPMPassword2('${constUrl}api/PMSifre/${userID}'),
        retryIf: (e) => e is Exception,
      );
    } catch (error) {
      throw Exception('Şifre alımında hata oluştu');
    }

    List<int> binaryHashedPassword = base64Decode(hashedPw.hashed_pw);
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);
    var hashedPassword = digest.bytes;

    if (listEquals(binaryHashedPassword, hashedPassword)) {

      showWaitingDialog(context);

      box.put("yoneticiID", users[sayac].manager_id);
      yoneticiID = box.get("yoneticiID");

      urlShopFilter = (users[sayac].group_no == 0) ? "/byPmId?pm_id" : "/byPmManavId?pm_manav_id";
      box.put("urlShopFilter", urlShopFilter);

      try {
        await saveShopCodes("${constUrl}api/magaza${urlShopFilter}=${userID}");

        if (users[sayac].group_no == 0) {
          await saveBSID("${constUrl}api/magaza${urlShopFilter}=${userID}");
        } else {
          await saveBSManavID("${constUrl}api/magaza${urlShopFilter}=${userID}");
        }

        await saveBSName();
        await createShopTaskPhotoMap(users[sayac].group_no);

      } catch (error) {
        throw Exception('Veri kaydında hata oluştu');
      }

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      Navigator.of(context).pop();
      (isBSorPM) ? naviStartWorkMainScreen(context) : naviNavigationMainScreen(context);

    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Yanlış e-posta veya şifre')),
      );
    }
  } catch (error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Bir hata oluştu: $error')),
    );
  }
}


Future checkEmailBM(String email, String url,BuildContext context) async {
  final List<UserBM> users = await fetchUserBM2(url);
  for(int i=0; i<users.length;i++){
    if(users[i].email==email&&users[i].isActive==1){

      box.put("userID",users[i].bm_id);
      userID=box.get("userID");

      box.put("groupNo",users[i].group_no);
      groupNo=box.get("groupNo");

      sayac = i;
    }
  }
  if(sayac==0) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Yanlış e-posta veya şifre')),
    );
  }
}

Future checkPasswordBM(String password, String urlUser, int sayac, BuildContext context) async {
  try {
    final List<UserBM> users = await fetchUserBM2(urlUser);

    BMPassword hashedPw;
    try {
      hashedPw = await retry(
            () => fetchBMPassword2('${constUrl}api/BMSifre/${userID}'),
        retryIf: (e) => e is Exception,
      );
    } catch (error) {
      throw Exception('Şifre alımında hata oluştu');
    }

    List<int> binaryHashedPassword = base64Decode(hashedPw.hashed_pw);
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);
    var hashedPassword = digest.bytes;

    if (listEquals(binaryHashedPassword, hashedPassword)) {

      showWaitingDialog(context);

      urlShopFilter = (users[sayac].group_no == 0) ? "/byBmId?bm_id" : "/byBmManavId?bm_manav_id";
      box.put("urlShopFilter", urlShopFilter);

      try {
        await saveShopCodes("${constUrl}api/magaza${urlShopFilter}=${userID}");

        if (users[sayac].group_no == 0) {
          await saveBSID("${constUrl}api/magaza${urlShopFilter}=${userID}");
        } else {
          await saveBSManavID("${constUrl}api/magaza${urlShopFilter}=${userID}");
        }

        await saveBSName();
        await createShopTaskPhotoMap(users[sayac].group_no);

      } catch (error) {
        throw Exception('Veri kaydında hata oluştu');
      }

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      Navigator.of(context).pop();
      (isBSorPM) ? naviStartWorkMainScreen(context) : naviNavigationMainScreen(context);

    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Yanlış e-posta veya şifre')),
      );
    }
  } catch (error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Bir hata oluştu: $error')),
    );
  }
}


Future checkEmailNK(String email, String url,BuildContext context) async {
  final List<UserNK> users = await fetchUserNK2(url);
  for(int i=0; i<users.length;i++){
    if(users[i].email==email&&users[i].isActive==1){

      box.put("userID",users[i].nk_id);
      userID=box.get("userID");

      sayac = i;
    }
  }
  if(sayac==0) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Yanlış e-posta veya şifre')),
    );
  }
}

Future checkPasswordNK(String password, String urlUser, int sayac, BuildContext context) async {
  final NKPassword hashedPw = await fetchNKPassword2('${constUrl}api/NKSifre/${userID}');

  List<int> binaryHashedPassword = base64Decode(hashedPw.hashed_pw);
  var bytes = utf8.encode(password);
  var digest = sha256.convert(bytes);
  var hashedPassword = digest.bytes;

  if(listEquals(binaryHashedPassword, hashedPassword)){

    showWaitingDialog(context);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);

    Navigator.of(context).pop();
    (isBSorPM)?naviStartWorkMainScreen(context):naviNavigationMainScreen(context);
  }
  else{
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Yanlış e-posta veya şifre')),
    );
  }
}

showWaitingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return  AlertDialogWithoutButtonWidget(
        title: "Giriş Yapılıyor",
        content: "Uygulamaya giriş yapıyorsunuz, lütfen bekleyiniz.",
      );
    },
  );
}