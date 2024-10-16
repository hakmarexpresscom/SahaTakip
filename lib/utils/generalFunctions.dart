import 'package:deneme/constants/constants.dart';
import 'package:deneme/services/inCompleteTaskServices.dart';
import 'package:deneme/services/photoServices.dart';
import 'package:deneme/services/userBSServices.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../main.dart';
import '../models/shop.dart';
import '../models/userBS.dart';
import '../services/shopServices.dart';
import '../widgets/alert_dialog.dart';
import '../widgets/alert_dialog_without_button.dart';

Future createShopList(String url) async{
  final List<Shop> shops = await fetchShop2(url);
  for(int i=0; i<shops.length;i++){
    shopList.add("${shops[i].shopCode} ${shops[i].shopName}");
  }
}

//------------

Future createSearchBarShopList(String url, bool isPartner) async{
  final List<Shop> shops = await fetchShop2(url);
  for(int i=0; i<shops.length;i++){
    if(shops[i].isActive==1) {
      isPartner==false ? ownShopList.add("${shops[i].shopCode} ${shops[i].shopName}") : partnerShopList.add("${shops[i].shopCode} ${shops[i].shopName}");
    }
  }
}

//------------

Future<void> saveShopCodes(String url) async {
  final List<Shop> shops = await fetchShop2(url);
  for (int i = 0; i < shops.length; i++) {
    if (shops[i].isActive == 1) {
      urlTaskShops += (i == shops.length - 1) ? "magaza_kodu=${shops[i].shopCode}" : "magaza_kodu=${shops[i].shopCode}&";
      shopCodes.add(shops[i].shopCode);
    }
  }
  await box.put("urlTaskShops", urlTaskShops);
  await box.put("shopCodes", shopCodes);
}

//------------

Future<void> saveBSID(String url) async {
  final List<Shop> shops = await fetchShop2(url);
  if (!bsIDs.contains(0)) {
    bsIDs.add(0);
    allSelected.add(false);
  }
  for (Shop shop in shops) {
    if (!bsIDs.contains(shop.bs_id)) {
      bsIDs.add(shop.bs_id);
      allSelected.add(false);
    }
  }
  await box.put("bsIDs", bsIDs);
  await box.put("allSelected", allSelected);
}

//------------

Future<void> saveBSManavID(String url) async {
  final List<Shop> shops = await fetchShop2(url);
  if (!bsIDs.contains(0)) {
    bsIDs.add(0);
    allSelected.add(false);
  }
  for (Shop shop in shops) {
    if (!bsIDs.contains(shop.bs_manav_id)) {
      bsIDs.add(shop.bs_manav_id);
      allSelected.add(false);
    }
  }
  await box.put("bsIDs", bsIDs);
  await box.put("allSelected", allSelected);
}

//------------

Future<void> saveBSUnkarID(String url) async {
  final List<Shop> shops = await fetchShop2(url);
  if (!bsIDs.contains(0)) {
    bsIDs.add(0);
    allSelected.add(false);
  }
  for (Shop shop in shops) {
    if (!bsIDs.contains(shop.bs_unkar_id)) {
      bsIDs.add(shop.bs_unkar_id);
      allSelected.add(false);
    }
  }
  await box.put("bsIDs", bsIDs);
  await box.put("allSelected", allSelected);
}

//------------

Future<void> saveBSName() async {
  if (!bsNames.contains("Tüm BS'ler")) {
    bsNames.add("Tüm BS'ler");
  }
  for (int i = 1; i < bsIDs.length; i++) {
    final UserBS userBS = await fetchUserBS3("${constUrl}api/KullaniciBS/${bsIDs[i]}");
    final String fullName = "${userBS.userName} ${userBS.userSurname}";
    if (!bsNames.contains(fullName)) {
      bsNames.add(fullName);
    }
  }
  await box.put("bsNames", bsNames);
}

//------------

Future createShopTaskPhotoMap(int grup) async {
  final List<Future<Shop>> fetchFutures = shopCodes.map<Future<Shop>>((code) {
    return fetchShop3("${constUrl}api/Magaza/$code");
  }).toList();
  final List<Shop> shops = await Future.wait(fetchFutures);
  for (int i = 0; i < shopCodes.length; i++) {
    final Shop shop = shops[i];
    if (grup == 0) {
      int index1 = bsIDs.indexOf(shop.bs_id);
      boxShopTaskPhoto.put(shopCodes[i].toString(), ["", false, shop.bs_id, shop.shopName, bsNames[index1]]);
    } else {
      int index2 = bsIDs.indexOf(shop.bs_manav_id);
      boxShopTaskPhoto.put(shopCodes[i].toString(), ["", false, shop.bs_manav_id, shop.shopName, bsNames[index2]]);
    }
  }
}

//------------

Future createShopTaskPhotoMapBS(int grup) async{
  for(int i=0;i<box.get("shopCodes").length;i++){
    final Shop shop = await fetchShop3("${constUrl}api/Magaza/${box.get("shopCodes")[i]}");
    (grup==0)?boxShopTaskPhoto.put(box.get("shopCodes")[i].toString(),["",false,shop.bs_id]):boxShopTaskPhoto.put(box.get("shopCodes")[i].toString(),[shop.bs_id,"",false,shop.bs_manav_id]);
  }
}

void resetTaskPhotos(){
  taskPhotos=[];
}

//------------

addIncompleteTaskToDatabase(String countTaskUrl, String title, String? detail, String assignmentDate, String finishDate, int? photo_id, String taskType, int? report_id, int group_no, String createTaskUrl,String countPhotoUrl, int? bs_id, int? pm_id, int? bm_id, String photoType, String createPhotoUrl) async{
  for(int i=0;i<shopCodes.length;i++){
    if(boxShopTaskPhoto.get(shopCodes[i].toString())[1]==true){
      await createIncompleteTask(title, detail, assignmentDate, finishDate, shopCodes[i], boxShopTaskPhoto.get(shopCodes[i].toString())[3], photo_id, taskType, report_id,group_no, boxShopTaskPhoto.get(shopCodes[i].toString())[4], createTaskUrl);
      await countIncompleteTask(countTaskUrl);
      if(boxShopTaskPhoto.get(shopCodes[i].toString())[0]!=""){
        await createPhoto(box.get("incompleteTaskCount"), shopCodes[i], bs_id, pm_id, bm_id, photoType, boxShopTaskPhoto.get(shopCodes[i].toString())[0],null, createPhotoUrl);
        await countPhoto(countPhotoUrl);
        updatePhotoIDIncompleteTask(box.get("incompleteTaskCount"),title, detail, assignmentDate, finishDate, shopCodes[i], boxShopTaskPhoto.get(shopCodes[i].toString())[3], box.get("photoCount"), taskType, report_id, group_no, boxShopTaskPhoto.get(shopCodes[i].toString())[4], "${constUrl}api/TamamlanmamisGorev/${box.get("incompleteTaskCount")}");
      }
    }
  }
}

//------------

addReportTaskToDatabase(String countTaskUrl, String title, String? detail, String assignmentDate, String finishDate, int shopCode, int? photo_id, String taskType, int? report_id, int group_no, String createTaskUrl,String photo_file, int? bs_id, int? pm_id, int? bm_id, String photoType) async{
    await createIncompleteTask(title, detail, assignmentDate, finishDate, shopCode, box.get("currentShopName"), photo_id, taskType, report_id, group_no, boxShopTaskPhoto.get(shopCode.toString())[4], createTaskUrl);
    await countIncompleteTask(countTaskUrl);
    if(photo_file.isNotEmpty){
      await createPhoto(box.get("incompleteTaskCount"), shopCode, bs_id, pm_id, bm_id, photoType, photo_file,null, "${constUrl}api/Fotograf");
      await countPhoto("${constUrl}api/Fotograf");
      updatePhotoIDIncompleteTask(box.get("incompleteTaskCount"),title, detail, assignmentDate, finishDate, shopCode, box.get("currentShopName"), box.get("photoCount"), taskType, report_id, group_no, boxShopTaskPhoto.get(shopCode.toString())[4], "${constUrl}api/TamamlanmamisGorev/${box.get("incompleteTaskCount")}");
    }
}

//------------

String calculateElapsedTime(DateTime startTime, DateTime endTime) {
  Duration difference = endTime.difference(startTime);

  int hours = difference.inHours;
  int minutes = (difference.inMinutes % 60);
  int seconds = (difference.inSeconds % 60);

  String elapsedTime = '$hours saat $minutes dakika $seconds saniye';
  return elapsedTime;
}

//------------

int calculateDaysBetweenDates(DateTime startDate, DateTime endDate) {
  Duration difference = endDate.difference(startDate);
  int days = difference.inDays;
  return days;
}

//------------

void openAppleMaps(double latitude, double longitude) async {
  final Uri appleMapsUrl = Uri.parse('https://maps.apple.com/?q=$latitude,$longitude');
  if (await canLaunchUrl(appleMapsUrl)) {
    await launchUrl(appleMapsUrl);
  } else {
    throw 'Apple Maps açılamadı';
  }
}

//------------

void openGoogleMaps(double latitude, double longitude) async {
  final Uri googleMapsUrl = Uri.parse('https://www.google.com/maps/place/$latitude,$longitude');
  print(googleMapsUrl);
  if (await canLaunchUrl(googleMapsUrl)) {
    await launchUrl(googleMapsUrl);
  } else {
    throw 'Google Maps\'i başlatılamıyor.';
  }
}

//------------

void openUpdatePage() async {
  final Uri updateUrl = Uri.parse('https://bizz-indir.hakmarexpress.com');
  try {
    await launchUrl(updateUrl);
  } catch (e) {
    throw 'Sayfa açılamadı: $e';
  }
}

//------------

showAlertDialogWithoutButtonWidget(BuildContext context, String title, String content) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return  AlertDialogWithoutButtonWidget(
        title: title,
        content: content,
      );
    },
  );
}

//------------

showAlertDialogWidget(BuildContext context, String title, String content, VoidCallback onTaps) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialogWidget(
          title: title,
          content: content,
          onTaps: onTaps
        );
      }
  );
}

//------------

resetShopVisitingReportInfo(int grup){
  if(grup==0){
    boxshopVisitingPhoto.put('beforePhoto', "photo");
    boxshopVisitingPhoto.put('afterPhoto', "photo");

    box.put("inShopOpenForm",0);
    box.put("outShopOpenForm",0);
    box.put("inShopCloseForm",0);
    box.put("outShopCloseForm",0);
  }
  else if(grup==1){
    boxshopVisitingPhoto.put('beforePhoto', "photo");
    boxshopVisitingPhoto.put('afterPhoto', "photo");

    box.put("manavShopForm",0);
  }
  else if(grup==2){
    boxshopVisitingPhoto.put('beforePhoto', "photo");
    boxshopVisitingPhoto.put('afterPhoto', "photo");

    box.put("breadGroupForm",0);
    box.put("frozenGroupForm",0);
    box.put("tatbakGroupForm",0);
  }
}

