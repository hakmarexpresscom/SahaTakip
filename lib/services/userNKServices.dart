import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/constants.dart';
import '../models/userNK.dart';

Future<List<UserNK>> parseJsonList(String jsonBody) async{
  List<dynamic> responseList = jsonDecode(jsonBody);
  List<UserNK> returnList = [];

  for (var element in responseList){
    returnList.add(UserNK.fromJson(element));
  }
  return returnList;
}

Future<List<UserNK>> fetchUserNK(String url) async {
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'api_key': apiKey,
    },
  );
  if (response.statusCode == 200) {
    return parseJsonList(response.body);
  } else {
    throw Exception('Failed to load UserNK List');
  }
}

Future<List<UserNK>> fetchUserNK2(String url) async {
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'api_key': apiKey,
    },
  );
  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = json.decode(response.body);
    List<UserNK> users = jsonResponse.map((data) {
      return UserNK.fromJson(data);
    }).toList();
    return users;
  } else {
    throw Exception('Failed to load UserNK List2');
  }
}

