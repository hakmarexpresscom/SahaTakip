import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:deneme/constants/constants.dart';
import 'package:flutter/material.dart';
import '../../../../../main.dart';
import '../../../../../models/shopVisitingFormPM.dart';
import '../../../../../routing/landing.dart';
import '../../../../../services/shopVisitingFormAnswersServices.dart';
import '../../../../../services/shopVisitingFormPMServices.dart';
import '../../../../../styles/styleConst.dart';
import '../../../../../utils/generalFunctions.dart';
import '../../../../../widgets/button_widget.dart';
import '../../../../../widgets/cards/shopVisitingFormItemCard.dart';

class ShopVisitingFormMainScreenPMSatisOperasyon extends StatefulWidget {
  int shop_code = 0;
  ShopVisitingFormMainScreenPMSatisOperasyon({super.key, required this.shop_code});

  @override
  State<ShopVisitingFormMainScreenPMSatisOperasyon> createState() =>
      _ShopVisitingFormMainScreenPMSatisOperasyonState();
}

class _ShopVisitingFormMainScreenPMSatisOperasyonState extends State<ShopVisitingFormMainScreenPMSatisOperasyon> with TickerProviderStateMixin {

  late Future<List<ShopVisitingFormPM>> futureShopVisitingFormPM;

  late double deviceHeight;
  late double deviceWidth;

  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    futureShopVisitingFormPM = fetchShopVisitingFormPM('${constUrl}api/MagazaZiyaretFormuPM');
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
  void dispose() {
    controller.dispose(); // AnimationController'ı temizle
    super.dispose();
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
        title: const Text('Mağaza Ziyaret Formu'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            naviShopVisitingProcessesScreen(context,box.get("currentShopID"),box.get("currentShopName"), box.get("groupNo"));
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: deviceHeight*0.02,),
          shopVisitingFormMainScreenPMUI(),
          SizedBox(height: deviceHeight*0.02,),
          saveButtonForm(context),
          SizedBox(height: deviceHeight*0.02,),
        ],
      ),
    );
  }

  Widget shopVisitingFormMainScreenPMUI(){
    return Expanded(
        child: FutureBuilder<List<ShopVisitingFormPM>>(
            future: futureShopVisitingFormPM,
            builder: (context, snapshot){
              if(snapshot.hasData){
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index){
                    if (snapshot.data![index].isActive == 1) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ShopVisitingFormItemCard(formItemText: snapshot.data![index].itemName,icon: Icons.arrow_forward_ios,onTaps: (){},),
                          SizedBox(height: deviceHeight*0.005,),
                        ],
                      );
                    }
                    else {
                      return Container();
                    }
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

  Widget saveButtonForm(BuildContext context){
    return ButtonWidget(
        text: "Formu Gönder",
        heightConst: 0.06,
        widthConst: 0.8,
        size: 18,
        radius: 20,
        fontWeight: FontWeight.w600,
        onTaps: () async{
          var connectivityResult = await (Connectivity().checkConnectivity());

          if(connectivityResult[0] == ConnectivityResult.none){
            showAlertDialogWidget(context, 'Internet Bağlantı Hatası', 'Telefonunuzun internet bağlantısı bulunmamaktadır. Lütfen telefonunuzu internete bağlayınız.', (){Navigator.of(context).pop();});
          }

          var formAnswers = boxPMSatisOperasyonShopVisitingFormShops.get(box.get("currentShopID"));
          bool allFieldsFilled = true;

          if (formAnswers != null) {
            for (var entry in formAnswers.entries) {
              if (entry.value[0] == "test" || entry.value[0].trim().isEmpty) {
                allFieldsFilled = false;
                break;
              }
            }
          }

          if (!allFieldsFilled) {
            showAlertDialogWidget(context, 'Eksik Bilgi', 'Formu yollamak için tüm maddeleri doldurmanız gerekmektedir!', () {Navigator.of(context).pop();},);
          }

          else if(connectivityResult[0] != ConnectivityResult.none && allFieldsFilled){
            showAlertDialogWithoutButtonWidget(context,"Form Yollanıyor","Formunuz veritabanına yollanıyor, lütfen bekleyiniz.");

            await createShopVisitingFormAnswers(
                (isBS==true)?userID:null,
                (isBS==true)?null:userID,
                box.get("currentShopID"),
                box.get("shiftDate"),
                convertMapToJsonString(boxPMSatisOperasyonShopVisitingFormShops.get(box.get("currentShopID"))),
                '${constUrl}api/MagazaZiyaretFormuCevaplar'
            );

            boxPMSatisOperasyonShopVisitingFormShops.get(box.get("currentShopID")).forEach((key, value) {boxPMSatisOperasyonShopVisitingFormShops.get(box.get("currentShopID"))[key] = ["test", "0"];});

            Navigator.of(context).pop(); // Close the dialog
            showAlertDialogWidget(context, 'Form Kaydedildi', 'Formunuz başarıyla veritabanına kaydedildi!', (){naviShopVisitingProcessesScreen(context,box.get("currentShopID"), box.get("currentShopName"),box.get("groupNo"));});
          }
        },
        borderWidht: 1,
        backgroundColor: secondaryColor,
        borderColor: secondaryColor,
        textColor: textColor);
  }
}