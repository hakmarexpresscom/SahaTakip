import 'dart:convert';
import '../models/center.dart';
import 'package:http/http.dart' as http;

Future<List<Center>> parseJsonList(String jsonBody) async{
  List<dynamic> responseList = jsonDecode(jsonBody);
  List<Center> returnList = [];

  for (var element in responseList){
    returnList.add(Center.fromJson(element));
  }
  return returnList;
}

Future<List<Center>> fetchShop(String url) async {
  final response = await http
      .get(Uri.parse(url));
  if (response.statusCode == 200) {
    return parseJsonList(response.body);
  } else {
    throw Exception('Failed to load Center List');
  }
}

Future<List<Center>> fetchShop2(String url) async {
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = json.decode(response.body);
    List<Center> centers = jsonResponse.map((data) {
      return Center.fromJson(data);
    }).toList();
    return centers;
  } else {
    throw Exception('Failed to load Center List2');
  }
}

