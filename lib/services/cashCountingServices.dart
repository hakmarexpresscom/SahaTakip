import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/cashCounting.dart';
import '../models/shopOpeningControl.dart';

Future<List<CashCounting>> parseJsonListOut(String jsonBody) async{
  List<dynamic> responseList = jsonDecode(jsonBody);
  List<CashCounting> returnList = [];
  for (var element in responseList){
    returnList.add(CashCounting.fromJson(element));
  }
  return returnList;
}

Future<List<CashCounting>> fetchCashCounting(String url) async {
  final response = await http
      .get(Uri.parse(url));
  if (response.statusCode == 200) {
    return parseJsonListOut(response.body);
  } else {
    throw Exception('Failed to load CashCounting List');
  }
}

Future<CashCounting> fetchCashCounting2(String url) async {
  final response = await http
      .get(Uri.parse(url));
  if (response.statusCode == 200) {
    return CashCounting.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load CashCounting');
  }
}

Future<List<CashCounting>> fetchCashCounting3(String url) async {
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = json.decode(response.body);
    List<CashCounting> cashCountings = jsonResponse.map((data) {
      return CashCounting.fromJson(data);
    }).toList();
    return cashCountings;
  } else {
    throw Exception('Failed to load CashCounting List 2');
  }
}

Future<CashCounting> createCashCounting(int shopCode, int? bs_id, int? pm_id, String savingDate, String kagit_para_sayimi, String madeni_para_sayimi, String poslar_toplami, String masraflar_tediyeler, String celik_kasa_mevcudu, String kasa_defter_mevcudu, String fark, String url) async {
  final response = await http.post(Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>
      {
        "magaza_kodu": shopCode,
        "bs_id": bs_id,
        "pm_id": pm_id,
        "kayit_tarihi": savingDate,
        "kagit_para_sayimi" : kagit_para_sayimi,
        "madeni_para_sayimi" : madeni_para_sayimi,
        "poslar_toplami" : poslar_toplami,
        "masraflar_tediyeler" : masraflar_tediyeler,
        "celik_kasa_mevcudu" : celik_kasa_mevcudu,
        "kasa_defter_mevcudu" : kasa_defter_mevcudu,
        "fark" : fark
      }
    ),
  );
  if (response.statusCode == 201) {
    return CashCounting.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to create CashCounting');
  }
}