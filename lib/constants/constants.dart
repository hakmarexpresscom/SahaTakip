import 'dart:async';
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

int id=1;
Future<List<Shop>> futureShopList2 = fetchShop('https://651bb092194f77f2a5aeb616.mockapi.io/magaza?bs_id=${id}');

int workDurationHour = 0;
int workDurationMin = 0;
bool isWorking = false;
String userType = "PM";
bool isBSorPM = true;
bool isBS = false;
bool isReportCreated = false;
List<String> shiftType = <String>['Mağaza Ziyareti', 'Harici İş'];
List<String> userTypeList = <String>['Bölge Sorumlusu', 'Pazarlama Müdürü','Bölge Müdürü'];
String email="";
String password="";







