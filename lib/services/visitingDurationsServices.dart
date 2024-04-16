import 'dart:convert';
import '../constants/constants.dart';
import 'package:http/http.dart' as http;
import '../models/visitingDurations.dart';

Future<List<VisitingDurations>> parseJsonList(String jsonBody) async{
  List<dynamic> responseList = jsonDecode(jsonBody);
  List<VisitingDurations> returnList = [];
  for (var element in responseList){
    returnList.add(VisitingDurations.fromJson(element));
  }
  return returnList;
}

Future<List<VisitingDurations>> fetchVisitingDurations(String url) async {
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'api_key': apiKey,
    },
  );
  if (response.statusCode == 200) {
    return parseJsonList(response.body);
  } else {
    throw Exception('Failed to load VisitingDurations List');
  }
}

Future<VisitingDurations> fetchVisitingDurations2(String url) async {
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'api_key': apiKey,
    },
  );
  if (response.statusCode == 200) {
    return VisitingDurations.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load VisitingDurations');
  }
}

Future<List<VisitingDurations>> fetchVisitingDurations3(String url) async {
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'api_key': apiKey,
    },
  );
  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = json.decode(response.body);
    List<VisitingDurations> visitingDurations = jsonResponse.map((data) {
      return VisitingDurations.fromJson(data);
    }).toList();
    return visitingDurations;
  } else {
    throw Exception('Failed to load VisitingDurations List 2');
  }
}

Future<VisitingDurations> createVisitingDurations(int shop_code, int? bs_id, int? pm_id, String startHour, String? finishHour, String date, String? workDuration, String url) async {
  final response = await http.post(Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'api_key': apiKey,
    },
    body: jsonEncode(<String, dynamic>
    {
      "magaza_kodu" : shop_code,
      "bs_id": bs_id,
      "pm_id": pm_id,
      "baslangic_saati" : startHour,
      "bitis_saati" : finishHour,
      "tarih" : date,
      "calisma_suresi" : workDuration
    }
    ),
  );
  if (response.statusCode == 201) {
    return VisitingDurations.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to create VisitingDurations.');
  }
}

Future<VisitingDurations> updateFinishHourWorkDurationVisitingDurations(int id,int shop_code, int? bs_id, int? pm_id, String startHour, String? finishHour, String date, String? workDuration, String url) async {
  final response = await http.put(Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'api_key': apiKey,
    },
    body: jsonEncode(<String, dynamic>
    {
      "ziyaret_id": id,
      "magaza_kodu" : shop_code,
      "bs_id": bs_id,
      "pm_id": pm_id,
      "baslangic_saati" : startHour,
      "bitis_saati" : finishHour,
      "tarih" : date,
      "calisma_suresi" : workDuration
    }
    ),
  );
  if (response.statusCode == 201) {
    return VisitingDurations.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to update VisitingDurations.');
  }
}

Future countVisitingDurations(String url) async {
  visitingDurationsCount = 0;
  final List<VisitingDurations> visitingDUrations = await fetchVisitingDurations3(url);
  visitingDurationsCount = visitingDUrations[visitingDUrations.length-1].visiting_id;
}