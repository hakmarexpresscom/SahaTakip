import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import '../constants/constants.dart';
import '../models/cashCounting.dart';
import 'package:path_provider/path_provider.dart';

Future<List<CashCounting>> parseJsonListOut(String jsonBody) async{
  List<dynamic> responseList = jsonDecode(jsonBody);
  List<CashCounting> returnList = [];
  for (var element in responseList){
    returnList.add(CashCounting.fromJson(element));
  }
  return returnList;
}

Future<List<CashCounting>> fetchCashCounting(String url) async {
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'api_key': apiKey,
    },
  );
  if (response.statusCode == 200) {
    return parseJsonListOut(response.body);
  } else {
    throw Exception('Failed to load CashCounting List');
  }
}

Future<CashCounting> fetchCashCounting2(String url) async {
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'api_key': apiKey,
    },
  );
  if (response.statusCode == 200) {
    return CashCounting.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load CashCounting');
  }
}

Future<List<CashCounting>> fetchCashCounting3(String url) async {
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'api_key': apiKey,
    },
  );
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

Future<CashCounting> createCashCounting(int shopCode, String shopName, int? bs_id, int? pm_id, String savingDate, String kagit_para_sayimi, String madeni_para_sayimi, String poslar_toplami, String masraflar_tediyeler, String celik_kasa_mevcudu, String kasa_defter_mevcudu, String fark, String url) async {
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

Future<void> downloadCashCountingReport(String url) async {
  try {
    final dio = Dio();

    final response = await dio.get(url,
        options: Options(
            headers: {'api_key': apiKey},
            responseType: ResponseType.bytes));

    if (response.statusCode == 200) {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/CelikKasaSayimi.xlsx');
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