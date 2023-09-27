import 'package:deneme/screens/authScreens/loginScreen/loginMainScreen.dart';
import 'package:deneme/screens/startWork/startWorkMainScreen.dart';
import 'package:deneme/widgets/cards/taskDetailCard.dart';
import 'package:flutter/material.dart';

//başlangıç sayfası kullanıcı türüne göre değişicek. çünkü kullanıcı türüne göre navi bar değişiyor.
//login olmamış kullanıcılar için sabit login ekranı başlangıç sayfası olucak fakat hesabı arka planda açık olan kullanıcıların ilk sayfası
//navi barındaki ilk sayfası şeklinde açılıcak.

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginMainScreen(),
    );
  }
}