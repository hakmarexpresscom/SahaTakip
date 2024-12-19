import 'package:deneme/utils/generalFunctions.dart';
import '../constants/constants.dart';
import '../main.dart';

synchronizationBoxData(String user, int grup) async{
  if(user=="Bölge Sorumlusu") {

    try {

      await saveShopCodes("${constUrl}api/MagazaV113${box.get("urlShopFilter")}=${userID}");
      await createShopTaskPhotoMapBS(grup);

    } catch (error) {
      throw Exception('Veri kaydında hata oluştu');
    }

  }
  else if(user=="Pazarlama Müdürü") {

    try {
      await saveShopCodes("${constUrl}api/MagazaV113${box.get("urlShopFilter")}=${userID}");

      if (grup == 0) {
        await saveBSID("${constUrl}api/MagazaV113${box.get("urlShopFilter")}=${userID}");
      }
      else if(grup==1){
        await saveBSManavID("${constUrl}api/MagazaV113${box.get("urlShopFilter")}=${userID}");
      }
      else if(grup==2){
        await saveBSUnkarID("${constUrl}api/MagazaV113${box.get("urlShopFilter")}=${userID}");
      }

      await saveBSName();
      await saveBSEmail();
      await createShopTaskPhotoMap(grup);

    } catch (error) {
      throw Exception('Veri kaydında hata oluştu');
    }

  }
  else if(user=="Bölge Müdürü") {

    try {
      await saveShopCodes("${constUrl}api/MagazaV113${box.get("urlShopFilter")}=${userID}");

      if (grup == 0) {
        await saveBSID("${constUrl}api/MagazaV113${box.get("urlShopFilter")}=${userID}");
      }
      else if(grup==1){
        await saveBSManavID("${constUrl}api/MagazaV113${box.get("urlShopFilter")}=${userID}");
      }

      await saveBSName();
      await saveBSEmail();
      await createShopTaskPhotoMap(grup);

    } catch (error) {
      throw Exception('Veri kaydında hata oluştu');
    }

  }

}