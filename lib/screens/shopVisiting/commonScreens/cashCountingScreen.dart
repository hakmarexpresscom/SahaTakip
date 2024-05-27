import 'package:deneme/constants/constants.dart';
import 'package:deneme/models/cashCounting.dart';
import 'package:deneme/routing/landing.dart';
import 'package:deneme/services/cashCountingServices.dart';
import 'package:deneme/widgets/button_widget.dart';
import 'package:deneme/widgets/text_form_field.dart';
import 'package:deneme/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import '../../../main.dart';
import '../../../styles/styleConst.dart';
import '../../../widgets/alert_dialog.dart';

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

  late Future<List<CashCounting>> futureCashCounting;

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
  void initState() {
    super.initState();
    futureCashCounting = fetchCashCounting('${constUrl}api/CelikKasaSayimi/filterCashCountingForm?magaza_kodu=${widget.shop_code}&kayit_tarihi=${DateTime.now().toIso8601String()}');
    kagitParaSayimiController.addListener(_updateCelikKasaMevcudu);
    madeniParaSsayimiController.addListener(_updateCelikKasaMevcudu);
    celikKasaMevcuduController.addListener(_updateFark);
    kasaDefterMevcuduController.addListener(_updateFark);
  }

  @override
  void dispose() {
    kagitParaSayimiController.removeListener(_updateCelikKasaMevcudu);
    madeniParaSsayimiController.removeListener(_updateCelikKasaMevcudu);
    kagitParaSayimiController.dispose();
    madeniParaSsayimiController.dispose();
    POSlarToplamiController.dispose();
    masraflarTediyelerController.dispose();
    celikKasaMevcuduController.removeListener(_updateFark);
    kasaDefterMevcuduController.removeListener(_updateFark);
    farkController.dispose();
    super.dispose();
  }

  void _updateCelikKasaMevcudu() {
    double kagitPara = double.tryParse(kagitParaSayimiController.text) ?? 0.0;
    double madeniPara = double.tryParse(madeniParaSsayimiController.text) ?? 0.0;
    double toplam = kagitPara + madeniPara;
    setState(() {
      celikKasaMevcuduController.text = toplam.toString();
    });
  }

  void _updateFark() {
    double celikKasaMevcudu = double.tryParse(celikKasaMevcuduController.text) ?? 0.0;
    double kasaDefterMevcudu = double.tryParse(kasaDefterMevcuduController.text) ?? 0.0;
    double fark = celikKasaMevcudu - kasaDefterMevcudu;
    setState(() {
      farkController.text = fark.toString();
    });
  }

  @override
  Widget build(BuildContext context) {

    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          foregroundColor: appbarForeground,
          backgroundColor: appbarBackground,
          title: const Text('Çelik Kasa Sayımı'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              naviShopVisitingProcessesScreen(context, box.get('currentShopID'), box.get('currentShopName'));
            },
          ),
        ),
        body: SingleChildScrollView(
          child:Container(
            alignment: Alignment.center,
            child: FutureBuilder<List<CashCounting>>(
                    future: futureCashCounting,
                    builder: (context, snapshot){
                      if(snapshot.hasData){
                        return Text("Kasa sayımı formunu bu ziyaret için doldurdunuz.");
                      }
                      else{
                        return cashCountingScreenUI();
                      }
                    }
                ),
          )
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
    return TextWidget(text: widget.shopName, size: 20, fontWeight: FontWeight.w400, color: textColor);
  }
  Widget shopCodeInfo(){
    return TextWidget(text: widget.shop_code.toString(), size: 20, fontWeight: FontWeight.w400, color: textColor);
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
              now.toIso8601String(),
              kagitParaSayimiController.text,
              madeniParaSsayimiController.text,
              POSlarToplamiController.text,
              masraflarTediyelerController.text,
              celikKasaMevcuduController.text,
              kasaDefterMevcuduController.text,
              farkController.text,
              "${constUrl}api/CelikKasaSayimi"
          );
          showFormFilledDialog(context);
        },
        borderWidht: 1,
        backgroundColor: secondaryColor,
        borderColor: secondaryColor,
        textColor: textColor);
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
            TextFormFieldWidget(text: "Kağıt Para Sayımı", borderWidht: 2, titleColor: textColor, borderColor: Colors.black, controller: kagitParaSayimiController, value: CashCountingScreen.kagitParaSayimi, paddingValue: 5,maxLines: 1,maxLength: 50,controllerString: kagitParaSayimiController.text, enabled: true,),
            SizedBox(height: deviceHeight*0.02,),
            TextFormFieldWidget(text: "Madeni Para Sayımı", borderWidht: 2, titleColor: textColor, borderColor: Colors.black, controller: madeniParaSsayimiController, value: CashCountingScreen.madeniParaSsayimi, paddingValue: 5,maxLines: 1,maxLength: 50,controllerString: madeniParaSsayimiController.text, enabled: true,),
            SizedBox(height: deviceHeight*0.02,),
            TextFormFieldWidget(text: "POS'lar Toplamı", borderWidht: 2, titleColor: textColor, borderColor: Colors.black, controller: POSlarToplamiController, value: CashCountingScreen.POSlarToplami, paddingValue: 5,maxLines: 1,maxLength: 50,controllerString: POSlarToplamiController.text, enabled: true,),
            SizedBox(height: deviceHeight*0.02,),
            TextFormFieldWidget(text: "Masraflar ve Tediyeler", borderWidht: 2, titleColor: textColor, borderColor: Colors.black, controller: masraflarTediyelerController, value: CashCountingScreen.masraflarTediyeler, paddingValue: 5,maxLines: 1,maxLength: 50,controllerString: masraflarTediyelerController.text, enabled: true,),
            SizedBox(height: deviceHeight*0.02,),
            TextFormFieldWidget(text: "Çelik Kasa Mevcudu", borderWidht: 2, titleColor: textColor, borderColor: Colors.black, controller: celikKasaMevcuduController, value: CashCountingScreen.celikKasaMevcudu, paddingValue: 5,maxLines: 1,maxLength: 50,controllerString: celikKasaMevcuduController.text, enabled: false,),
            SizedBox(height: deviceHeight*0.02,),
            TextFormFieldWidget(text: "Kasa Defter Mevcudu", borderWidht: 2, titleColor: textColor, borderColor: Colors.black, controller: kasaDefterMevcuduController, value: CashCountingScreen.kasaDefterMevcudu, paddingValue: 5,maxLines: 1,maxLength: 50,controllerString: kasaDefterMevcuduController.text, enabled: true,),
            SizedBox(height: deviceHeight*0.02,),
            TextFormFieldWidget(text: "Fark", borderWidht: 2, titleColor: textColor, borderColor: Colors.black, controller: farkController, value: CashCountingScreen.fark, paddingValue: 5,maxLines: 1,maxLength: 50,controllerString: farkController.text, enabled: false,)
          ],
        ),
      ),
    );
  }

  showFormFilledDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialogWidget(
            title: 'Kontroller Yapıldı',
            content: 'Kasa sayımı formunu başarıyla doldurdunuz!',
            onTaps: (){
              naviCashCountingScreen(context, widget.shop_code, widget.shopName);
            },
          );
        }
    );
  }
}


