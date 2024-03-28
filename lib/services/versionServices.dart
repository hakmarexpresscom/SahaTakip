import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/constants.dart';
import '../models/version.dart';

Future<List<Version>> parseJsonList(String jsonBody) async{
  List<dynamic> responseList = jsonDecode(jsonBody);
  List<Version> returnList = [];

  for (var element in responseList){
    returnList.add(Version.fromJson(element));
  }
  return returnList;
}

Future<List<Version>> fetchVersion(String url) async {
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'api_key': apiKey,
    },
  );
  if (response.statusCode == 200) {
    return parseJsonList(response.body);
  } else {
    throw Exception('Failed to load Version List');
  }
}

Future<List<Version>> fetchVersion2(String url) async {
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'api_key': apiKey,
    },
  );
  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = json.decode(response.body);
    List<Version> version = jsonResponse.map((data) {
      return Version.fromJson(data);
    }).toList();
    return version;
  } else {
    throw Exception('Failed to load Version List2');
  }
}

