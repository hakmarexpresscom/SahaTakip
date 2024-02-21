import 'dart:convert';
import '../models/center.dart';
import 'package:http/http.dart' as http;

Future<List<RegionCenter>> parseJsonList(String jsonBody) async{
  List<dynamic> responseList = jsonDecode(jsonBody);
  List<RegionCenter> returnList = [];

  for (var element in responseList){
    returnList.add(RegionCenter.fromJson(element));
  }
  return returnList;
}

Future<List<RegionCenter>> fetchRegionCenter(String url) async {
  final response = await http
      .get(Uri.parse(url));
  if (response.statusCode == 200) {
    return parseJsonList(response.body);
  } else {
    throw Exception('Failed to load RegionCenter List');
  }
}

Future<List<RegionCenter>> fetchRegionCenter2(String url) async {
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = json.decode(response.body);
    List<RegionCenter> centers = jsonResponse.map((data) {
      return RegionCenter.fromJson(data);
    }).toList();
    return centers;
  } else {
    throw Exception('Failed to load RegionCenter List2');
  }
}

