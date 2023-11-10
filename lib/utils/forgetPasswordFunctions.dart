import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:flutter/cupertino.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import '../constants/constants.dart';
import '../models/bmPassword.dart';
import '../models/bsPassword.dart';
import '../models/pmPassword.dart';
import '../models/userBM.dart';
import '../models/userBS.dart';
import '../models/userPM.dart';
import '../services/bmPasswordServices.dart';
import '../services/bsPasswordServices.dart';
import '../services/pmPasswordServices.dart';
import '../services/userBMServices.dart';
import '../services/userBSServices.dart';
import '../services/userPMServices.dart';

int temporaryUserID = 0;
String temporaryPassword = "";

findPassword(String user, String email,BuildContext context) async {
  if(user=="Bölge Sorumlusu") {
    final List<UserBS> users = await fetchUserBS2('http://172.23.21.112:7042/api/KullaniciBS');
    for(int i=0; i<users.length;i++){
      if(users[i].email==email){
        temporaryUserID=users[i].bs_id;
      }
    }
    final BSPassword base64password = await fetchBSPassword2("http://172.23.21.112:7042/api/BSSifre/${temporaryUserID}");
    String decodedSPassword = ascii.decode(base64.decode(base64password.hashed_pw));
    temporaryPassword = decodedSPassword;
    sendPasswordMail(email, decodedSPassword);
  }
  else if(user=="Pazarlama Müdürü") {
    final List<UserPM> users = await fetchUserPM2('http://172.23.21.112:7042/api/KullaniciPM');
    for(int i=0; i<users.length;i++){
      if(users[i].email==email){
        temporaryUserID=users[i].pm_id;
      }
    }
    final PMPassword base64password = await fetchPMPassword2("http://172.23.21.112:7042/api/PMSifre/${temporaryUserID}");
    String decodedSPassword = ascii.decode(base64.decode(base64password.hashed_pw));
    temporaryPassword = decodedSPassword;
    sendPasswordMail(email, decodedSPassword);
  }
  else if(user=="Bölge Müdürü") {
    final List<UserBM> users = await fetchUserBM2('http://172.23.21.112:7042/api/KullaniciBM');
    for(int i=0; i<users.length;i++){
      if(users[i].email==email){
        temporaryUserID=users[i].bm_id;
      }
    }
    final BMPassword base64password = await fetchBMPassword2("http://172.23.21.112:7042/api/BSSifre/${temporaryUserID}");
    String decodedSPassword = ascii.decode(base64.decode(base64password.hashed_pw));
    temporaryPassword = decodedSPassword;
    sendPasswordMail(email, decodedSPassword);
  }
}

sendPasswordMail(String email, String password) async {
  String username = 'sahatakipuygulamasi@hakmarmagazacilik.com.tr';

  final smtpServer = SmtpServer("172.23.21.41",port: 25, ssl: false,ignoreBadCertificate: true);

  final message = Message()
    ..from = Address(username, 'Saha Takip Uygulaması')
    ..recipients.add(email)
    ..subject = 'Uygulama Şifreniz'
    ..text = 'This is the plain text.\nThis is line 2 of the text part.'
    ..html = "<p>Saha takip uygulaması şifreniz: $password </p>";

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



