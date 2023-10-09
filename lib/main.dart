import 'dart:async';

import 'package:deneme/screens/authScreens/loginScreen/loginMainScreen.dart';
import 'package:deneme/screens/shopVisiting/userPM/visitingReport/visitingReportMainScreen.dart';
import 'package:deneme/screens/startWork/startWorkMainScreen.dart';
import 'package:deneme/widgets/cards/taskDetailCard.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

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


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController? _textEditingController = TextEditingController();
  List<String> medicamentosListOnSearch = [];
  List<String> medicamentosList = [
    'Ácido acetilsalicílico',
    'Dipirona sodica',
    'Paracetamol',
    'Tylex - Paracetamol + Fosfato de codeína',
    'Tramal',
    'Ibuprofeno',
    'Diclofenaco de sódio',
    'Piroxican',
    'Nimesulida',
    'Etoricoxibe',
    'Dexametasona',
    'Betametasona',
    'Acetonida de triancinolona',
    'Amoxicilina',
    'Amoxicilina + Clavulanato de potássio',
    'Ampicilina',
    'Benzetacil',
    'Cefalexina',
    'Ampicilina',
    'Azitromicina',
    'Eritromicina',
    'Claritromicina',
    'Clindamicina',
    'Metronidazol',
    'Digluconato de clorexidina 0,12%',
    'Nistatina',
    'Miconazol',
    'Cetoconazol',
    'Fluconazol',
    'Itraconazol',
    'Aciclovir',
    'Epinefrina',
    'Prometazina',
    'Diazepam',
    'Midazolam',
    'Alprazolam',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          decoration: BoxDecoration(color: Colors.white70,
              borderRadius: BorderRadius.circular(30)),
          child: TextField(
            onChanged: (value){
              setState ((){
                medicamentosListOnSearch = medicamentosList
                    .where((element) => element.toLowerCase().contains(value.toLowerCase()))
                    .toList();
              });
            },
            controller: _textEditingController,
            decoration: InputDecoration(
                border: InputBorder.none,
                errorBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.all(15),
                hintText: 'Busca'
            ),
          ),
        ),
        actions: [
          TextButton(onPressed: () {
            medicamentosListOnSearch.clear();
            _textEditingController!.clear();
            setState (() {
              _textEditingController!.text = '';
            });
          },
            child: Icon (
              Icons.close,
              color: Colors.deepOrange,
            ),
          )
        ],
      ),

      body: _textEditingController!.text.isNotEmpty && medicamentosListOnSearch.isEmpty
          ?    Center(
        child: Column( mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off_rounded,
              size: 60,
              color: Colors.deepOrange,),
            Text('Nenhum resultado encontrado!', style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold
            ),),
          ],
        ),
      )
          : ListView.builder(
          itemCount: _textEditingController!.text.isNotEmpty
              ? medicamentosListOnSearch.length
              : medicamentosList.length,
          itemBuilder: (context, index){
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  CircleAvatar(
                    child: Icon(Icons.local_pharmacy_rounded),
                  ),
                  SizedBox(width: 10,),
                  Text(
                    _textEditingController!.text.isNotEmpty
                        ? medicamentosListOnSearch [index]
                        : medicamentosList[index],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)
                ],
              ),
            );
          }
      ),
    );
  }
}