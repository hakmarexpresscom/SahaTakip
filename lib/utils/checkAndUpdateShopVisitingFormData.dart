import '../constants/constants.dart';
import '../main.dart';
import '../models/shopVisitingFormBS.dart';
import '../models/shopVisitingFormPM.dart';
import '../services/shopVisitingFormBSServices.dart';
import '../services/shopVisitingFormPMServices.dart';

Future<void> checkAndUpdateVisitingFormData(bool isBS) async {
  // Güncel shopCodes'u alın
  final List<dynamic> newShopCodes = box.get("shopCodes");

  // Mevcut shopCodes anahtarlarını alın
  final List<dynamic> existingKeys = isBS
      ? boxBSSatisOperasyonShopVisitingFormShops.toMap().keys.toList()
      : boxPMSatisOperasyonShopVisitingFormShops.toMap().keys.toList();

  if (isBS) {
    // API'den güncel shopVisitingFormBS verilerini alın
    final List<ShopVisitingFormBS> currentShopVisitingFormBS =
    await fetchShopVisitingFormBS3('${constUrl}api/MagazaZiyaretFormuBS');

    // Mevcut verilerden itemName'leri alın
    final Map<dynamic, dynamic> existingQuestions = boxBSSatisOperasyonShopVisitingFormShops
        .get("questions", defaultValue: {});

    // Eklenen veya silinen itemName'leri kontrol edin
    final List<String> addedItemNames = currentShopVisitingFormBS
        .where((item) => !existingQuestions.containsValue(item.itemName))
        .map((item) => item.itemName)
        .toList();

    final List<String> deletedItemNames = existingQuestions.values
        .cast<String>() // values listesini String'e çevir
        .where((name) => currentShopVisitingFormBS.every((item) => item.itemName != name))
        .toList();

    // Eklenen shopCodes'u kontrol edin
    final List<dynamic> addedShopCodes = newShopCodes
        .where((code) => !existingKeys.contains(code))
        .toList();

    // Güncelleme işlemleri
    if (addedItemNames.isNotEmpty || deletedItemNames.isNotEmpty || addedShopCodes.isNotEmpty) {
      // Var olan veriyi güncelle
      for (var code in newShopCodes) {
        final currentData = boxBSSatisOperasyonShopVisitingFormShops.get(code, defaultValue: {});

        // Eklenen itemName'leri mevcut verilere ekle
        for (var item in currentShopVisitingFormBS) {
          if (!currentData.containsKey(item.itemID.toString())) {
            currentData[item.itemID.toString()] = ["test", "0"];
          }
        }

        // Silinen itemName'leri mevcut verilerden kaldır
        for (var deletedName in deletedItemNames) {
          final idToRemove = existingQuestions.keys
              .firstWhere((key) => existingQuestions[key] == deletedName, orElse: () => null);
          if (idToRemove != null) {
            currentData.remove(idToRemove.toString());
          }
        }

        // Güncellenen veriyi kaydet
        await boxBSSatisOperasyonShopVisitingFormShops.put(code, currentData);
      }

      // Silinen itemName'leri questions'dan kaldır
      for (var deletedName in deletedItemNames) {
        final idToRemove = existingQuestions.keys
            .firstWhere((key) => existingQuestions[key] == deletedName, orElse: () => null);
        if (idToRemove != null) {
          existingQuestions.remove(idToRemove);
        }
      }

      // Eklenen itemName'leri questions'a ekle
      for (var item in currentShopVisitingFormBS) {
        if (!existingQuestions.containsValue(item.itemName)) {
          existingQuestions[item.itemID] = item.itemName;
        }
      }

      // Güncellenen questions'ı kaydet
      await boxBSSatisOperasyonShopVisitingFormShops.put("questions", existingQuestions);
    }
  } else {
    // API'den güncel shopVisitingFormPM verilerini alın
    final List<ShopVisitingFormPM> currentShopVisitingFormPM =
    await fetchShopVisitingFormPM3('${constUrl}api/MagazaZiyaretFormuPMV122');

    // Mevcut verilerden itemName'leri alın
    final Map<dynamic, dynamic> existingQuestions = boxPMSatisOperasyonShopVisitingFormShops
        .get("questions", defaultValue: {});

    // Eklenen veya silinen itemName'leri kontrol edin
    final List<String> addedItemNames = currentShopVisitingFormPM
        .where((item) => !existingQuestions.containsValue(item.itemName))
        .map((item) => item.itemName)
        .toList();

    final List<String> deletedItemNames = existingQuestions.values
        .cast<String>() // values listesini String'e çevir
        .where((name) => currentShopVisitingFormPM.every((item) => item.itemName != name))
        .toList();

    // Eklenen shopCodes'u kontrol edin
    final List<dynamic> addedShopCodes = newShopCodes
        .where((code) => !existingKeys.contains(code))
        .toList();

    // Güncelleme işlemleri
    if (addedItemNames.isNotEmpty || deletedItemNames.isNotEmpty || addedShopCodes.isNotEmpty) {
      for (var code in newShopCodes) {
        final currentData = boxPMSatisOperasyonShopVisitingFormShops.get(code, defaultValue: {});

        // Eklenen itemName'leri mevcut verilere ekle
        for (var item in currentShopVisitingFormPM) {
          if (!currentData.containsKey(item.itemID.toString())) {
            currentData[item.itemID.toString()] = ["test", "0"];
          }
        }

        // Silinen itemName'leri mevcut verilerden kaldır
        for (var deletedName in deletedItemNames) {
          final idToRemove = existingQuestions.keys
              .firstWhere((key) => existingQuestions[key] == deletedName, orElse: () => null);
          if (idToRemove != null) {
            currentData.remove(idToRemove.toString());
          }
        }

        // Güncellenen veriyi kaydet
        await boxPMSatisOperasyonShopVisitingFormShops.put(code, currentData);
      }

      // Silinen itemName'leri questions'dan kaldır
      for (var deletedName in deletedItemNames) {
        final idToRemove = existingQuestions.keys
            .firstWhere((key) => existingQuestions[key] == deletedName, orElse: () => null);
        if (idToRemove != null) {
          existingQuestions.remove(idToRemove);
        }
      }

      // Eklenen itemName'leri questions'a ekle
      for (var item in currentShopVisitingFormPM) {
        if (!existingQuestions.containsValue(item.itemName)) {
          existingQuestions[item.itemID] = item.itemName;
        }
      }

      // Güncellenen questions'ı kaydet
      await boxPMSatisOperasyonShopVisitingFormShops.put("questions", existingQuestions);
    }
  }
}