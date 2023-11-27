import 'dart:convert';
import '../models/shop.dart';
import 'package:http/http.dart' as http;

Future<List<Shop>> parseJsonList(String jsonBody) async{
  List<dynamic> responseList = jsonDecode(jsonBody);
  List<Shop> returnList = [];

  for (var element in responseList){
    returnList.add(Shop.fromJson(element));
  }
  return returnList;
}

Future<List<Shop>> fetchShop(String url) async {
  final response = await http
      .get(Uri.parse(url));
  print(response.statusCode);
  if (response.statusCode == 200) {
    return parseJsonList(response.body);
  } else {
    throw Exception('Failed to load Shop List');
  }
}

Future<List<Shop>> fetchShop2(String url) async {
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = json.decode(response.body);
    List<Shop> shops = jsonResponse.map((data) {
      return Shop.fromJson(data);
    }).toList();
    return shops;
  } else {
    throw Exception('Failed to load Shop List2');
  }
}

