import 'package:deneme/constants/constants.dart';
import 'package:deneme/routing/bottomNavigationBar.dart';
import 'package:deneme/widgets/button_widget.dart';
import 'package:deneme/widgets/text_form_field.dart';
import 'package:deneme/widgets/text_widget.dart';
import 'package:flutter/material.dart';


class CashCountingScreen extends StatefulWidget {

  static var kagitParaSayimi = "";
  static var madeniParaSsayimi = "";
  static var POSlarToplami = "";
  static var masraflarTediyeler = "";
  static var celikKasaMevcudu = "";
  static var kasaDefterMevcudu = "";
  static var fark = "";

  const CashCountingScreen({super.key});

  @override
  State<CashCountingScreen> createState() =>
      _CashCountingScreenState();
}

class _CashCountingScreenState extends State<CashCountingScreen> {

  int _selectedIndex = 0;

  List<BottomNavigationBarItem> naviBarList = [];
  List<Widget> pageList = [];

  late double deviceHeight;
  late double deviceWidth;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final kagitParaSayimiController = TextEditingController();
  final madeniParaSsayimiController = TextEditingController();
  final POSlarToplamiController = TextEditingController();
  final masraflarTediyelerController = TextEditingController();
  final celikKasaMevcuduController = TextEditingController();
  final kasaDefterMevcuduController = TextEditingController();
  final farkController = TextEditingController();

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

    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: const Text('Çelik Kasa Sayımı'),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child:Container(
            alignment: Alignment.center,
            child: cashCountingScreenUI(),
          ),
        ),
        bottomNavigationBar: BottomNaviBar(selectedIndex: _selectedIndex,itemList: naviBarList,pageList: pageList,)
    );
  }

  Widget cashCountingScreenUI(){
    return Builder(builder: (BuildContext context){
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: deviceHeight*0.03,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                shopCodeInfo(),
                shopNameInfo()
              ],
            ),
            SizedBox(height: deviceHeight*0.05,),
            inputForm(),
            SizedBox(height: deviceHeight*0.05,),
            saveButton(),
            SizedBox(height: deviceHeight*0.05,),
          ],
        ),
      );
    });
  }

  Widget shopNameInfo(){
    return TextWidget(text: "Taşlıbayır/Pendik", heightConst: 0, widhtConst: 0, size: 25, fontWeight: FontWeight.w400, color: Colors.black);
  }
  Widget shopCodeInfo(){
    return TextWidget(text: "5168", heightConst: 0, widhtConst: 0, size: 25, fontWeight: FontWeight.w400, color: Colors.black);
  }
  Widget saveButton(){
    return ButtonWidget(text: "Kaydet", heightConst: 0.06, widthConst: 0.8, size: 18, radius: 20, fontWeight: FontWeight.w600, onTaps: (){}, borderWidht: 1, backgroundColor: Colors.lightGreen.withOpacity(0.6), borderColor: Colors.lightGreen.withOpacity(0.6), textColor: Colors.black);
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
            TextFormFieldWidget(text: "Kağıt Para Sayımı", borderWidht: 2, titleColor: Colors.black, borderColor: Colors.black, controller: kagitParaSayimiController, prefixIcon: Icon(Icons.money), value: CashCountingScreen.kagitParaSayimi, paddingValue: 5,maxLines: 1),
            SizedBox(height: deviceHeight*0.03,),
            TextFormFieldWidget(text: "Madeni Para Sayımı", borderWidht: 2, titleColor: Colors.black, borderColor: Colors.black, controller: madeniParaSsayimiController, prefixIcon: Icon(Icons.money), value: CashCountingScreen.madeniParaSsayimi, paddingValue: 5,maxLines: 1),
            SizedBox(height: deviceHeight*0.03,),
            TextFormFieldWidget(text: "POS'lar Toplamı", borderWidht: 2, titleColor: Colors.black, borderColor: Colors.black, controller: POSlarToplamiController, prefixIcon: Icon(Icons.money), value: CashCountingScreen.POSlarToplami, paddingValue: 5,maxLines: 1),
            SizedBox(height: deviceHeight*0.03,),
            TextFormFieldWidget(text: "Masraflar ve Tediyeler", borderWidht: 2, titleColor: Colors.black, borderColor: Colors.black, controller: masraflarTediyelerController, prefixIcon: Icon(Icons.money), value: CashCountingScreen.masraflarTediyeler, paddingValue: 5,maxLines: 1),
            SizedBox(height: deviceHeight*0.03,),
            TextFormFieldWidget(text: "Çelik Kasa Mevcudu", borderWidht: 2, titleColor: Colors.black, borderColor: Colors.black, controller: celikKasaMevcuduController, prefixIcon: Icon(Icons.money), value: CashCountingScreen.celikKasaMevcudu, paddingValue: 5,maxLines: 1),
            SizedBox(height: deviceHeight*0.03,),
            TextFormFieldWidget(text: "Kasa Defter Mevcudu", borderWidht: 2, titleColor: Colors.black, borderColor: Colors.black, controller: kasaDefterMevcuduController, prefixIcon: Icon(Icons.money), value: CashCountingScreen.kasaDefterMevcudu, paddingValue: 5,maxLines: 1),
            SizedBox(height: deviceHeight*0.03,),
            TextFormFieldWidget(text: "Fark", borderWidht: 2, titleColor: Colors.black, borderColor: Colors.black, controller: farkController, prefixIcon: Icon(Icons.money), value: CashCountingScreen.fark, paddingValue: 5,maxLines: 1)
          ],
        ),
      ),
    );
  }
}


