import 'dart:convert';
import '../constants/constants.dart';
import '../models/regionCenter.dart';
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
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'api_key': apiKey,
    },
  );
  if (response.statusCode == 200) {
    return parseJsonList(response.body);
  } else {
    throw Exception('Failed to load RegionCenter List');
  }
}

Future<RegionCenter> fetchRegionCenter2(String url) async {
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'api_key': apiKey,
    },
  );
  if (response.statusCode == 200) {
    return RegionCenter.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load RegionCenter');
  }
}

Future<List<RegionCenter>> fetchRegionCenter3(String url) async {
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'api_key': apiKey,
    },
  );
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
