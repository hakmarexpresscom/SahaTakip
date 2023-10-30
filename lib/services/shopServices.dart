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
  //https://localhost:7042/api/magaza
  //https://localhost:5000/api/magaza
  //https://10.12.1.190:7042/api/magaza
  //https://651bb092194f77f2a5aeb616.mockapi.io/magaza
  //https://10.0.2.2:5000/api/magaza
  //https://10.0.2.2:7042/api/magaza
  print(response.statusCode);
  if (response.statusCode == 200) {
    return parseJsonList(response.body);
  } else {
    throw Exception('Failed to load shop');
  }
}

Future<List<Shop>> fetchShop2(String url) async {
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = json.decode(response.body);
    List<Shop> users = jsonResponse.map((data) {
      return Shop.fromJson(data);
    }).toList();
    return users;
  } else {
    throw Exception('Failed to load user data');
  }
}

