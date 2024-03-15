import 'package:deneme/constants/constants.dart';
import 'package:deneme/services/inCompleteTaskServices.dart';
import 'package:deneme/services/photoServices.dart';
import 'package:url_launcher/url_launcher.dart';
import '../main.dart';
import '../models/shop.dart';
import '../services/shopServices.dart';

Future createShopList(String url) async{
  final List<Shop> shops = await fetchShop2(url);
  for(int i=0; i<shops.length;i++){
    shopList.add("${shops[i].shopCode} ${shops[i].shopName}");
  }
}

Future saveShopCodes(String url) async{
  final List<Shop> shops = await fetchShop2(url);
  for(int i=0; i<shops.length;i++){
    if(i==shops.length-1&&shops[i].isActive==1){
      urlTaskShops=urlTaskShops+"magaza_kodu=${shops[i].shopCode}";
    }
    else if(shops[i].isActive==1){
      urlTaskShops=urlTaskShops+"magaza_kodu=${shops[i].shopCode}&";
    }
    box.get("shopCodes").add(shops[i].shopCode);
    shopCodes = box.get("shopCodes");
  }
}

void createShopTaskPhotoMap(){
  for(int i=0;i<box.get("shopCodes").length;i++){
    boxShopTaskPhoto.put(box.get("shopCodes")[i].toString(),["",false]);
  }
}

void resetTaskPhotos(){
  taskPhotos=[];
}

addIncompleteTaskToDatabase(String countTaskUrl, String title, String? detail, String assignmentDate, String finishDate, int? photo_id, String taskType, int? report_id, int group_no, String createTaskUrl,String countPhotoUrl, int? bs_id, int? pm_id, int? bm_id, String photoType, String createPhotoUrl) async{
  for(int i=0;i<shopCodes.length;i++){
    if(boxShopTaskPhoto.get(shopCodes[i].toString())[1]==true){
      await countIncompleteTask(countTaskUrl);
      await createIncompleteTask(incompleteTaskCount+1, title, detail, assignmentDate, finishDate, shopCodes[i], photo_id, taskType, report_id,group_no, createTaskUrl);
      if(boxShopTaskPhoto.get(shopCodes[i].toString())[0]!=""){
        await countPhoto(countPhotoUrl);
        await createPhoto(photoCount+1, incompleteTaskCount+1, shopCodes[i], bs_id, pm_id, bm_id, photoType, boxShopTaskPhoto.get(shopCodes[i].toString())[0],null, createPhotoUrl);
        updatePhotoIDIncompleteTask(incompleteTaskCount+1, title, detail, assignmentDate, finishDate, shopCodes[i], photoCount+1, taskType, report_id, group_no, "${constUrl}api/TamamlanmamisGorev/${incompleteTaskCount+1}");
      }
    }
  }
}

addReportTaskToDatabase(String countTaskUrl, String title, String? detail, String assignmentDate, String finishDate, int shopCode, int? photo_id, String taskType, int? report_id, int group_no, String createTaskUrl,String photo_file, int? bs_id, int? pm_id, int? bm_id, String photoType) async{
    await countIncompleteTask(countTaskUrl);
    await createIncompleteTask(incompleteTaskCount+1, title, detail, assignmentDate, finishDate, shopCode, photo_id, taskType, report_id,group_no, createTaskUrl);
    if(photo_file.isNotEmpty){
      await countPhoto("${constUrl}api/Fotograf");
      await createPhoto(photoCount+1, incompleteTaskCount+1, shopCode, bs_id, pm_id, bm_id, photoType, photo_file,null, "${constUrl}api/Fotograf");
      updatePhotoIDIncompleteTask(incompleteTaskCount+1, title, detail, assignmentDate, finishDate, shopCode, photoCount+1, taskType, report_id, group_no, "${constUrl}api/TamamlanmamisGorev/${incompleteTaskCount+1}");
    }
}

String calculateElapsedTime(DateTime startTime, DateTime endTime) {
  Duration difference = endTime.difference(startTime);

  int hours = difference.inHours;
  int minutes = (difference.inMinutes % 60);
  int seconds = (difference.inSeconds % 60);

  String elapsedTime = '$hours saat $minutes dakika $seconds saniye';
  return elapsedTime;
}

int calculateDaysBetweenDates(DateTime startDate, DateTime endDate) {
  Duration difference = endDate.difference(startDate);
  int days = difference.inDays;
  return days;
}

void openAppleMaps(double latitude, double longitude) async {
  final Uri appleMapsUrl = Uri.parse('https://maps.apple.com/?q=$latitude,$longitude');
  if (await canLaunchUrl(appleMapsUrl)) {
    await launchUrl(appleMapsUrl);
  } else {
    throw 'Apple Maps açılamadı';
  }
}

void openGoogleMaps(double latitude, double longitude) async {
  final Uri googleMapsUrl = Uri.parse('https://www.google.com/maps/place/$latitude,$longitude');
  if (await canLaunchUrl(googleMapsUrl)) {
    await launchUrl(googleMapsUrl);
  } else {
    throw 'Google Maps\'i başlatılamıyor.';
  }
}

