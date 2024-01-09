import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:deneme/routing/landing.dart';
import 'package:flutter/cupertino.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import '../models/userBM.dart';
import '../models/userBS.dart';
import '../models/userNK.dart';
import '../models/userPM.dart';
import '../services/bmPasswordServices.dart';
import '../services/bsPasswordServices.dart';
import '../services/nkPasswordServices.dart';
import '../services/pmPasswordServices.dart';
import '../services/userBMServices.dart';
import '../services/userBSServices.dart';
import '../services/userNKServices.dart';
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
    String newPW = generateRandomString();
    sendPasswordMail(email, newPW);
    updateBSPassword(temporaryUserID,hashPassword(newPW),"http://172.23.21.112:7042/api/BSSifre/${temporaryUserID}");
    naviLoginMainScreen(context);
  }
  else if(user=="Pazarlama Müdürü") {
    final List<UserPM> users = await fetchUserPM2('http://172.23.21.112:7042/api/KullaniciPM');
    for(int i=0; i<users.length;i++){
      if(users[i].email==email){
        temporaryUserID=users[i].pm_id;
      }
    }
    String newPW = generateRandomString();
    sendPasswordMail(email, newPW);
    updatePMPassword(temporaryUserID,hashPassword(newPW),"http://172.23.21.112:7042/api/PMSifre/${temporaryUserID}");
    naviLoginMainScreen(context);
  }
  else if(user=="Bölge Müdürü") {
    final List<UserBM> users = await fetchUserBM2('http://172.23.21.112:7042/api/KullaniciBM');
    for(int i=0; i<users.length;i++){
      if(users[i].email==email){
        temporaryUserID=users[i].bm_id;
      }
    }
    String newPW = generateRandomString();
    sendPasswordMail(email, newPW);
    updateBMPassword(temporaryUserID,hashPassword(newPW),"http://172.23.21.112:7042/api/BMSifre/${temporaryUserID}");
    naviLoginMainScreen(context);
  }
  else if(user=="Normal Kullanıcı") {
    final List<UserNK> users = await fetchUserNK2('http://172.23.21.112:7042/api/KullaniciNK');
    for(int i=0; i<users.length;i++){
      if(users[i].email==email){
        temporaryUserID=users[i].nk_id;
      }
    }
    String newPW = generateRandomString();
    sendPasswordMail(email, newPW);
    updateNKPassword(temporaryUserID,hashPassword(newPW),"http://172.23.21.112:7042/api/NKSifre/${temporaryUserID}");
    naviLoginMainScreen(context);
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

String generateRandomString() {
  const characters = 'abcdefghijklmnopqrstuvwxyz0123456789';
  Random random = Random();
  String result = '';
  for (int i = 0; i < 9; i++) {
    int randomIndex = random.nextInt(characters.length);
    result += characters[randomIndex];
  }
  return result;
}

String hashPassword(String password) {
  var bytes = utf8.encode(password);
  var digest = sha256.convert(bytes);
  var base64EncodedPassword = base64.encode(digest.bytes);
  return base64EncodedPassword;
}



