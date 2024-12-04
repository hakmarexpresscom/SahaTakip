import '../main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../constants/constants.dart';

Future<void> sendForm(int grup) async {

  String subject = "${box.get("currentShopID")} ${box.get("currentShopName")} Ziyaret Formu";

  List<String> recipients = [
    box.get("yoneticiEmail"),
    box.get("userEmail"),
    "mag${box.get("currentShopID")}@hakmarmagazacilik.com.tr"
  ];

  List<String> attachments = [];

  if(grup == 0){
    await sendFormToApi(
        recipients,
        subject,
        [formatFormToHTML2(boxBSSatisOperasyonShopVisitingFormShops.get("questions"), boxBSSatisOperasyonShopVisitingFormShops.get(box.get("currentShopID")))],
        attachments
    );
  }

}

//-------------------------------------

String formatFormToHTML2(Map<dynamic, dynamic> questions, Map<dynamic, dynamic> answers) {
  StringBuffer formListBuffer = StringBuffer();
  formListBuffer.write("<ul>");

  questions.forEach((itemID, itemName) {
    String key = itemID.toString(); // Key'i string'e çevir
    if (answers.containsKey(key)) {
      final answer = answers[key];
      formListBuffer.write("<li>");
      formListBuffer.write("$key ) $itemName :<br>");
      formListBuffer.write("Cevap: \"${answer[0]}\"<br>");
      formListBuffer.write("Puan: ${answer[1]}<br>");
      formListBuffer.write("</li>");
    }
  });

  formListBuffer.write("</ul>");
  return formListBuffer.toString();
}



//-------------------------------------

Future<void> sendFormToApi(List<String> recipients, String subject, List<String> formattedFormHTMLList, List<String> attachments) async {
  StringBuffer completeHTMLContent = StringBuffer();
  formattedFormHTMLList.forEach((htmlContent) {
    completeHTMLContent.write(htmlContent);
  });

  List<Map<String, String>> base64Attachments = [];

  DateTime now = DateTime.now();
  String formattedDate = "${now.day.toString().padLeft(2, '0')}.${now.month.toString().padLeft(2, '0')}.${now.year}";

  var url = Uri.parse('${constUrl}api/email/send-report');
  var response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'recipients': recipients,
      'subject': subject,
      'htmlContent': "<p>Yollanmış olan mailde $formattedDate tarihli mağaza ziyareti sırasında doldurulmuş olan mağaza ziyaret formunun "
          "cevaplarını bulabilirsiniz.</p>"
          + completeHTMLContent.toString(),
      'attachments': base64Attachments,
    }),
  );

  if (response.statusCode == 200) {
    print('Mail sent successfully');
  } else {
    print('Failed to send mail: ${response.statusCode}');
    print('Response body: ${response.body}'); // Sunucudan dönen hata mesajını görüntüleyin
  }
}