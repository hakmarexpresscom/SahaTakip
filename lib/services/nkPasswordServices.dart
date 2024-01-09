import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/bsPassword.dart';
import '../models/nkPassword.dart';

Future<List<NKPassword>> parseJsonList(String jsonBody) async{
  List<dynamic> responseList = jsonDecode(jsonBody);
  List<NKPassword> returnList = [];
  for (var element in responseList){
    returnList.add(NKPassword.fromJson(element));
  }
  return returnList;
}

Future<List<NKPassword>> fetchNKPassword(String url) async {
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = json.decode(response.body);
    List<NKPassword> users = jsonResponse.map((data) {
      return NKPassword.fromJson(data);
    }).toList();
    return users;
  } else {
    throw Exception('Failed to load NK Password List');
  }
}

Future<NKPassword> fetchNKPassword2(String url) async {
  final response = await http
      .get(Uri.parse(url));
  if (response.statusCode == 200) {
    return NKPassword.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to NK Password');
  }
}

Future<NKPassword> updateNKPassword(int nk_id, String hashedPW, String url) async {
  final response = await http.put(Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>
    {
      "nk_id": nk_id,
      "hashed_pw": hashedPW
    }
    ),
  );
  if (response.statusCode == 201) {
    return NKPassword.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to update NKPassword.');
  }
}


