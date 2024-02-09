import 'dart:convert';
import '../constants/constants.dart';
import 'package:http/http.dart' as http;
import '../models/shift.dart';

Future<List<Shift>> parseJsonList(String jsonBody) async{
  List<dynamic> responseList = jsonDecode(jsonBody);
  List<Shift> returnList = [];
  for (var element in responseList){
    returnList.add(Shift.fromJson(element));
  }
  return returnList;
}

Future<List<Shift>> fetchShift(String url) async {
  final response = await http
      .get(Uri.parse(url));
  if (response.statusCode == 200) {
    return parseJsonList(response.body);
  } else {
    throw Exception('Failed to load Shift List');
  }
}

Future<Shift> fetchShift2(String url) async {
  final response = await http
      .get(Uri.parse(url));
  if (response.statusCode == 200) {
    return Shift.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load Shift');
  }
}

Future<List<Shift>> fetchShift3(String url) async {
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = json.decode(response.body);
    List<Shift> shift = jsonResponse.map((data) {
      return Shift.fromJson(data);
    }).toList();
    return shift;
  } else {
    throw Exception('Failed to load Shift List 2');
  }
}

Future<Shift> createShift(int id, int? bs_id, int? pm_id, String shiftType, String shiftDate, String startHour, String finishHour, String workDuration, String url) async {
  final response = await http.post(Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>
    {
      "mesai_id" : id,
      "bs_id": bs_id,
      "pm_id": pm_id,
      "mesai_turu" : shiftType,
      "mesai_tarihi" : shiftDate,
      "baslangic_saati" : startHour,
      "bitis_saati" : finishHour,
      "calisma_suresi" : workDuration
    }
    ),
  );
  if (response.statusCode == 201) {
    return Shift.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to create Shift.');
  }
}

Future countShift(String url) async {
  shiftCount = 0;
  final List<Shift> shift = await fetchShift3(url);
  shiftCount = shiftCount + shift.length;
}