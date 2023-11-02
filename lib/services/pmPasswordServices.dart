import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/bsPassword.dart';
import '../models/pmPassword.dart';

Future<List<PMPassword>> parseJsonList(String jsonBody) async{
  List<dynamic> responseList = jsonDecode(jsonBody);
  List<PMPassword> returnList = [];
  for (var element in responseList){
    returnList.add(PMPassword.fromJson(element));
  }
  return returnList;
}

Future<List<PMPassword>> fetchPMPassword(String url) async {
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = json.decode(response.body);
    List<PMPassword> users = jsonResponse.map((data) {
      return PMPassword.fromJson(data);
    }).toList();
    return users;
  } else {
    throw Exception('Failed to load user data');
  }
}

Future<PMPassword> fetchPMPassword2(String url) async {
  final response = await http
      .get(Uri.parse(url));
  if (response.statusCode == 200) {
    return PMPassword.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load album');
  }
}

