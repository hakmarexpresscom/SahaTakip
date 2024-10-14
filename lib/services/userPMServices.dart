import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/constants.dart';
import '../models/userPM.dart';

Future<List<UserPM>> parseJsonList(String jsonBody) async{
  List<dynamic> responseList = jsonDecode(jsonBody);
  List<UserPM> returnList = [];

  for (var element in responseList){
    returnList.add(UserPM.fromJson(element));
  }
  return returnList;
}

Future<List<UserPM>> fetchUserPM(String url) async {
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'api_key': apiKey,
    },
  );
  if (response.statusCode == 200) {
    return parseJsonList(response.body);
  } else {
    throw Exception('Failed to load User PM List');
  }
}

Future<List<UserPM>> fetchUserPM2(String url) async {
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'api_key': apiKey,
    },
  );
  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = json.decode(response.body);
    List<UserPM> users = jsonResponse.map((data) {
      return UserPM.fromJson(data);
    }).toList();
    return users;
  } else {
    throw Exception('Failed to load user User PM List2');
  }
}

Future<UserPM> fetchUserPM3(String url) async {
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'api_key': apiKey,
    },
  );
  if (response.statusCode == 200) {
    return UserPM.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load User PM');
  }
}

