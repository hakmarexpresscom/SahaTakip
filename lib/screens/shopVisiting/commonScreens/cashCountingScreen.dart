import 'package:deneme/constants/constants.dart';
import 'package:deneme/routing/bottomNavigationBar.dart';
import 'package:deneme/services/cashCountingServices.dart';
import 'package:deneme/widgets/button_widget.dart';
import 'package:deneme/widgets/text_form_field.dart';
import 'package:deneme/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import '../../../constants/bottomNaviBarLists.dart';
import '../../../constants/pagesLists.dart';


class CashCountingScreen extends StatefulWidget {

  int shop_code = 0;
  String shopName= "";

  static var kagitParaSayimi = "";
  static var madeniParaSsayimi = "";
  static var POSlarToplami = "";
  static var masraflarTediyeler = "";
  static var celikKasaMevcudu = "";
  static var kasaDefterMevcudu = "";
  static var fark = "";

  CashCountingScreen({super.key, required this.shop_code,required this.shopName});

  @override
  State<CashCountingScreen> createState() =>
      _CashCountingScreenState();
}

class _CashCountingScreenState extends State<CashCountingScreen> {

  late double deviceHeight;
  late double deviceWidth;

  DateTime now = DateTime.now();

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

    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          foregroundColor: Colors.white,
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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                shopCodeInfo(),
                shopNameInfo()
              ],
            ),
            SizedBox(height: deviceHeight*0.03,),
            inputForm(),
            SizedBox(height: deviceHeight*0.03,),
            saveButton(),
            SizedBox(height: deviceHeight*0.03,),
          ],
        ),
      );
    });
  }

  Widget shopNameInfo(){
    return TextWidget(text: widget.shopName, heightConst: 0, widhtConst: 0, size: 20, fontWeight: FontWeight.w400, color: Colors.black);
  }
  Widget shopCodeInfo(){
    return TextWidget(text: widget.shop_code.toString(), heightConst: 0, widhtConst: 0, size: 20, fontWeight: FontWeight.w400, color: Colors.black);
  }
  Widget saveButton(){
    return ButtonWidget(
        text: "Kaydet",
        heightConst: 0.06,
        widthConst: 0.8,
        size: 18,
        radius: 20,
        fontWeight: FontWeight.w600,
        onTaps: (){
          createCashCounting(
              widget.shop_code,
              (isBS)?userID:null,
              (isBS)?null:userID,
              now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString(),
              kagitParaSayimiController.text,
              madeniParaSsayimiController.text,
              POSlarToplamiController.text,
              masraflarTediyelerController.text,
              celikKasaMevcuduController.text,
              kasaDefterMevcuduController.text,
              farkController.text,
              "http://172.23.21.112:7042/api/CelikKasaSayimi"
          );
        },
        borderWidht: 1,
        backgroundColor: Colors.lightGreen.withOpacity(0.6),
        borderColor: Colors.lightGreen.withOpacity(0.6),
        textColor: Colors.black);
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
            TextFormFieldWidget(text: "Kağıt Para Sayımı", borderWidht: 2, titleColor: Colors.black, borderColor: Colors.black, controller: kagitParaSayimiController, value: CashCountingScreen.kagitParaSayimi, paddingValue: 5,maxLines: 1),
            SizedBox(height: deviceHeight*0.03,),
            TextFormFieldWidget(text: "Madeni Para Sayımı", borderWidht: 2, titleColor: Colors.black, borderColor: Colors.black, controller: madeniParaSsayimiController, value: CashCountingScreen.madeniParaSsayimi, paddingValue: 5,maxLines: 1),
            SizedBox(height: deviceHeight*0.03,),
            TextFormFieldWidget(text: "POS'lar Toplamı", borderWidht: 2, titleColor: Colors.black, borderColor: Colors.black, controller: POSlarToplamiController, value: CashCountingScreen.POSlarToplami, paddingValue: 5,maxLines: 1),
            SizedBox(height: deviceHeight*0.03,),
            TextFormFieldWidget(text: "Masraflar ve Tediyeler", borderWidht: 2, titleColor: Colors.black, borderColor: Colors.black, controller: masraflarTediyelerController, value: CashCountingScreen.masraflarTediyeler, paddingValue: 5,maxLines: 1),
            SizedBox(height: deviceHeight*0.03,),
            TextFormFieldWidget(text: "Çelik Kasa Mevcudu", borderWidht: 2, titleColor: Colors.black, borderColor: Colors.black, controller: celikKasaMevcuduController, value: CashCountingScreen.celikKasaMevcudu, paddingValue: 5,maxLines: 1),
            SizedBox(height: deviceHeight*0.03,),
            TextFormFieldWidget(text: "Kasa Defter Mevcudu", borderWidht: 2, titleColor: Colors.black, borderColor: Colors.black, controller: kasaDefterMevcuduController, value: CashCountingScreen.kasaDefterMevcudu, paddingValue: 5,maxLines: 1),
            SizedBox(height: deviceHeight*0.03,),
            TextFormFieldWidget(text: "Fark", borderWidht: 2, titleColor: Colors.black, borderColor: Colors.black, controller: farkController, value: CashCountingScreen.fark, paddingValue: 5,maxLines: 1)
          ],
        ),
      ),
    );
  }
}


