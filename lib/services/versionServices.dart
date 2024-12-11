import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/constants.dart';
import '../models/version.dart';

Future<List<NewVersion>> parseJsonList(String jsonBody) async{
  List<dynamic> responseList = jsonDecode(jsonBody);
  List<NewVersion> returnList = [];

  for (var element in responseList){
    returnList.add(NewVersion.fromJson(element));
  }
  return returnList;
}

Future<List<NewVersion>> fetchVersion(String url) async {
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'api_key': apiKey,
    },
  );
  if (response.statusCode == 200) {
    return parseJsonList(response.body);
  } else {
    throw Exception('Failed to load NewVersion List');
  }
}

Future<List<NewVersion>> fetchVersion2(String url) async {
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'api_key': apiKey,
    },
  );
  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = json.decode(response.body);
    List<NewVersion> version = jsonResponse.map((data) {
      return NewVersion.fromJson(data);
    }).toList();
    return version;
  } else {
    throw Exception('Failed to load NewVersion List2');
  }
}

