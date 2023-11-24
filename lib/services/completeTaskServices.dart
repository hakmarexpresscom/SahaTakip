import 'dart:convert';
import '../models/completeTask.dart';
import 'package:http/http.dart' as http;

Future<List<CompleteTask>> parseJsonList(String jsonBody) async{
  List<dynamic> responseList = jsonDecode(jsonBody);
  List<CompleteTask> returnList = [];
  for (var element in responseList){
    returnList.add(CompleteTask.fromJson(element));
  }
  return returnList;
}

Future<List<CompleteTask>> fetchCompleteTask(String url) async {
  final response = await http
      .get(Uri.parse(url));
  print(response.statusCode);
  if (response.statusCode == 200) {
    print(response.body);
    print(parseJsonList(response.body));
    return parseJsonList(response.body);
  } else {
    throw Exception('Failed to load Complete Task List');
  }
}

Future<CompleteTask> fetchCompleteTask2(String url) async {
  final response = await http
      .get(Uri.parse(url));
  if (response.statusCode == 200) {
    return CompleteTask.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load Complete Task');
  }
}

Future<List<CompleteTask>> fetchCompleteTask3(String url) async {
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = json.decode(response.body);
    List<CompleteTask> completeTasks = jsonResponse.map((data) {
      return CompleteTask.fromJson(data);
    }).toList();
    return completeTasks;
  } else {
    throw Exception('Failed to load Complete Task List2');
  }
}

Future<CompleteTask> createCompleteTask(int id, int bs_id, String completionDate, int? photo_id, String url) async {
  final response = await http.post(Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>
    {
      "gorev_id": id,
      "bs_id": bs_id,
      "tamamlanma_tarihi": completionDate,
      "foto_id": photo_id,
      "tamamlandi_bilgisi": 1
    }
    ),
  );
  if (response.statusCode == 201) {
    return CompleteTask.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to create Complete Task.');
  }
}