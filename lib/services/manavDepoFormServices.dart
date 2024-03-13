import 'dart:convert';
import 'package:deneme/models/manavDepoForm.dart';
import 'package:http/http.dart' as http;
import '../constants/constants.dart';

Future<List<ManavDepoForm>> parseJsonListIn(String jsonBody) async{
  List<dynamic> responseList = jsonDecode(jsonBody);
  List<ManavDepoForm> returnList = [];
  for (var element in responseList){
    returnList.add(ManavDepoForm.fromJson(element));
  }
  return returnList;
}

Future<List<ManavDepoForm>> fetchManavDepoForm(String url) async {
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'api_key': apiKey,
    },
  );
  if (response.statusCode == 200) {
    return parseJsonListIn(response.body);
  } else {
    throw Exception('Failed to load ManavDepoForm List');
  }
}

Future<ManavDepoForm> fetchManavDepoForm2(String url) async {
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'api_key': apiKey,
    },
  );
  if (response.statusCode == 200) {
    return ManavDepoForm.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load ManavDepoForm');
  }
}

Future<List<ManavDepoForm>> fetchManavDepoForm3(String url) async {
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'api_key': apiKey,
    },
  );
  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = json.decode(response.body);
    List<ManavDepoForm> manavDepoForm = jsonResponse.map((data) {
      return ManavDepoForm.fromJson(data);
    }).toList();
    return manavDepoForm;
  } else {
    throw Exception('Failed to load ManavDepoForm List 2');
  }
}

Future<ManavDepoForm> createManavDepoForm(
    int shopCode,
    int? bs_id,
    int? pm_id,
    String savingDate,
    int manav_sevkiyat,
    int bozuk_urun,
    int sb_cikislari,
    int sivas_birlik,
    int ana_kalem_urunleri,
    int siparis_sevk,
    int depo_stok,
    int kalan_urun,
    int kasa_alani,
    int depo_calisanlari,

    String url) async {
  final response = await http.post(Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'api_key': apiKey,
    },
    body: jsonEncode(<String, dynamic>
    {
      "magaza_kodu": shopCode,
      "bs_id": bs_id,
      "pm_id": pm_id,
      "kayit_tarihi": savingDate,
      "manav_sevkiyat": manav_sevkiyat,
      "bozuk_urun": bozuk_urun,
      "sb_cikislari": sb_cikislari,
      "sivas_birlik": sivas_birlik,
      "ana_kalem_urunleri": ana_kalem_urunleri,
      "siparis_sevk": siparis_sevk,
      "depo_stok": depo_stok,
      "kalan_urun": kalan_urun,
      "depo_calisanlari": depo_calisanlari,
    }
    ),
  );
  if (response.statusCode == 201) {
    return ManavDepoForm.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to create ManavDepoForm.');
  }
}