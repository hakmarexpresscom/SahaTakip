import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/shopOpeningControl.dart';

Future<List<InShopOpenControl>> parseJsonListIn(String jsonBody) async{
  List<dynamic> responseList = jsonDecode(jsonBody);
  List<InShopOpenControl> returnList = [];
  for (var element in responseList){
    returnList.add(InShopOpenControl.fromJson(element));
  }
  return returnList;
}

Future<List<InShopOpenControl>> fetchInShopOpenControl(String url) async {
  final response = await http
      .get(Uri.parse(url));
  if (response.statusCode == 200) {
    return parseJsonListIn(response.body);
  } else {
    throw Exception('Failed to load InShopOpenControl List');
  }
}

Future<InShopOpenControl> fetchInShopOpenControl2(String url) async {
  final response = await http
      .get(Uri.parse(url));
  if (response.statusCode == 200) {
    return InShopOpenControl.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load InShopOpenControl');
  }
}

Future<List<InShopOpenControl>> fetchInShopOpenControl3(String url) async {
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = json.decode(response.body);
    List<InShopOpenControl> inShopOpenControls = jsonResponse.map((data) {
      return InShopOpenControl.fromJson(data);
    }).toList();
    return inShopOpenControls;
  } else {
    throw Exception('Failed to load InShopOpenControl List 2');
  }
}

//********************************************************


Future<List<OutShopOpenControl>> parseJsonListOut(String jsonBody) async{
  List<dynamic> responseList = jsonDecode(jsonBody);
  List<OutShopOpenControl> returnList = [];
  for (var element in responseList){
    returnList.add(OutShopOpenControl.fromJson(element));
  }
  return returnList;
}

Future<List<OutShopOpenControl>> fetchOutShopOpenControl(String url) async {
  final response = await http
      .get(Uri.parse(url));
  if (response.statusCode == 200) {
    return parseJsonListOut(response.body);
  } else {
    throw Exception('Failed to load OutShopOpenControl List');
  }
}

Future<OutShopOpenControl> fetchOutShopOpenControl2(String url) async {
  final response = await http
      .get(Uri.parse(url));
  if (response.statusCode == 200) {
    return OutShopOpenControl.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load OutShopOpenControl');
  }
}

Future<List<OutShopOpenControl>> fetchOutShopOpenControl3(String url) async {
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = json.decode(response.body);
    List<OutShopOpenControl> outShopOpenControls = jsonResponse.map((data) {
      return OutShopOpenControl.fromJson(data);
    }).toList();
    return outShopOpenControls;
  } else {
    throw Exception('Failed to load OutShopOpenControl List 2');
  }
}