import 'dart:convert';
import 'package:deneme/constants/constants.dart';
import 'package:flutter/cupertino.dart';
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
  if (response.statusCode == 200) {
    return parseJsonList(response.body);
  } else {
    throw Exception('Failed to load External Task List');
  }
}

Future<ExternalWork> fetchExternalWork2(String url) async {
  final response = await http
      .get(Uri.parse(url));
  if (response.statusCode == 200) {
    return ExternalWork.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load External Task');
  }
}

Future<List<ExternalWork>> fetchExternalWork3(String url) async {
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = json.decode(response.body);
    List<ExternalWork> externalsTasks = jsonResponse.map((data) {
      return ExternalWork.fromJson(data);
    }).toList();
    return externalsTasks;
  } else {
    throw Exception('Failed to load External Task List2');
  }
}

Future<ExternalWork> createExternalWork(int? bs_id, int? pm_id, String title, String? detail, String? startHour, String finishHour, String assignmentDate, int completionInfo, String workPlace, String lat, String long, String url) async {
  final response = await http.post(Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>
    {
      "bs_id": bs_id,
      "pm_id": pm_id,
      "is_tanimi": title,
      "is_detayi": detail,
      "baslangic_saati": startHour,
      "bitis_saati": finishHour,
      "is_atama_tarihi": assignmentDate,
      "tamamlandi_bilgisi": completionInfo,
      "is_yeri": workPlace,
      "Lat": lat,
      "Long": long
    }
    ),
  );
  if (response.statusCode == 201) {
    return ExternalWork.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to create External Task.');
  }
}

Future<ExternalWork> updateCompletionInfoExternalWork(int id,int? bs_id, int? pm_id, String title, String? detail, String? startHour, String finishHour, String assignmentDate, int completionInfo, String workPlace, String lat, String long, String url) async {
  final response = await http.put(Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>
    {
      "harici_is_id": id,
      "bs_id": bs_id,
      "pm_id": pm_id,
      "is_tanimi": title,
      "is_detayi": detail,
      "baslangic_saati": startHour,
      "bitis_saati": finishHour,
      "is_atama_tarihi": assignmentDate,
      "tamamlandi_bilgisi": completionInfo,
      "is_yeri": workPlace,
      "Lat": lat,
      "Long": long
    }
    ),
  );
  if (response.statusCode == 200) {
    return ExternalWork.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to update External Task.');
  }
}