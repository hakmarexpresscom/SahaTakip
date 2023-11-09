import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

sendMail(String email) async {
  String username = 'sahatakipuygulamasi@hakmarmagazacilik.com.tr';
  //String password = 'password';

  final smtpServer = SmtpServer("172.23.21.41",ssl: true);

  final message = Message()
    ..from = Address(username, 'Saha Takip Uygulaması')
    ..recipients.add(email)
    ..subject = 'Test Dart Mailer library ${DateTime.now()}'
    ..text = 'This is the plain text.\nThis is line 2 of the text part.'
    ..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";

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

