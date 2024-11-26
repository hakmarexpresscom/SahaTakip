import 'dart:convert';
import '../constants/constants.dart';
import 'package:http/http.dart' as http;

import '../models/shopVisitingFormPM.dart';

Future<List<ShopVisitingFormPM>> parseJsonList(String jsonBody) async{
  List<dynamic> responseList = jsonDecode(jsonBody);
  List<ShopVisitingFormPM> returnList = [];

  for (var element in responseList){
    returnList.add(ShopVisitingFormPM.fromJson(element));
  }
  return returnList;
}

Future<List<ShopVisitingFormPM>> fetchShopVisitingFormPM(String url) async {
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'api_key': apiKey,
    },
  );
  if (response.statusCode == 200) {
    return parseJsonList(response.body);
  } else {
    throw Exception('Failed to load ShopVisitingFormPM List');
  }
}

Future<ShopVisitingFormPM> fetchShopVisitingFormPM2(String url) async {
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'api_key': apiKey,
    },
  );
  if (response.statusCode == 200) {
    return ShopVisitingFormPM.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load ShopVisitingFormPM');
  }
}

Future<List<ShopVisitingFormPM>> fetchShopVisitingFormPM3(String url) async {
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'api_key': apiKey,
    },
  );
  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = json.decode(response.body);
    List<ShopVisitingFormPM> shopVisitingFormPM = jsonResponse.map((data) {
      return ShopVisitingFormPM.fromJson(data);
    }).toList();
    return shopVisitingFormPM;
  } else {
    throw Exception('Failed to load ShopVisitingFormPM List2');
  }
}

