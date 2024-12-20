import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../constants/constants.dart';
import '../models/shopClosingControl.dart';

Future<List<InShopCloseControl>> parseJsonListIn(String jsonBody) async{
  List<dynamic> responseList = jsonDecode(jsonBody);
  List<InShopCloseControl> returnList = [];
  for (var element in responseList){
    returnList.add(InShopCloseControl.fromJson(element));
  }
  return returnList;
}

Future<List<InShopCloseControl>> fetchInShopCloseControl(String url) async {
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'api_key': apiKey,
    },
  );
  if (response.statusCode == 200) {
    return parseJsonListIn(response.body);
  } else {
    throw Exception('Failed to load InShopCloseControl List');
  }
}

Future<InShopCloseControl> fetchInShopCloseControl2(String url) async {
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'api_key': apiKey,
    },
  );
  if (response.statusCode == 200) {
    return InShopCloseControl.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load InShopCloseControl');
  }
}

Future<List<InShopCloseControl>> fetchInShopCloseControl3(String url) async {
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'api_key': apiKey,
    },
  );
  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = json.decode(response.body);
    List<InShopCloseControl> inShopCloseControls = jsonResponse.map((data) {
      return InShopCloseControl.fromJson(data);
    }).toList();
    return inShopCloseControls;
  } else {
    throw Exception('Failed to load InShopCloseControl List 2');
  }
}

Future<InShopCloseControl> createInShopCloseControl(int shopCode, String shopName, int? bs_id, int? pm_id, String savingDate, int priz_cihaz, int dolap_aydinlatma, int kamera_kayit, int mutfak_wc_temizlik, int kasa_cekmece, int kasa_alti_poset, int kasa_etrafi_duzeni, int magaza_duzeni, int wc_musluk, int gunluk_evrak, int zemin_temizligi, int ofis_depo_kapi, int isitici_klima, int ofis_depo_cop, int kasa_alti_resmi_evrak, int kasa_temizligi, int kasiyer_defteri, int stk_kontrolu, int manav_duzeni, int kasa_alti_cop, String url) async {
  final response = await http.post(Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'api_key': apiKey,
    },
    body: jsonEncode(<String, dynamic>
      {
        "magaza_kodu": shopCode,
        "magaza_ismi": shopName,
        "bs_id": bs_id,
        "pm_id": pm_id,
        "kayit_tarihi": savingDate,
        "priz_cihaz": priz_cihaz,
        "dolap_aydinlatma": dolap_aydinlatma,
        "kamera_kayit": kamera_kayit,
        "mutfak_wc_temizlik": mutfak_wc_temizlik,
        "kasa_cekmece": kasa_cekmece,
        "kasa_alti_poset": kasa_alti_poset,
        "kasa_etrafi_duzeni": kasa_etrafi_duzeni,
        "magaza_duzeni": magaza_duzeni,
        "wc_musluk" : wc_musluk,
        "gunluk_evrak" : gunluk_evrak,
        "zemin_temizligi": zemin_temizligi,
        "ofis_depo_kapi": ofis_depo_kapi,
        "isitici_klima": isitici_klima,
        "ofis_depo_cop": ofis_depo_cop,
        "kasa_alti_resmi_evrak": kasa_alti_resmi_evrak,
        "kasa_temizligi": kasa_temizligi,
        "kasiyer_defteri": kasiyer_defteri,
        "stk_kontrolu": stk_kontrolu,
        "manav_duzeni": manav_duzeni,
        "kasa_alti_cop" : kasa_alti_cop,
      }
    ),
  );
  if (response.statusCode == 201) {
    return InShopCloseControl.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to create InShopCloseControl.');
  }
}

Future<void> downloadInShopCloseControlReport(String url) async {
  try {
    final dio = Dio();

    final response = await dio.get(url,
        options: Options(
            headers: {'api_key': apiKey},
            responseType: ResponseType.bytes));

    if (response.statusCode == 200) {
      final downloadDir = Directory('/storage/emulated/0/Download');

      if (!await downloadDir.exists()) {
        await downloadDir.create(recursive: true);
      }

      final dateFormat = DateFormat('yyyyMMddHHmmss');
      final fileName = 'KapanisKontroluMagazaIci${dateFormat.format(DateTime.now())}.xlsx';
      final file = File('${downloadDir.path}/$fileName');
      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();

      // Notify user of successful download
      print("File downloaded to: ${file.path}");
    } else {
      throw Exception('Failed to download file');
    }
  } catch (e) {
    print('Error: $e');
    throw e;
  }
}

//-------------------------------------

Future<List<OutShopCloseControl>> parseJsonListOut(String jsonBody) async{
  List<dynamic> responseList = jsonDecode(jsonBody);
  List<OutShopCloseControl> returnList = [];
  for (var element in responseList){
    returnList.add(OutShopCloseControl.fromJson(element));
  }
  return returnList;
}

Future<List<OutShopCloseControl>> fetchOutShopCloseControl(String url) async {
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'api_key': apiKey,
    },
  );
  if (response.statusCode == 200) {
    return parseJsonListOut(response.body);
  } else {
    throw Exception('Failed to load OutShopCloseControl List');
  }
}

Future<OutShopCloseControl> fetchOutShopCloseControl2(String url) async {
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'api_key': apiKey,
    },
  );
  if (response.statusCode == 200) {
    return OutShopCloseControl.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load OutShopCloseControl');
  }
}

Future<List<OutShopCloseControl>> fetchOutShopCloseControl3(String url) async {
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'api_key': apiKey,
    },
  );
  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = json.decode(response.body);
    List<OutShopCloseControl> outShopCloseControls = jsonResponse.map((data) {
      return OutShopCloseControl.fromJson(data);
    }).toList();
    return outShopCloseControls;
  } else {
    throw Exception('Failed to load OutShopCloseControl List 2');
  }
}

Future<OutShopCloseControl> createOutShopCloseControl(int shopCode, String shopName, int? bs_id, int? pm_id, String savingDate, int magaza_karartma, int zemin_temizligi, int alarm, int dolap_perde, int calisan_ayrilma_zamani, int kapi_kepenk, int son_musteri, int kasa_cikisi, String url) async {
  final response = await http.post(Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'api_key': apiKey,
    },
    body: jsonEncode(<String, dynamic>
      {
        "magaza_kodu": shopCode,
        "magaza_ismi": shopName,
        "bs_id": bs_id,
        "pm_id": pm_id,
        "kayit_tarihi": savingDate,
        "magaza_karartma": magaza_karartma,
        "zemin_temizligi": zemin_temizligi,
        "alarm": alarm,
        "dolap_perde": dolap_perde,
        "calisan_ayrilma_zamani": calisan_ayrilma_zamani,
        "kapi_kepenk" : kapi_kepenk,
        "son_musteri" : son_musteri,
        "kasa_cikisi" : kasa_cikisi
      }
    ),
  );
  if (response.statusCode == 201) {
    return OutShopCloseControl.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to create OutShopCloseControl.');
  }
}

Future<void> downloadOutShopCloseControlReport(String url) async {
  try {
    final dio = Dio();

    final response = await dio.get(url,
        options: Options(
            headers: {'api_key': apiKey},
            responseType: ResponseType.bytes));

    if (response.statusCode == 200) {
      final downloadDir = Directory('/storage/emulated/0/Download');

      if (!await downloadDir.exists()) {
        await downloadDir.create(recursive: true);
      }

      final dateFormat = DateFormat('yyyyMMddHHmmss');
      final fileName = 'KapanisKontroluMagazaDisi${dateFormat.format(DateTime.now())}.xlsx';
      final file = File('${downloadDir.path}/$fileName');
      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();

      // Notify user of successful download
      print("File downloaded to: ${file.path}");
    } else {
      throw Exception('Failed to download file');
    }
  } catch (e) {
    print('Error: $e');
    throw e;
  }
}