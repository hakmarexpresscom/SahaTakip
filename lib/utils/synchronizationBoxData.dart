import 'package:deneme/utils/generalFunctions.dart';
import '../constants/constants.dart';
import '../main.dart';
import '../models/userBM.dart';
import '../models/userBS.dart';
import '../models/userPM.dart';
import '../services/userBMServices.dart';
import '../services/userBSServices.dart';
import '../services/userPMServices.dart';

synchronizationBoxData(String user, int grup) async{

  if(user=="Bölge Sorumlusu") {

    final UserBS userBS = await fetchUserBS3("${constUrl}api/KullaniciBS/${userID}");

    box.put("userID",userBS.bs_id);
    userID=box.get("userID");

    box.put("groupNo",userBS.group_no);
    groupNo=box.get("groupNo");

    box.put("regionCode",userBS.bolge);
    regionCode=box.get("regionCode");

    box.put("yoneticiID", userBS.manager_id);
    yoneticiID = box.get("yoneticiID");

    box.put("userEmail", userBS.email);
    userEmail = box.get("userEmail");

    box.put("userFullName", userBS.userName+" "+userBS.userSurname);
    userFullName = box.get("userFullName");

    final UserPM userPM = await fetchUserPM3("${constUrl}api/KullaniciPM/${yoneticiID}");
    final UserBM userBM = await fetchUserBM3("${constUrl}api/KullaniciBM/${userPM.manager_id}");

    box.put("PMEmail", userPM.email);
    PMEmail = box.get("PMEmail");

    box.put("BMEmail", userBM.email);
    BMEmail = box.get("BMEmail");

    if(grup==0){
      urlShopFilter = "/byBsId?bs_id";
      box.put("urlShopFilter", urlShopFilter);
    }
    else if(grup==1){
      urlShopFilter = "/byBsManavId?bs_manav_id";
      box.put("urlShopFilter", urlShopFilter);
    }
    else if(grup==2){
      urlShopFilter = "/byBsUnkarId?bs_unkar_id";
      box.put("urlShopFilter", urlShopFilter);
    }
    else if(grup==3){
      urlShopFilter = "/byBsTedarikId?bs_tedarik_id";
      box.put("urlShopFilter", urlShopFilter);
    }

    try {

      await saveShopCodes("${constUrl}api/MagazaV113${box.get("urlShopFilter")}=${userID}");
      await createShopTaskPhotoMapBS(grup);

    } catch (error) {
      throw Exception('Veri kaydında hata oluştu');
    }

  }

  else if(user=="Pazarlama Müdürü") {

    final UserPM userPM = await fetchUserPM3("${constUrl}api/KullaniciPM/${userID}");

    box.put("userID",userPM.pm_id);
    userID=box.get("userID");

    box.put("groupNo",userPM.group_no);
    groupNo=box.get("groupNo");

    box.put("regionCode",userPM.bolge);
    regionCode=box.get("regionCode");

    box.put("yoneticiID", userPM.manager_id);
    yoneticiID = box.get("yoneticiID");

    box.put("userEmail", userPM.email);
    userEmail = box.get("userEmail");

    box.put("userFullName", userPM.userName+" "+userPM.userSurname);
    userFullName = box.get("userFullName");

    final UserBM userBM = await fetchUserBM3("${constUrl}api/KullaniciBM/${yoneticiID}");

    box.put("BMEmail", userBM.email);
    BMEmail = box.get("BMEmail");

    if(grup==0){
      urlShopFilter = "/byPmId?Pm_id";
      box.put("urlShopFilter", urlShopFilter);
    }
    else if(grup==1){
      urlShopFilter = "/byPmManavId?pm_manav_id";
      box.put("urlShopFilter", urlShopFilter);
    }
    else if(grup==2){
      urlShopFilter = "/byPmUnkarId?pm_unkar_id";
      box.put("urlShopFilter", urlShopFilter);
    }

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

    final UserBM userBM = await fetchUserBM3("${constUrl}api/KullaniciBM/${userID}");

    box.put("userID",userBM.bm_id);
    userID=box.get("userID");

    box.put("groupNo",userBM.group_no);
    groupNo=box.get("groupNo");

    box.put("userEmail", userBM.email);
    userEmail = box.get("userEmail");

    box.put("userFullName", userBM.userName+" "+userBM.userSurname);
    userFullName = box.get("userFullName");

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