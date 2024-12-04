import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../main.dart';
import '../models/shop.dart';
import '../services/shopServices.dart';

String constUrl = "https://bizz.hakmarexpress.com/";
String apiKey = "AIzaSyCiElU8MOfQ8m9ht76QUiUvuhZyzVtiztA";

List<String> shopList = [];
List<String> ownShopList = [];
List<String> partnerShopList = [];

RxBool isStartShiftObs = isStartShift.obs;
bool isStartShift = (isLoggedIn) ? boxStateManagement.get('isStartShift', defaultValue: false) : false;

RxBool isStoreVisitInProgress = isStoreVisit.obs;
bool isStoreVisit = (isLoggedIn) ? boxStateManagement.get('isStoreVisit', defaultValue: false) : false;

RxBool isRegionCenterVisitInProgress = isRegionCenterVisit.obs;
bool isRegionCenterVisit = (isLoggedIn) ? boxStateManagement.get('isRegionCenterVisit', defaultValue: false) : false;

RxBool isReportCreated = isReport.obs;
bool isReport = (isLoggedIn) ? boxStateManagement.get('isReport', defaultValue: false) : false;

RxBool beforePhoto = isBefore.obs;
bool isBefore = (isLoggedIn ? boxStateManagement.get('isBefore', defaultValue: false) : false);

RxBool afterPhoto = isAfter.obs;
bool isAfter = (isLoggedIn ? boxStateManagement.get('isAfter', defaultValue: false) : false);

class GoogleMapMarkerList {

  static List<Map<String, dynamic>> list = [
    {"id": "1", "lat": "37.4219983", "long": "-122.090"},
    {"id": "2", "lat": "37.4219983", "long": "-122.095"},
    {"id": "3", "lat": "37.4219983", "long": "-122.097"},
  ];
}

Future<List<Shop>> futureShopList = fetchShop('${constUrl}api/MagazaV113');

String urlShopFilter = (isLoggedIn)?box.get("urlShopFilter"):"";
String urlWorkFilter = (isLoggedIn)?box.get("urlWorkFilter"):"";
String urlShiftFilter = (isLoggedIn)?box.get("urlShiftFilter"):"";
String urlTaskShops = (isLoggedIn)?box.get("urlTaskShops"):"";

List<dynamic> shopCodes = (isLoggedIn) ? box.get("shopCodes", defaultValue: []) : [];
List<dynamic> bsIDs = (isLoggedIn) ? box.get("bsIDs", defaultValue: []) : [];
List<dynamic> bsNames = (isLoggedIn) ? box.get("bsNames", defaultValue: []) : [];
List<dynamic> allSelected = (isLoggedIn) ? box.get("allSelected", defaultValue: []) : [];
List<XFile> taskPhotos = [];

int userID=(isLoggedIn)?box.get("userID"):0;
int yoneticiID = (isLoggedIn)?box.get("yoneticiID"):0;
String yoneticiEmail = (isLoggedIn)?box.get("yoneticiEmail"):"email";
String userEmail = (isLoggedIn)?box.get("userEmail"):"email";
int groupNo = (isLoggedIn)?box.get("groupNo"):0;
int regionCode = (isLoggedIn)?box.get("regionCode"):0;

String userType = (isLoggedIn)?box.get("userType"):"PM";
bool isBSorPM = (isLoggedIn)?box.get("isBSorPM"):true;
bool isBS = (isLoggedIn)?box.get("isBS"):false;

List<String> shiftType = <String>['Mağaza Ziyareti', 'Harici İş'];
List<String> userTypeList = <String>['Bölge Sorumlusu', 'Pazarlama Müdürü','Bölge Müdürü',"Normal Kullanıcı"];
List<String> groupListCompleteTask = <String>['Standart', 'Manav'];
List<String> groupListIncompleteTask = <String>['Standart', 'Manav'];
List<String> taskListCompleteTask = <String>['Yerinde Görevler', 'Uzaktan Görevler', 'Rapor Görevleri'];
List<String> taskListIncompleteTask = <String>['Yerinde Görevler', 'Uzaktan Görevler', 'Raporu Görevleri'];
List<String> taskTypeListCompleteTask = <String>['Yerinde', 'Uzaktan', 'Rapor'];
List<String> taskTypeListIncompleteTask = <String>['Yerinde', 'Uzaktan', 'Rapor'];
List<String> pointList = <String>["1","2","3","4","5"];
double kItemExtent = 32.0;

List<dynamic> createShopFilterList(int bsID) {
  if(bsID==0){
    List<dynamic> allShopFilterList = boxShopTaskPhoto.keys.toList();
    allShopFilterList.insert(0, "Tüm Mağazalar");
    return allShopFilterList;
  }
  else{
    List<dynamic> allShopFilterList2 = [for (var key in boxShopTaskPhoto.keys) if(bsID==boxShopTaskPhoto.get(key)[2]) key];
    allShopFilterList2.insert(0, "BS'nin Tüm Mağazaları");
    return allShopFilterList2;
  }
}

List<dynamic> createShopFilterList2() {
  List<dynamic> allShopFilterList = boxShopTaskPhoto.keys.toList();
  allShopFilterList.insert(0, "Tüm mağazalar");
  return allShopFilterList;
}

String createUrlTaskShopsWithBS(int bsID){
  String urlTaskShopsWithBS = "";
  for(var key in boxShopTaskPhoto.keys){
    if(bsID==boxShopTaskPhoto.get(key)[2]){
      urlTaskShopsWithBS += "magaza_kodu=${key}&";
    }
  }
  urlTaskShopsWithBS = urlTaskShopsWithBS.substring(0, urlTaskShopsWithBS.length - 1);
  return urlTaskShopsWithBS;
}

String email="";
String password="";

bool showOtherTextField = false;
String workPlace = "";
String workPlace2 = "";
final workPlaceTextFieldController = TextEditingController();
