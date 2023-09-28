import 'dart:async';
import 'package:deneme/constants/constants.dart';
import 'package:deneme/routing/bottomNavigationBar.dart';
import 'package:deneme/screens/shopVisiting/userPM/visitingReport/pastReports/pastReportsMainScreen.dart';
import 'package:flutter/material.dart';

import '../../../../widgets/button_widget.dart';
import '../../../../widgets/text_form_field.dart';
import 'enterVisitingReport.dart';

class VisitingRaportMainScreen extends StatefulWidget {

  static var taskName = "";
  static var taskDeadline = "";
  static var taskDescription = "";

  const VisitingRaportMainScreen({super.key});

  @override
  State<VisitingRaportMainScreen> createState() =>
      _VisitingRaportMainScreenState();
}

class _VisitingRaportMainScreenState extends State<VisitingRaportMainScreen> {

  int _selectedIndex = 0;

  List<BottomNavigationBarItem> naviBarList = [];
  List<Widget> pageList = [];

  late double deviceHeight;
  late double deviceWidth;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final taskNameController = TextEditingController();
  final taskDeadlineController = TextEditingController();
  final taskDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    void userCondition(String user){
      if(user=="BS"){
        naviBarList = itemListBS;
        pageList = pagesBS;
      }
      if(user=="PM"){
        naviBarList = itemListPM;
        pageList = pagesPM;
      }
      if(user=="BM" || user=="GK"){
        naviBarList = itemListBMandGK;
        pageList = pagesBMGK;
      }
      if(user=="NK"){
        naviBarList = itemListNK;
        pageList = pagesNK;
      }
    }

    userCondition(userType);

    return DefaultTabController(
        initialIndex: 0,
        length: 2,
        child:Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              backgroundColor: Colors.indigo,
              title: const Text('Mağaza Ziyaret Raporu'),
              bottom: TabBar(
                tabs: [
                  Tab(text: "Rapor Girişi"),
                  Tab(text: "Geçmiş Raporlar")
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                SingleChildScrollView(child:(isReportCreated)?enterVisitingReportScreenUI():createReportButtonUI(),),
                PastReportsMainScreen(),
              ],
            ),
            bottomNavigationBar: BottomNaviBar(selectedIndex: _selectedIndex,itemList: naviBarList,pageList: pageList,)
        ));
  }

  Widget enterVisitingReportScreenUI(){
    return Builder(builder: (BuildContext context){
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: deviceHeight*0.05,),
            inputForm(),
            SizedBox(height: deviceHeight*0.03,),
            addPhotoButton(),
            SizedBox(height: deviceHeight*0.03,),
            saveExternalTaskButton(),
          ],
        ),
      );
    });
  }

  Widget createReportButtonUI(){
    return Builder(builder: (BuildContext context){
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: deviceHeight*0.15,),
            createReportButton()
          ],
        ),
      );
    });
  }

  Widget createReportButton(){
    return ButtonWidget(text: "Rapor Oluştur", heightConst: 0.06, widthConst: 0.8, size: 18, radius: 20, fontWeight: FontWeight.w600, onTaps: (){setState(() {isReportCreated=true;});}, borderWidht: 1, backgroundColor: Colors.lightGreen.withOpacity(0.6), borderColor: Colors.lightGreen.withOpacity(0.6), textColor: Colors.black);
  }

  Widget saveExternalTaskButton(){
    return ButtonWidget(text: "Görevi Rapora Ekle", heightConst: 0.06, widthConst: 0.8, size: 18, radius: 20, fontWeight: FontWeight.w600, onTaps: (){}, borderWidht: 1, backgroundColor: Colors.lightGreen.withOpacity(0.6), borderColor: Colors.lightGreen.withOpacity(0.6), textColor: Colors.black);
  }

  Widget addPhotoButton(){
    return ButtonWidget(text: "Fotoğraf Ekle", heightConst: 0.06, widthConst: 0.8, size: 18, radius: 20, fontWeight: FontWeight.w600, onTaps: (){}, borderWidht: 3, backgroundColor: Colors.orangeAccent, borderColor: Colors.orangeAccent, textColor: Colors.black);
  }

  Widget inputForm(){
    return Container(
      width: deviceWidth*0.8,
      child: Form(
        key: _formKey,
        onChanged: (){
          _formKey.currentState!.save();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextFormFieldWidget(text: "Görev Adı", borderWidht: 2, titleColor: Colors.black, borderColor: Colors.black, controller: taskNameController, prefixIcon: Icon(Icons.money), value: EnterVisitingReportScreen.taskName, paddingValue: 5,maxLines: 1),
            SizedBox(height: deviceHeight*0.03,),
            TextFormFieldWidget(text: "Görev Bitiş Tarihi", borderWidht: 2, titleColor: Colors.black, borderColor: Colors.black, controller: taskDeadlineController, prefixIcon: Icon(Icons.money), value: EnterVisitingReportScreen.taskDeadline, paddingValue: 5,maxLines: 1),
            SizedBox(height: deviceHeight*0.03,),
            TextFormFieldWidget(text: "Görev Detayı", borderWidht: 2, titleColor: Colors.black, borderColor: Colors.black, controller: taskDescriptionController, prefixIcon: Icon(Icons.money), value: EnterVisitingReportScreen.taskDescription, paddingValue: 5,maxLines: 8),
          ],
        ),
      ),
    );
  }


}


