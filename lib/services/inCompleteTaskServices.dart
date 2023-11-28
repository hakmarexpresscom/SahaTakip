import 'dart:convert';
import '../constants/constants.dart';
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
  if (response.statusCode == 200) {
    return parseJsonList(response.body);
  } else {
    throw Exception('Failed to load Incomplete Task List');
  }
}

Future<IncompleteTask> fetchIncompleteTask2(String url) async {
  final response = await http
      .get(Uri.parse(url));
  if (response.statusCode == 200) {
    return IncompleteTask.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load Incomplete Task');
  }
}

Future<List<IncompleteTask>> fetchIncompleteTask3(String url) async {
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = json.decode(response.body);
    List<IncompleteTask> incompleteTasks = jsonResponse.map((data) {
      return IncompleteTask.fromJson(data);
    }).toList();
    return incompleteTasks;
  } else {
    throw Exception('Failed to load Incomplete Task List 2');
  }
}

Future<IncompleteTask> createIncompleteTask(int id,String title,String? detail,String assignmentDate, String finishDate, int shopCode, int? photo_id, String taskType, int? report_id, String url) async {
  final response = await http.post(Uri.parse(url),
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
      "tamamlandi_bilgisi": 0
    }
    ),
  );
  if (response.statusCode == 201) {
    return IncompleteTask.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to create Incomplete Task List.');
  }
}

Future<IncompleteTask> updateCompletionInfoIncompleteTask(int id,String title,String? detail,String assignmentDate, String finishDate, int shopCode, int? photo_id, String taskType, int? report_id, int completionInfo, String url) async {
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
    throw Exception('Failed to update Incomplete Task');
  }
}

Future<IncompleteTask> updatePhotoIDIncompleteTask(int id,String title,String? detail,String assignmentDate, String finishDate, int shopCode, int? photo_id, String taskType, int? report_id, String url) async {
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
      "tamamlandi_bilgisi": 0
    }
    ),
  );
  if (response.statusCode == 200) {
    return IncompleteTask.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to update Incomplete Task');
  }
}

Future<IncompleteTask> updateReportIDIncompleteTask(int id,String title,String? detail,String assignmentDate, String finishDate, int shopCode, int? photo_id, String taskType, int? report_id, String url) async {
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
      "tamamlandi_bilgisi": 0
    }
    ),
  );
  if (response.statusCode == 200) {
    return IncompleteTask.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to update Incomplete Task');
  }
}

Future countIncompleteTask(String url) async {
  incompleteTaskCount = 0;
  final List<IncompleteTask> incompleteTasks = await fetchIncompleteTask3(url);
  incompleteTaskCount = incompleteTaskCount + incompleteTasks.length;
}