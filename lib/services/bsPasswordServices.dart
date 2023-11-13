import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/bsPassword.dart';

Future<List<BSPassword>> parseJsonList(String jsonBody) async{
  List<dynamic> responseList = jsonDecode(jsonBody);
  List<BSPassword> returnList = [];
  for (var element in responseList){
    returnList.add(BSPassword.fromJson(element));
  }
  return returnList;
}

Future<List<BSPassword>> fetchBSPassword(String url) async {
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = json.decode(response.body);
    List<BSPassword> users = jsonResponse.map((data) {
      return BSPassword.fromJson(data);
    }).toList();
    return users;
  } else {
    throw Exception('Failed to load BS Password List');
  }
}

Future<BSPassword> fetchBSPassword2(String url) async {
  final response = await http
      .get(Uri.parse(url));
  if (response.statusCode == 200) {
    return BSPassword.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to Bs Password');
  }
}

