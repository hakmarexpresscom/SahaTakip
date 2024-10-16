import 'dart:io';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import '../main.dart';

sendReport(int grup){
  if(grup==0){
    sendShopVistingReportMail([box.get("inShopOpenFormList"),box.get("outShopOpenFormList"),box.get("inShopCloseFormList"),box.get("outShopCloseFormList")]);
  }
  else if(grup==1){
    sendShopVistingReportMail([box.get("manavShopFormList")]);
  }
  if(grup==2){
    sendShopVistingReportMail([box.get("breadGroupFormList"),box.get("frozenGroupFormList"),box.get("tatbakGroupFormList")]);
  }
}

sendShopVistingReportMail(List<String> formattedFormHTMLList) async {

  String username = 'bizz@hakmarmagazacilik.com.tr';
  String password = 'Qur11738';

  final smtpServer = hotmail(username, password);

  DateTime now = DateTime.now();
  String formattedDate = "${now.day.toString().padLeft(2, '0')}.${now.month.toString().padLeft(2, '0')}.${now.year}";

  StringBuffer completeHTMLContent = StringBuffer();
  formattedFormHTMLList.forEach((htmlContent) {
    completeHTMLContent.write(htmlContent);
  });

  final message = Message()
    ..from = Address(username, 'Bizz Uygulaması')
    ..recipients.add(box.get("yoneticiEmail"))
    ..recipients.add("mag"+box.get("currentShopID").toString()+"hakmarmagazacilik.com.tr")
    ..subject = box.get("currentShopID").toString() + " " + box.get("currentShopName") + ' Ziyaret Raporu'
    ..text = 'This is the plain text.\nThis is line 2 of the text part.'
    ..html = "<p>Yollanmış olan mailde $formattedDate tarihli mağaza ziyareti sırasında doldurulmuş formların sonuçlarını "
        "ve uygulamaya yüklenmiş olan ziyaret fotoğraflarını bulabilirsiniz.</p>"
        + completeHTMLContent.toString()
    ..attachments.add(FileAttachment(File(boxshopVisitingPhoto.get("beforePhoto"))))
    ..attachments.add(FileAttachment(File(boxshopVisitingPhoto.get("afterPhoto"))));

  try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: ' + sendReport.toString());
  } on MailerException catch (e) {
    print('Message not sent.');
    for (var p in e.problems) {
      print('Problem: ${p.code}: ${p.msg}');
    }
  }

  var connection = PersistentConnection(smtpServer);
  await connection.send(message);
  await connection.close();
}


String formatFormToHTML(Map<String, int> form) {
  StringBuffer formListBuffer = StringBuffer();
  formListBuffer.write("<ul>");
  form.forEach((question, answer) {
    formListBuffer.write("<li>$question: ${answer == 0 ? 'Hayır' : 'Evet'}</li>");
  });
  formListBuffer.write("</ul>");
  return formListBuffer.toString();
}

