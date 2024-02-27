import 'package:http/http.dart' as http;
import 'dart:convert';
import '../constants/constants.dart';
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
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'api_key': apiKey,
    },
  );
  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = json.decode(response.body);
    List<PMPassword> users = jsonResponse.map((data) {
      return PMPassword.fromJson(data);
    }).toList();
    return users;
  } else {
    throw Exception('Failed to load PM Password List');
  }
}

Future<PMPassword> fetchPMPassword2(String url) async {
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'api_key': apiKey,
    },
  );
  if (response.statusCode == 200) {
    return PMPassword.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load PM Password');
  }
}

Future<PMPassword> updatePMPassword(int pm_id, String hashedPW, String url) async {
  final response = await http.put(Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'api_key': apiKey,
    },
    body: jsonEncode(<String, dynamic>
    {
      "pm_id": pm_id,
      "hashed_pw": hashedPW
    }
    ),
  );
  if (response.statusCode == 201) {
    return PMPassword.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to update PMPassword.');
  }
}

