import 'dart:convert';
import '../models/externalWork.dart';
import 'package:http/http.dart' as http;

Future<List<ExternalWork>> parseJsonList(String jsonBody) async{
  List<dynamic> responseList = jsonDecode(jsonBody);
  List<ExternalWork> returnList = [];
  for (var element in responseList){
    returnList.add(ExternalWork.fromJson(element));
  }
  return returnList;
}

Future<List<ExternalWork>> fetchExternalWork(String url) async {
  final response = await http
      .get(Uri.parse(url));
  print(response.statusCode);
  if (response.statusCode == 200) {
    print(response.body);
    print(parseJsonList(response.body));
    return parseJsonList(response.body);
  } else {
    throw Exception('Failed to load task');
  }
}

Future<ExternalWork> fetchExternalWork2(String url) async {
  final response = await http
      .get(Uri.parse(url));
  if (response.statusCode == 200) {
    return ExternalWork.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load album');
  }
}

Future<ExternalWork> updateExternalWork(String url,int completionInfo) async {
  final response = await http.put(
    Uri.parse(url),
    body: jsonEncode(<String, int>{
      'tamamlandi_bilgisi': completionInfo,
    }),
  );
  if (response.statusCode == 200) {
    return ExternalWork.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to update album.');
  }
}