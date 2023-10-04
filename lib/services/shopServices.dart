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

Future<List<Shop>> fetchShop() async {
  final response = await http
      .get(Uri.parse('https://651bb092194f77f2a5aeb616.mockapi.io/magaza'));
  //https://localhost:7042/api/magaza
  //https://10.12.1.190:7042/api/magaza
  print(response.statusCode);
  if (response.statusCode == 200) {
    return parseJsonList(response.body);
  } else {
    throw Exception('Failed to load shop');
  }
}

