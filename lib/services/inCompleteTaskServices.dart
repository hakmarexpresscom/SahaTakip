import 'dart:convert';
import '../models/incompleteTask.dart';
import 'package:http/http.dart' as http;

Future<List<IncompleteTask>> parseJsonList(String jsonBody) async{
  List<dynamic> responseList = jsonDecode(jsonBody);
  List<IncompleteTask> returnList = [];
  for (var element in responseList){
    returnList.add(IncompleteTask.fromJson(element));
  }
  return returnList;
}

Future<List<IncompleteTask>> fetchIncompleteTask(String url) async {
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

Future<IncompleteTask> fetchIncompleteTask2(String url) async {
  final response = await http
      .get(Uri.parse(url));
  if (response.statusCode == 200) {
    return IncompleteTask.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load album');
  }
}

Future<IncompleteTask> updateIncompleteTask(String url,int completionInfo) async {
  final response = await http.put(
    Uri.parse(url),
    body: jsonEncode(<String, int>{
      'tamamlandi_bilgisi': completionInfo,
    }),
  );
  if (response.statusCode == 200) {
    return IncompleteTask.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to update album.');
  }
}