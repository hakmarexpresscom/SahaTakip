import 'dart:convert';
import '../constants/constants.dart';
import '../models/incompleteTask.dart';
import 'package:http/http.dart' as http;

import '../models/report.dart';

Future<List<Report>> parseJsonList(String jsonBody) async{
  List<dynamic> responseList = jsonDecode(jsonBody);
  List<Report> returnList = [];
  for (var element in responseList){
    returnList.add(Report.fromJson(element));
  }
  return returnList;
}

Future<List<Report>> fetchReport(String url) async {
  final response = await http
      .get(Uri.parse(url));
  print(response.statusCode);
  if (response.statusCode == 200) {
    print(response.body);
    print(parseJsonList(response.body));
    return parseJsonList(response.body);
  } else {
    throw Exception('Failed to load Report');
  }
}

Future<Report> fetchReport2(String url) async {
  final response = await http
      .get(Uri.parse(url));
  if (response.statusCode == 200) {
    return Report.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load Report');
  }
}

Future<List<Report>> fetchReport3(String url) async {
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = json.decode(response.body);
    List<Report> reports = jsonResponse.map((data) {
      return Report.fromJson(data);
    }).toList();
    return reports;
  } else {
    throw Exception('Failed to load Report list 2');
  }
}