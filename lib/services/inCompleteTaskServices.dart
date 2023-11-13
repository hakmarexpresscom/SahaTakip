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

Future<IncompleteTask> updateIncompleteTask(int id,String title,String? detail,String assignmentDate, String finishDate, int shopCode, int? photo_id, String taskType, int? report_id, int completionInfo, String url) async {
  final response = await http.put(Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>
    {
      "gorev_id": id,
      "gorev_tanimi": title,
      "gorev_detayi": detail,
      "gorev_atama_tarihi": assignmentDate,
      "gorev_bitis_tarihi": finishDate,
      "magaza_kodu": shopCode,
      "foto_id": photo_id,
      "gorev_turu": taskType,
      "rapor_id": report_id,
      "tamamlandi_bilgisi": completionInfo
    }
    ),
  );
  if (response.statusCode == 200) {
    return IncompleteTask.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to update album.');
  }
}