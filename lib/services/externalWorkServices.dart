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

Future<List<ExternalWork>> fetchExternalWork3(String url) async {
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = json.decode(response.body);
    List<ExternalWork> users = jsonResponse.map((data) {
      return ExternalWork.fromJson(data);
    }).toList();
    return users;
  } else {
    throw Exception('Failed to load user data');
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

Future<ExternalWork> createExternalWork(int id,String title,String? detail,String assignmentDate, String finishDate, int bs_id, int? pm_id, url) async {
  final response = await http.post(Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>
    {
      "harici_is_id": id,
      "is_tanimi": title,
      "is_detayi": detail,
      "is_atama_tarihi": assignmentDate,
      "is_bitis_tarihi": finishDate,
      "bs_id": bs_id,
      "pm_id": pm_id,
      "tamamlandi_bilgisi": 0
    }
    ),
  );
  if (response.statusCode == 201) {
    return ExternalWork.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to create album.');
  }
}


Future countExternalTask(String url,BuildContext context) async {
  final List<ExternalWork> externalTasks = await fetchExternalWork3(url);
  externalTaskCount = externalTaskCount + externalTasks.length;
  print("********************************${externalTaskCount}");
}