import 'dart:convert';
import 'package:deneme/models/userBS.dart';
import 'package:http/http.dart' as http;

import '../constants/constants.dart';
import '../models/photo.dart';

Future<List<Photo>> parseJsonList(String jsonBody) async{
  List<dynamic> responseList = jsonDecode(jsonBody);
  List<Photo> returnList = [];

  for (var element in responseList){
    returnList.add(Photo.fromJson(element));
  }
  return returnList;
}

Future<List<Photo>> fetchPhoto(String url) async {
  final response = await http.get(Uri.parse(url));
  print(response.statusCode);
  if (response.statusCode == 200) {
    return parseJsonList(response.body);
  } else {
    throw Exception('Failed to load shop');
  }
}

Future<List<Photo>> fetchPhoto2(String url) async {
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = json.decode(response.body);
    List<Photo> users = jsonResponse.map((data) {
      return Photo.fromJson(data);
    }).toList();
    return users;
  } else {
    throw Exception('Failed to load user data');
  }
}

