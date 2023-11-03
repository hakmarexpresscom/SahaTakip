import 'package:deneme/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import '../models/shop.dart';
import '../services/shopServices.dart';

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
  print(urlTaskShops);
}