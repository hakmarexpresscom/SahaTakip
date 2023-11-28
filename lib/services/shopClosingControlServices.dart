import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/shopClosingControl.dart';

Future<List<InShopCloseControl>> parseJsonListIn(String jsonBody) async{
  List<dynamic> responseList = jsonDecode(jsonBody);
  List<InShopCloseControl> returnList = [];
  for (var element in responseList){
    returnList.add(InShopCloseControl.fromJson(element));
  }
  return returnList;
}

Future<List<InShopCloseControl>> fetchInShopCloseControl(String url) async {
  final response = await http
      .get(Uri.parse(url));
  if (response.statusCode == 200) {
    return parseJsonListIn(response.body);
  } else {
    throw Exception('Failed to load InShopCloseControl List');
  }
}

Future<InShopCloseControl> fetchInShopCloseControl2(String url) async {
  final response = await http
      .get(Uri.parse(url));
  if (response.statusCode == 200) {
    return InShopCloseControl.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load InShopCloseControl');
  }
}

Future<List<InShopCloseControl>> fetchInShopCloseControl3(String url) async {
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = json.decode(response.body);
    List<InShopCloseControl> inShopCloseControls = jsonResponse.map((data) {
      return InShopCloseControl.fromJson(data);
    }).toList();
    return inShopCloseControls;
  } else {
    throw Exception('Failed to load InShopCloseControl List 2');
  }
}

//********************************************************


Future<List<OutShopCloseControl>> parseJsonListOut(String jsonBody) async{
  List<dynamic> responseList = jsonDecode(jsonBody);
  List<OutShopCloseControl> returnList = [];
  for (var element in responseList){
    returnList.add(OutShopCloseControl.fromJson(element));
  }
  return returnList;
}

Future<List<OutShopCloseControl>> fetchOutShopOpenControl(String url) async {
  final response = await http
      .get(Uri.parse(url));
  if (response.statusCode == 200) {
    return parseJsonListOut(response.body);
  } else {
    throw Exception('Failed to load OutShopCloseControl List');
  }
}

Future<OutShopCloseControl> fetchOutShopCloseControl2(String url) async {
  final response = await http
      .get(Uri.parse(url));
  if (response.statusCode == 200) {
    return OutShopCloseControl.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load OutShopCloseControl');
  }
}

Future<List<OutShopCloseControl>> fetchOutShopCloseControl3(String url) async {
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = json.decode(response.body);
    List<OutShopCloseControl> outShopCloseControls = jsonResponse.map((data) {
      return OutShopCloseControl.fromJson(data);
    }).toList();
    return outShopCloseControls;
  } else {
    throw Exception('Failed to load OutShopCloseControl List 2');
  }
}