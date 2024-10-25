import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/constants.dart';
import '../models/tedarikZinciriShopForm.dart';

Future<List<TedarikZinciriForm>> parseJsonListTedarikZinciriForm(String jsonBody) async{
  List<dynamic> responseList = jsonDecode(jsonBody);
  List<TedarikZinciriForm> returnList = [];
  for (var element in responseList){
    returnList.add(TedarikZinciriForm.fromJson(element));
  }
  return returnList;
}

Future<List<TedarikZinciriForm>> fetchTedarikZinciriForm(String url) async {
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'api_key': apiKey,
    },
  );
  if (response.statusCode == 200) {
    return parseJsonListTedarikZinciriForm(response.body);
  } else {
    throw Exception('Failed to load TedarikZinciriForm List');
  }
}

Future<TedarikZinciriForm> fetchTedarikZinciriForm2(String url) async {
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'api_key': apiKey,
    },
  );
  if (response.statusCode == 200) {
    return TedarikZinciriForm.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load TedarikZinciriForm');
  }
}

Future<List<TedarikZinciriForm>> fetchTedarikZinciriForm3(String url) async {
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'api_key': apiKey,
    },
  );
  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = json.decode(response.body);
    List<TedarikZinciriForm> tedarikZinciriForm = jsonResponse.map((data) {
      return TedarikZinciriForm.fromJson(data);
    }).toList();
    return tedarikZinciriForm;
  } else {
    throw Exception('Failed to load TedarikZinciriForm List 2');
  }
}

Future<TedarikZinciriForm> createTedarikZinciriForm(int shopCode, String shopName, int? bs_id, int? pm_id, String savingDate, int fazla_urun, int toplatma, int fire_alani, int planogram, int g_spot, int sarkuteri, int dolap_stogu, int etiket, int skt_fiyat, int teshir_stant, int musteri_talebi, String url) async {
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
      "fazla_urun": fazla_urun,
      "toplatma": toplatma,
      "fire_alani": fire_alani,
      "planogram": planogram,
      "g_spot": g_spot,
      "sarkuteri": sarkuteri,
      "dolap_stogu": dolap_stogu,
      "etiket": etiket,
      "skt_fiyat": skt_fiyat,
      "teshir_stant": teshir_stant,
      "musteri_talebi": musteri_talebi,
    }
    ),
  );
  if (response.statusCode == 201) {
    return TedarikZinciriForm.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to create TedarikZinciriForm.');
  }
}