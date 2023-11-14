import 'dart:typed_data';
import 'package:deneme/constants/constants.dart';
import 'package:deneme/services/inCompleteTaskServices.dart';
import 'package:deneme/services/photoServices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_launcher_icons/utils.dart';
import 'package:image_picker/image_picker.dart';
import '../models/photo.dart';
import '../models/shop.dart';
import '../services/shopServices.dart';
import 'dart:io';
import 'dart:convert';

Future saveShopCodes(String url) async{
  final List<Shop> shops = await fetchShop2(url);
  for(int i=0; i<shops.length;i++){
    if(i==shops.length-1){
      urlTaskShops=urlTaskShops+"magaza_kodu=${shops[i].shopCode}";
    }
    else{
      urlTaskShops=urlTaskShops+"magaza_kodu=${shops[i].shopCode}&";
    }
    shopCodes.add(shops[i].shopCode);
  }
}

void createShopCheckboxMap(){
  for(int i=0;i<shopCodes.length;i++){
    shopCheckboxMap[shopCodes[i]]=false;
  }
}

void resetShopCheckboxMap(){
  for(int i=0;i<shopCodes.length;i++){
    shopCheckboxMap[shopCodes[i]]=false;
  }
}

addIncompleteTaskToDatabase(String countTaskUrl, String title, String detail, String assignmentDate, String finishDate, int? photo_id, String taskType, int? report_id, String createTaskUrl,XFile? image, String? path, String countPhotoUrl, int? bs_id, int? pm_id, int? bm_id, String photoType, String createPhotoUrl, String updateTaskUrl) async{
  for(int i=0;i<shopCodes.length;i++){
    if(shopCheckboxMap[shopCodes[i]]==true){
      await countIncompleteTask(countTaskUrl);
      await createIncompleteTask(incompleteTaskCount+1, title, detail, assignmentDate, finishDate, shopCodes[i], photo_id, taskType, report_id, createTaskUrl);
    }
    if(image!=null){
      final bytes = File(path!).readAsBytesSync();
      String photo_file =  base64Encode(bytes);
      await countPhoto(countPhotoUrl);
      await createPhoto(photoCount+1, incompleteTaskCount+1, shopCodes[i], bs_id, pm_id, bm_id, photoType, photo_file, createPhotoUrl);
      await updatePhotoIDIncompleteTask(incompleteTaskCount+1, title, detail, assignmentDate, finishDate, shopCodes[i], photoCount+1, taskType, report_id, updateTaskUrl);
    }
  }
}



