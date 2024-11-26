import 'dart:convert';
import '../constants/constants.dart';
import 'package:http/http.dart' as http;

import '../models/shopVisitingFormBS.dart';

Future<List<ShopVisitingFormBS>> parseJsonList(String jsonBody) async{
  List<dynamic> responseList = jsonDecode(jsonBody);
  List<ShopVisitingFormBS> returnList = [];

  for (var element in responseList){
    returnList.add(ShopVisitingFormBS.fromJson(element));
  }
  return returnList;
}

Future<List<ShopVisitingFormBS>> fetchShopVisitingFormBS(String url) async {
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'api_key': apiKey,
    },
  );
  if (response.statusCode == 200) {
    return parseJsonList(response.body);
  } else {
    throw Exception('Failed to load ShopVisitingFormBS List');
  }
}

Future<ShopVisitingFormBS> fetchShopVisitingFormBS2(String url) async {
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'api_key': apiKey,
    },
  );
  if (response.statusCode == 200) {
    return ShopVisitingFormBS.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load ShopVisitingFormBS');
  }
}

Future<List<ShopVisitingFormBS>> fetchShopVisitingFormBS3(String url) async {
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'api_key': apiKey,
    },
  );
  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = json.decode(response.body);
    List<ShopVisitingFormBS> shopVisitingFormBS = jsonResponse.map((data) {
      return ShopVisitingFormBS.fromJson(data);
    }).toList();
    return shopVisitingFormBS;
  } else {
    throw Exception('Failed to load ShopVisitingFormBS List2');
  }
}

