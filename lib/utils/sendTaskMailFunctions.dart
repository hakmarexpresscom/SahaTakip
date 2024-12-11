import 'package:http/http.dart' as http;
import 'dart:convert';
import '../constants/constants.dart';

Future<void> sendTask(int grup,List<String> recipients) async {

  String subject = "Bizz Uygulaması Görev Atama";

  if(grup == 0){
    await sendTaskToApi(
        recipients,
        subject,
    );
  }

  else if(grup == 1){
    await sendTaskToApi(
        recipients,
        subject,
    );
  }
}

//-------------------------------------

Future<void> sendTaskToApi(List<String> recipients, String subject) async {

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
      'htmlContent': "<p>Tarafınıza $formattedDate tarihinde yeni bir görev atanmıştır.</p>",
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



