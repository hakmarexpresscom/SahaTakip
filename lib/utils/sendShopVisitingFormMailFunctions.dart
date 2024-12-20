import '../main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../constants/constants.dart';
import '../models/dynamicReportRequest.dart';

Future<void> sendShopVisitingFormMail(int grup,Map<dynamic, dynamic> questions, Map<dynamic, dynamic> answers, String subject, List<String> recipients) async {

  String store = "${box.get("currentShopID")} - ${box.get("currentShopName")}";

  String filledBy = "${box.get("userFullName")}";

  List<AttachmentData> attachments = [];

  DateTime now = DateTime.now();
  String formattedDate = "${now.day.toString().padLeft(2, '0')}.${now.month.toString().padLeft(2, '0')}.${now.year}";

  List<Question> questionsList = [];

  for(int i=0;i<questions.keys.toList().length;i++){
    String key = (questions.keys.toList())[i].toString(); // Key'i string'e çevir
    if (answers.containsKey(key)) {
      final answer = answers[key];
      questionsList.add(Question(id: (questions.keys.toList())[i], text: questions[(questions.keys.toList())[i]], answer: answer[0], score: int.parse(answer[1])));
    }
  }

  if(grup == 0){

    var request = DynamicReportRequest(
      date: formattedDate,
      store: store,
      filledBy: filledBy,
      questions: questionsList,
      mailRequest: MailRequest(
        recipients: recipients,
        subject: subject,
        htmlContent: "<p>Yollanmış olan mail ekinde $formattedDate tarihli mağaza ziyareti sırasında doldurulmuş olan mağaza ziyaret formunu "
            "bulabilirsiniz.</p>",
        attachments: attachments,
      ),
    );

    await sendDynamicWordReport(request);
  }

}

//-------------------------------------

Future<void> sendDynamicWordReport(DynamicReportRequest request) async {
  final url = Uri.parse('${constUrl}api/email/send-dynamic-word-report');
  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode(request.toJson()),
  );

  if (response.statusCode == 200) {
    print('Word report sent successfully!');
  } else {
    throw Exception('Failed to send report: ${response.body}');
  }
}