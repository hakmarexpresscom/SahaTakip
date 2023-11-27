import 'dart:async';
import 'package:image_picker/image_picker.dart';
import '../main.dart';
import '../models/shop.dart';
import '../services/shopServices.dart';


class GoogleMapMarkerList {
  static List<Map<String, dynamic>> list = [
    {"id": "1", "lat": "37.4219983", "long": "-122.090"},
    {"id": "2", "lat": "37.4219983", "long": "-122.095"},
    {"id": "3", "lat": "37.4219983", "long": "-122.097"},
  ];
}

Future<List<Shop>> futureShopList = fetchShop('http://172.23.21.112:7042/api/magaza');

int externalTaskCount = 0;
int incompleteTaskCount = 0;
int photoCount = 0;

bool isCorrectEmail = true;
bool isCorrectPassword = true;

String urlShopFilter = (isLoggedIn)?box.get("urlShopFilter"):"";
String urlWorkFilter = (isLoggedIn)?box.get("urlWorkFilter"):"";
String urlTaskShops ="";

List<dynamic> shopCodes = (isLoggedIn)?box.get("shopCodes"):[];
Map<int, bool> shopCheckboxMap = {};

Map<dynamic, dynamic> shopTaskPhotoMap = (isLoggedIn)?box.get("shopTaskPhotoMap"):{};
Map<dynamic, dynamic> shopAnswerPhotoMap = (isLoggedIn)?box.get("shopAnswerPhotoMap"):{};
List<XFile> taskPhotos = [];

int userID=(isLoggedIn)?box.get("userID"):0;
int yoneticiID = (isLoggedIn)?box.get("yoneticiID"):0;

int workDurationHour = 0;
int workDurationMin = 0;
bool isWorking = false;

String userType = (isLoggedIn)?box.get("userType"):"PM";
bool isBSorPM = (isLoggedIn)?box.get("isBSorPM"):true;
bool isBS = (isLoggedIn)?box.get("isBS"):false;

bool isReportCreated = false;

List<String> shiftType = <String>['Mağaza Ziyareti', 'Harici İş'];
List<String> userTypeList = <String>['Bölge Sorumlusu', 'Pazarlama Müdürü','Bölge Müdürü'];

String email="";
String password="";








