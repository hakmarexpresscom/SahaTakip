import 'package:deneme/constants/constants.dart';
import 'package:deneme/routing/bottomNavigationBar.dart';
import 'package:deneme/widgets/textFormFieldDatePicker.dart';
import 'package:flutter/material.dart';
import '../../../../constants/bottomNaviBarLists.dart';
import '../../../../constants/pagesLists.dart';
import '../../../../models/report.dart';
import '../../../../routing/landing.dart';
import '../../../../services/reportServices.dart';
import '../../../../widgets/button_widget.dart';
import '../../../../widgets/cards/pastReportCard.dart';
import '../../../../widgets/text_form_field.dart';

class VisitingRaportMainScreen extends StatefulWidget {

  int shop_code = 0;

  static var taskName = "";
  static var taskDeadline = "";
  static var taskDescription = "";

  VisitingRaportMainScreen({super.key,required this.shop_code});

  @override
  State<VisitingRaportMainScreen> createState() =>
      _VisitingRaportMainScreenState();
}

class _VisitingRaportMainScreenState extends State<VisitingRaportMainScreen> with TickerProviderStateMixin {

  late Future<List<Report>> futureReport;

  int _selectedIndex = 0;

  List<BottomNavigationBarItem> naviBarList = [];
  List<Widget> pageList = [];

  late double deviceHeight;
  late double deviceWidth;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final taskNameController = TextEditingController();
  final taskDeadlineController = TextEditingController();
  final taskDescriptionController = TextEditingController();

  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    futureReport = fetchReport('http://172.23.21.112:7042/api/Rapor/byMagazaKodu?magaza_kodu=${widget.shop_code}');
    controller = AnimationController(
      /// [AnimationController]s can be created with `vsync: this` because of
      /// [TickerProviderStateMixin].
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
    });
    controller.repeat(reverse: true);
  }

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
                pastReportsMainScreenUI(),
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
            TextFormFieldWidget(text: "Görev Adı", borderWidht: 2, titleColor: Colors.black, borderColor: Colors.black, controller: taskNameController, value: VisitingRaportMainScreen.taskName, paddingValue: 5,maxLines: 1),
            SizedBox(height: deviceHeight*0.03,),
            TextFormFieldDatePicker(text: "Görev Bitiş Tarihi", borderWidht: 2, titleColor: Colors.black, borderColor: Colors.black, dateController: taskDeadlineController, value: VisitingRaportMainScreen.taskDeadline, paddingValue: 5,maxLines: 1),
            SizedBox(height: deviceHeight*0.03,),
            TextFormFieldWidget(text: "Görev Detayı", borderWidht: 2, titleColor: Colors.black, borderColor: Colors.black, controller: taskDescriptionController, value: VisitingRaportMainScreen.taskDescription, paddingValue: 5,maxLines: 8),
          ],
        ),
      ),
    );
  }

  Widget pastReportsMainScreenUI(){
    return Expanded(
        child: FutureBuilder<List<Report>>(
            future: futureReport,
            builder: (context, snapshot){
              if(snapshot.hasData){
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index){
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: deviceHeight*0.01,),
                        PastReportCard(heightConst: 0.15, widthConst: 0.95, reportName: "Rapor ${snapshot.data![index].report_id}",onTaps: (){naviPastReportDetailScreen(context);}),
                      ],
                    );
                  },
                );
              }
              if(snapshot.connectionState == ConnectionState.waiting){
                return Column(
                    children:[
                      SizedBox(height: deviceHeight*0.06,),
                      CircularProgressIndicator(
                        value: controller.value,
                        semanticsLabel: 'Circular progress indicator',
                      ),
                    ]
                );
              }
              else{
                return Text("Veri yok");
              }
            }
        )
    );
  }

}


