import 'dart:convert';
import 'package:deneme/models/manavShopForm.dart';
import 'package:http/http.dart' as http;
import '../constants/constants.dart';

Future<List<ManavShopForm>> parseJsonListIn(String jsonBody) async{
  List<dynamic> responseList = jsonDecode(jsonBody);
  List<ManavShopForm> returnList = [];
  for (var element in responseList){
    returnList.add(ManavShopForm.fromJson(element));
  }
  return returnList;
}

Future<List<ManavShopForm>> fetchManavShopForm(String url) async {
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'api_key': apiKey,
    },
  );
  if (response.statusCode == 200) {
    return parseJsonListIn(response.body);
  } else {
    throw Exception('Failed to load ManavShopForm List');
  }
}

Future<ManavShopForm> fetchManavShopForm2(String url) async {
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'api_key': apiKey,
    },
  );
  if (response.statusCode == 200) {
    return ManavShopForm.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load ManavShopForm');
  }
}

Future<List<ManavShopForm>> fetchManavShopForm3(String url) async {
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'api_key': apiKey,
    },
  );
  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = json.decode(response.body);
    List<ManavShopForm> manavShopForm = jsonResponse.map((data) {
      return ManavShopForm.fromJson(data);
    }).toList();
    return manavShopForm;
  } else {
    throw Exception('Failed to load ManavShopForm List 2');
  }
}

Future<ManavShopForm> createManavShopForm(
    int shopCode,
    int? bs_id,
    int? pm_id,
    String savingDate,
    int manav_duzeni,
    int manav_fifo,
    int dizilim,
    int aktif_urun,
    int halk_gunu,
    int afis,
    int kunye,
    int fiyat_degisikligi,
    int magaza_etiket,
    int cikma_bolumu,
    int kuruyemis_standi,
    int kasa_terazileri,
    int manav_baskulu,
    int manav_stogu,
    int manav_kasa,
    int kasa_alani_duzeni,
    int dogru_siparis,
    int hatali_kodu,
    int cekleme,
    int personel_giris_cikis,
    int fire_cikisi,
    int ciro,
    int personel_duzen_temizlik,

    String url) async {
  final response = await http.post(Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'api_key': apiKey,
    },
    body: jsonEncode(<String, dynamic>
    {
      "magaza_kodu": shopCode,
      "bs_id": bs_id,
      "pm_id": pm_id,
      "kayit_tarihi": savingDate,
      "manav_duzeni": manav_duzeni,
      "manav_fifo": manav_fifo,
      "dizilim": dizilim,
      "aktif_urun": aktif_urun,
      "halk_gunu": halk_gunu,
      "afis": afis,
      "kunye": kunye,
      "fiyat_degisikligi": fiyat_degisikligi,
      "magaza_etiket": magaza_etiket,
      "cikma_bolumu": cikma_bolumu,
      "kuruyemis_standi": kuruyemis_standi,
      "kasa_terazileri": kasa_terazileri,
      "manav_baskulu": manav_baskulu,
      "manav_stogu": manav_stogu,
      "manav_kasa": manav_kasa,
      "kasa_alani_duzeni": kasa_alani_duzeni,
      "dogru_siparis": dogru_siparis,
      "hatali_kodu": hatali_kodu,
      "cekleme": cekleme,
      "personel_giris_cikis": personel_giris_cikis,
      "fire_cikisi": fire_cikisi,
      "ciro": ciro,
      "personel_duzen_temizlik": personel_duzen_temizlik,
    }
    ),
  );
  if (response.statusCode == 201) {
    return ManavShopForm.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to create ManavShopForm.');
  }
}