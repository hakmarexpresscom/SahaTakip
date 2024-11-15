import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/constants.dart';
import '../main.dart';
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
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'api_key': apiKey,
    },
  );
  if (response.statusCode == 200) {
    return parseJsonList(response.body);
  } else {
    throw Exception('Failed to Photo List');
  }
}

Future<Photo> fetchPhoto2(String url) async {
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'api_key': apiKey,
    },
  );
  if (response.statusCode == 200) {
    return Photo.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load Photo');
  }
}

Future<List<Photo>> fetchPhoto3(String url) async {
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'api_key': apiKey,
    },
  );
  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = json.decode(response.body);
    List<Photo> photos = jsonResponse.map((data) {
      return Photo.fromJson(data);
    }).toList();
    return photos;
  } else {
    throw Exception('Failed to load Photo');
  }
}

Future<Photo> createPhoto(int? task_id, int shopCode,int? bs_id,int? pm_id,int? bm_id, String photoType, String photoFile,int? completeTask_id, url) async {
  final response = await http.post(Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'api_key': apiKey,
    },
    body: jsonEncode(<String, dynamic>
    {
      "gorev_id": task_id,
      "magaza_kodu": shopCode,
      "bs_id": bs_id,
      "pm_id": pm_id,
      "bm_id": bm_id,
      "foto_turu": photoType,
      "foto_file": photoFile,
      "tamamlanmis_gorev_id" : completeTask_id
    }
    ),
  );
  if (response.statusCode == 201) {
    final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
    Photo photo = Photo.fromJson(jsonResponse);
    box.put("photoCount", photo.photo_id);
    return photo;
  } else {
    throw Exception('Failed to create Photo.');
  }
}

Future<Photo> updateIncompleteTaskIDPhoto(int id,int? task_id, int shopCode,int? bs_id,int? pm_id,int? bm_id, String photoType, String photoFile,int? completeTask_id, url) async {
  final response = await http.put(Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'api_key': apiKey,
    },
    body: jsonEncode(<String, dynamic>
    {
      "foto_id": id,
      "gorev_id": task_id,
      "magaza_kodu": shopCode,
      "bs_id": bs_id,
      "pm_id": pm_id,
      "bm_id": bm_id,
      "foto_turu": photoType,
      "foto_file": photoFile,
      "tamamlanmis_gorev_id" : completeTask_id
    }
    ),
  );
  if (response.statusCode == 200) {
    return Photo.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to update Photo');
  }
}

Future<Photo> updateCompleteTaskIDPhoto(int id,int? task_id, int shopCode,int? bs_id,int? pm_id,int? bm_id, String photoType, String photoFile,int? completeTask_id, url) async {
  final response = await http.put(Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'api_key': apiKey,
    },
    body: jsonEncode(<String, dynamic>
    {
      "foto_id": id,
      "gorev_id": task_id,
      "magaza_kodu": shopCode,
      "bs_id": bs_id,
      "pm_id": pm_id,
      "bm_id": bm_id,
      "foto_turu": photoType,
      "foto_file": photoFile,
      "tamamlanmis_gorev_id" : completeTask_id
    }
    ),
  );
  if (response.statusCode == 200) {
    return Photo.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to update Photo');
  }
}