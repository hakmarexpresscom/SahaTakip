import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/constants.dart';
import '../models/shopVisitingFormAnswers.dart';

Future<List<ShopVisitingFormAnswers>> parseJsonListOut(String jsonBody) async{
  List<dynamic> responseList = jsonDecode(jsonBody);
  List<ShopVisitingFormAnswers> returnList = [];
  for (var element in responseList){
    returnList.add(ShopVisitingFormAnswers.fromJson(element));
  }
  return returnList;
}

Future<List<ShopVisitingFormAnswers>> fetchShopVisitingFormAnswers(String url) async {
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'api_key': apiKey,
    },
  );
  if (response.statusCode == 200) {
    return parseJsonListOut(response.body);
  } else {
    throw Exception('Failed to load ShopVisitingFormAnswers List');
  }
}

Future<ShopVisitingFormAnswers> fetchShopVisitingFormAnswers2(String url) async {
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'api_key': apiKey,
    },
  );
  if (response.statusCode == 200) {
    return ShopVisitingFormAnswers.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load ShopVisitingFormAnswers');
  }
}

Future<List<ShopVisitingFormAnswers>> fetchShopVisitingFormAnswers3(String url) async {
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'api_key': apiKey,
    },
  );
  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = json.decode(response.body);
    List<ShopVisitingFormAnswers> shopVisitingFormatAnswers = jsonResponse.map((data) {
      return ShopVisitingFormAnswers.fromJson(data);
    }).toList();
    return shopVisitingFormatAnswers;
  } else {
    throw Exception('Failed to load ShopVisitingFormAnswers List 2');
  }
}

Future<ShopVisitingFormAnswers> createShopVisitingFormAnswers(int? bs_id, int? pm_id, int shopCode, String savingDate, String formAnswers, String url) async {
  final response = await http.post(Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'api_key': apiKey,
    },
    body: jsonEncode(<String, dynamic>
    {
      "bs_id": bs_id,
      "pm_id": pm_id,
      "magaza_kodu": shopCode,
      "kayit_tarihi": savingDate,
      "cevaplar" : formAnswers,
    }
    ),
  );
  if (response.statusCode == 201) {
    return ShopVisitingFormAnswers.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to create ShopVisitingFormAnswers');
  }
}