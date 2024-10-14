import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/constants.dart';
import '../models/userBM.dart';

Future<List<UserBM>> parseJsonList(String jsonBody) async{
  List<dynamic> responseList = jsonDecode(jsonBody);
  List<UserBM> returnList = [];

  for (var element in responseList){
    returnList.add(UserBM.fromJson(element));
  }
  return returnList;
}

Future<List<UserBM>> fetchUserBM(String url) async {
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'api_key': apiKey,
    },
  );
  if (response.statusCode == 200) {
    return parseJsonList(response.body);
  } else {
    throw Exception('Failed to load User BM List');
  }
}

Future<List<UserBM>> fetchUserBM2(String url) async {
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'api_key': apiKey,
    },
  );
  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = json.decode(response.body);
    List<UserBM> users = jsonResponse.map((data) {
      return UserBM.fromJson(data);
    }).toList();
    return users;
  } else {
    throw Exception('Failed to load User BM List2');
  }
}

Future<UserBM> fetchUserBM3(String url) async {
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'api_key': apiKey,
    },
  );
  if (response.statusCode == 200) {
    return UserBM.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load User BM');
  }
}


