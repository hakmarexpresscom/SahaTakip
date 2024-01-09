import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/bmPassword.dart';

Future<List<BMPassword>> parseJsonList(String jsonBody) async{
  List<dynamic> responseList = jsonDecode(jsonBody);
  List<BMPassword> returnList = [];
  for (var element in responseList){
    returnList.add(BMPassword.fromJson(element));
  }
  return returnList;
}

Future<List<BMPassword>> fetchBMPassword(String url) async {
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = json.decode(response.body);
    List<BMPassword> users = jsonResponse.map((data) {
      return BMPassword.fromJson(data);
    }).toList();
    return users;
  } else {
    throw Exception('Failed to load BM Password List');
  }
}

Future<BMPassword> fetchBMPassword2(String url) async {
  final response = await http
      .get(Uri.parse(url));
  if (response.statusCode == 200) {
    return BMPassword.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load BM Password');
  }
}

Future<BMPassword> updateBMPassword(int bm_id, String hashedPW, String url) async {
  final response = await http.put(Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>
    {
      "bm_id": bm_id,
      "hashed_pw": hashedPW
    }
    ),
  );
  if (response.statusCode == 201) {
    return BMPassword.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to update BMPassword.');
  }
}


