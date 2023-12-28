import 'package:deneme/constants/constants.dart';
import 'package:deneme/services/inCompleteTaskServices.dart';
import 'package:deneme/services/photoServices.dart';
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
    if(i==shops.length-1){
      urlTaskShops=urlTaskShops+"magaza_kodu=${shops[i].shopCode}";
    }
    else{
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

Future<void> addIncompleteTaskToDatabase(String countTaskUrl, String title, String detail, String assignmentDate, String finishDate, int? photo_id, String taskType, int? report_id, int group_no, String createTaskUrl,String countPhotoUrl, int? bs_id, int? pm_id, int? bm_id, String photoType, String createPhotoUrl, String updateTaskUrl) async{
  for(int i=0;i<shopCodes.length;i++){
    if(shopTaskPhotoMap[shopCodes[i]][1]==true){
      await countIncompleteTask(countTaskUrl);
      await createIncompleteTask(incompleteTaskCount+1, title, detail, assignmentDate, finishDate, shopCodes[i], photo_id, taskType, report_id,group_no, createTaskUrl);
      if(shopTaskPhotoMap[shopCodes[i]][0]!=null){
        await countPhoto(countPhotoUrl);
        await createPhoto(photoCount+1, incompleteTaskCount+1, shopCodes[i], bs_id, pm_id, bm_id, photoType, shopTaskPhotoMap[shopCodes[i]][0],null, createPhotoUrl);
        await updatePhotoIDIncompleteTask(incompleteTaskCount+1, title, detail, assignmentDate, finishDate, shopCodes[i], photoCount+1, taskType, report_id, group_no, updateTaskUrl);
      }
    }
  }
}

addReportTaskToDatabase(String countTaskUrl, String title, String detail, String assignmentDate, String finishDate, int shopCode, int? photo_id, String taskType, int? report_id, int group_no, String createTaskUrl,String photo_file, int? bs_id, int? pm_id, int? bm_id, String photoType, String updatePhotoUrl) async{
    await countIncompleteTask(countTaskUrl);
    if(photo_file.isNotEmpty){
      await createIncompleteTask(incompleteTaskCount+1, title, detail, assignmentDate, finishDate, shopCode, photoCount+1, taskType, report_id, group_no, createTaskUrl);
      await updateIncompleteTaskIDPhoto(photo_id!, incompleteTaskCount+1, shopCode, bs_id, pm_id, bm_id, photoType, photo_file, null, updatePhotoUrl);
    }
    else if(photo_file.isEmpty){
      await createIncompleteTask(incompleteTaskCount+1, title, detail, assignmentDate, finishDate, shopCode, null, taskType, report_id, group_no, createTaskUrl);
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



