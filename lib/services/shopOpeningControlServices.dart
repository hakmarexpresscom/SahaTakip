import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../constants/constants.dart';
import '../models/shopOpeningControl.dart';

Future<List<InShopOpenControl>> parseJsonListIn(String jsonBody) async{
  List<dynamic> responseList = jsonDecode(jsonBody);
  List<InShopOpenControl> returnList = [];
  for (var element in responseList){
    returnList.add(InShopOpenControl.fromJson(element));
  }
  return returnList;
}

Future<List<InShopOpenControl>> fetchInShopOpenControl(String url) async {
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'api_key': apiKey,
    },
  );
  if (response.statusCode == 200) {
    return parseJsonListIn(response.body);
  } else {
    throw Exception('Failed to load InShopOpenControl List');
  }
}

Future<InShopOpenControl> fetchInShopOpenControl2(String url) async {
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'api_key': apiKey,
    },
  );
  if (response.statusCode == 200) {
    return InShopOpenControl.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load InShopOpenControl');
  }
}

Future<List<InShopOpenControl>> fetchInShopOpenControl3(String url) async {
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'api_key': apiKey,
    },
  );
  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = json.decode(response.body);
    List<InShopOpenControl> inShopOpenControls = jsonResponse.map((data) {
      return InShopOpenControl.fromJson(data);
    }).toList();
    return inShopOpenControls;
  } else {
    throw Exception('Failed to load InShopOpenControl List 2');
  }
}

Future<InShopOpenControl> createInShopOpenControl(int shopCode, String shopName, int? bs_id, int? pm_id, String savingDate, int gunluk_evrak, int kasiyer_defteri, int skt_kontrolu, int kasa_alti_poset, int kasa_alti_cop, int ofis_depo_kapi, int kasa_cekmecesi, int kasa_alti_resmi_evrak, int wc_musluk, int kasa_temizligi, int magaza_anahtari, int mutfak_wc_temizlik, int magaza_duzeni, int ofis_depo_cop, int priz_cihaz, int kamera_kaydi, int zemin_temizligi, int kasa_etrafi_duzeni, int manav_duzeni, int poset, int isitici_klima, String url) async {
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
        "gunluk_evrak": gunluk_evrak,
        "kasiyer_defteri": kasiyer_defteri,
        "skt_kontrolu": skt_kontrolu,
        "kasa_alti_poset": kasa_alti_poset,
        "kasa_alti_cop": kasa_alti_cop,
        "ofis_depo_kapi": ofis_depo_kapi,
        "kasa_cekmecesi": kasa_cekmecesi,
        "kasa_alti_resmi_evrak": kasa_alti_resmi_evrak,
        "wc_musluk": wc_musluk,
        "kasa_temizligi": kasa_temizligi,
        "magaza_anahtari": magaza_anahtari,
        "mutfak_wc_temizlik": mutfak_wc_temizlik,
        "magaza_duzeni": magaza_duzeni,
        "ofis_depo_cop": ofis_depo_cop,
        "priz_cihaz": priz_cihaz,
        "kamera_kaydi": kamera_kaydi,
        "zemin_temizligi": zemin_temizligi,
        "kasa_etrafi_duzeni": kasa_etrafi_duzeni,
        "manav_duzeni": manav_duzeni,
        "poset": poset,
        "isitici_klima": isitici_klima
      }
    ),
  );
  if (response.statusCode == 201) {
    return InShopOpenControl.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to create InShopOpenControl.');
  }
}

Future<void> downloadInShopOpenControlReport(String url) async {
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
      final fileName = 'AcilisKontroluMagazaIci${dateFormat.format(DateTime.now())}.xlsx';
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

//********************************************************


Future<List<OutShopOpenControl>> parseJsonListOut(String jsonBody) async{
  List<dynamic> responseList = jsonDecode(jsonBody);
  List<OutShopOpenControl> returnList = [];
  for (var element in responseList){
    returnList.add(OutShopOpenControl.fromJson(element));
  }
  return returnList;
}

Future<List<OutShopOpenControl>> fetchOutShopOpenControl(String url) async {
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'api_key': apiKey,
    },
  );
  if (response.statusCode == 200) {
    return parseJsonListOut(response.body);
  } else {
    throw Exception('Failed to load OutShopOpenControl List');
  }
}

Future<OutShopOpenControl> fetchOutShopOpenControl2(String url) async {
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'api_key': apiKey,
    },
  );
  if (response.statusCode == 200) {
    return OutShopOpenControl.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load OutShopOpenControl');
  }
}

Future<List<OutShopOpenControl>> fetchOutShopOpenControl3(String url) async {
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'api_key': apiKey,
    },
  );
  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = json.decode(response.body);
    List<OutShopOpenControl> outShopOpenControls = jsonResponse.map((data) {
      return OutShopOpenControl.fromJson(data);
    }).toList();
    return outShopOpenControls;
  } else {
    throw Exception('Failed to load OutShopOpenControl List 2');
  }
}

Future<OutShopOpenControl> createOutShopOpenControl(int shopCode, String shopName, int? bs_id, int? pm_id, String savingDate, int alarm, int personel_sayisi, int uygun_zaman, int kapi_kepenk, int anahtar, String url) async {
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
        "alarm": alarm,
        "personel_sayisi": personel_sayisi,
        "uygun_zaman": uygun_zaman,
        "kapi_kepenk": kapi_kepenk,
        "anahtar": anahtar,
      }
    ),
  );
  if (response.statusCode == 201) {
    return OutShopOpenControl.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to create OutShopOpenControl.');
  }
}

Future<void> downloadOutShopOpenControlReport(String url) async {
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
      final fileName = 'AcilisKontroluMagazaDisi${dateFormat.format(DateTime.now())}.xlsx';
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