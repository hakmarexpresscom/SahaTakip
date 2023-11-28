import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

sendTaskMail(String email, String mailText) async {
  String username = 'sahatakipuygulamasi@hakmarmagazacilik.com.tr';

  final smtpServer = SmtpServer("172.23.21.41",port: 25, ssl: false,ignoreBadCertificate: true);

  final message = Message()
    ..from = Address(username, 'Saha Takip Uygulaması')
    ..recipients.add(email)
    ..subject = 'Yeni Görev Ataması'
    ..text = 'This is the plain text.\nThis is line 2 of the text part.'
    ..html = "<p>$mailText</p>";

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