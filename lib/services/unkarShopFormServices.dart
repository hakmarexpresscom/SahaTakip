import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/constants.dart';
import '../models/unkarShopForm.dart';

Future<List<BreadGroupForm>> parseJsonListBread(String jsonBody) async{
  List<dynamic> responseList = jsonDecode(jsonBody);
  List<BreadGroupForm> returnList = [];
  for (var element in responseList){
    returnList.add(BreadGroupForm.fromJson(element));
  }
  return returnList;
}

Future<List<BreadGroupForm>> fetchBreadGroupForm(String url) async {
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'api_key': apiKey,
    },
  );
  if (response.statusCode == 200) {
    return parseJsonListBread(response.body);
  } else {
    throw Exception('Failed to load BreadGroupForm List');
  }
}

Future<BreadGroupForm> fetchBreadGroupForm2(String url) async {
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'api_key': apiKey,
    },
  );
  if (response.statusCode == 200) {
    return BreadGroupForm.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load BreadGroupForm');
  }
}

Future<List<BreadGroupForm>> fetchBreadGroupForm3(String url) async {
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'api_key': apiKey,
    },
  );
  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = json.decode(response.body);
    List<BreadGroupForm> breadGroupForm = jsonResponse.map((data) {
      return BreadGroupForm.fromJson(data);
    }).toList();
    return breadGroupForm;
  } else {
    throw Exception('Failed to load BreadGroupForm List 2');
  }
}

Future<BreadGroupForm> createBreadGroupForm(int shopCode, String shopName, int? bs_id, int? pm_id, String savingDate, int manav_sevkiyat, int etiket, int dolap_temizligi, int eldiven_poset, int gelis_saati, int iade, int sicak_ekmek, int hanser_aykan, int uno, int kati_grup, String url) async {
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
      "manav_sevkiyat": manav_sevkiyat,
      "etiket": etiket,
      "dolap_temizligi": dolap_temizligi,
      "eldiven_poset": eldiven_poset,
      "gelis_saati": gelis_saati,
      "iade": iade,
      "sicak_ekmek": sicak_ekmek,
      "hanser_aykan": hanser_aykan,
      "uno": uno,
      "kati_grup": kati_grup,
    }
    ),
  );
  if (response.statusCode == 201) {
    return BreadGroupForm.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to create BreadGroupForm.');
  }
}

//-------------------------------------

Future<List<TatbakGroupForm>> parseJsonListTatbak(String jsonBody) async{
  List<dynamic> responseList = jsonDecode(jsonBody);
  List<TatbakGroupForm> returnList = [];
  for (var element in responseList){
    returnList.add(TatbakGroupForm.fromJson(element));
  }
  return returnList;
}

Future<List<TatbakGroupForm>> fetchTatbakGroupForm(String url) async {
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'api_key': apiKey,
    },
  );
  if (response.statusCode == 200) {
    return parseJsonListTatbak(response.body);
  } else {
    throw Exception('Failed to load TatbakGroupForm List');
  }
}

Future<TatbakGroupForm> fetchTatbakGroupForm2(String url) async {
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'api_key': apiKey,
    },
  );
  if (response.statusCode == 200) {
    return TatbakGroupForm.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load TatbakGroupForm');
  }
}

Future<List<TatbakGroupForm>> fetchTatbakGroupForm3(String url) async {
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'api_key': apiKey,
    },
  );
  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = json.decode(response.body);
    List<TatbakGroupForm> tatbakGroupForm = jsonResponse.map((data) {
      return TatbakGroupForm.fromJson(data);
    }).toList();
    return tatbakGroupForm;
  } else {
    throw Exception('Failed to load TatbakGroupForm List 2');
  }
}

Future<TatbakGroupForm> createTatbakGroupForm(int shopCode, String shopName, int? bs_id, int? pm_id, String savingDate, int urun, int blok, int fifo, int etiket, int haftalik_urun, int afis, int havuz_dolabi, int fire_cikisi, int siparis_oneri, int raf_temizligi, String url) async {
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
      "urun": urun,
      "blok": blok,
      "fifo": fifo,
      "etiket": etiket,
      "haftalik_urun": haftalik_urun,
      "afis": afis,
      "havuz_dolabi": havuz_dolabi,
      "fire_cikisi": fire_cikisi,
      "siparis_oneri": siparis_oneri,
      "raf_temizligi": raf_temizligi,
    }
    ),
  );
  if (response.statusCode == 201) {
    return TatbakGroupForm.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to create TatbakGroupForm.');
  }
}

//-------------------------------------

Future<List<FrozenGroupForm>> parseJsonListFrozen(String jsonBody) async{
  List<dynamic> responseList = jsonDecode(jsonBody);
  List<FrozenGroupForm> returnList = [];
  for (var element in responseList){
    returnList.add(FrozenGroupForm.fromJson(element));
  }
  return returnList;
}

Future<List<FrozenGroupForm>> fetchFrozenGroupForm(String url) async {
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'api_key': apiKey,
    },
  );
  if (response.statusCode == 200) {
    return parseJsonListFrozen(response.body);
  } else {
    throw Exception('Failed to load FrozenGroupForm List');
  }
}

Future<FrozenGroupForm> fetchFrozenGroupForm2(String url) async {
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'api_key': apiKey,
    },
  );
  if (response.statusCode == 200) {
    return FrozenGroupForm.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load FrozenGroupForm');
  }
}

Future<List<FrozenGroupForm>> fetchFrozenGroupFormm3(String url) async {
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'api_key': apiKey,
    },
  );
  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = json.decode(response.body);
    List<FrozenGroupForm> frozenGroupForm = jsonResponse.map((data) {
      return FrozenGroupForm.fromJson(data);
    }).toList();
    return frozenGroupForm;
  } else {
    throw Exception('Failed to load FrozenGroupForm List 2');
  }
}

Future<FrozenGroupForm> createFrozenGroupForm(int shopCode, String shopName, int? bs_id, int? pm_id, String savingDate, int dolap_duzeni, int tel_takimlari, int dolap_seviyeleri, int siparis_oneri, int etiket, int bozuk_urun, int dolap_derecesi, String url) async {
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
      "dolap_duzeni": dolap_duzeni,
      "tel_takimlari": tel_takimlari,
      "dolap_seviyeleri": dolap_seviyeleri,
      "siparis_oneri": siparis_oneri,
      "etiket": etiket,
      "bozuk_urun": bozuk_urun,
      "dolap_derecesi": dolap_derecesi,
    }
    ),
  );
  if (response.statusCode == 201) {
    return FrozenGroupForm.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to create FrozenGroupForm.');
  }
}
