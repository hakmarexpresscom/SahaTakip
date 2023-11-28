import 'dart:convert';
import 'package:deneme/models/userBS.dart';
import 'package:http/http.dart' as http;


Future<List<UserBS>> parseJsonList(String jsonBody) async{
  List<dynamic> responseList = jsonDecode(jsonBody);
  List<UserBS> returnList = [];

  for (var element in responseList){
    returnList.add(UserBS.fromJson(element));
  }
  return returnList;
}

Future<List<UserBS>> fetchUserBS(String url) async {
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return parseJsonList(response.body);
  } else {
    throw Exception('Failed to load User BS List');
  }
}

Future<List<UserBS>> fetchUserBS2(String url) async {
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = json.decode(response.body);
    List<UserBS> users = jsonResponse.map((data) {
      return UserBS.fromJson(data);
    }).toList();
    return users;
  } else {
    throw Exception('Failed to load User BS List2');
  }
}

