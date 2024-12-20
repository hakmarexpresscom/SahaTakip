import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:deneme/constants/constants.dart';
import 'package:flutter/material.dart';
import '../../../../../main.dart';
import '../../../../../models/shopVisitingFormBS.dart';
import '../../../../../routing/landing.dart';
import '../../../../../services/shopVisitingFormAnswersServices.dart';
import '../../../../../services/shopVisitingFormBSServices.dart';
import '../../../../../styles/styleConst.dart';
import '../../../../../utils/generalFunctions.dart';
import '../../../../../utils/sendShopVisitingFormMailFunctions.dart';
import '../../../../../widgets/button_widget.dart';
import '../../../../../widgets/cards/shopVisitingFormItemCard.dart';

class ShopVisitingFormMainScreenBSSatisOperasyon extends StatefulWidget {
  int shop_code = 0;
  ShopVisitingFormMainScreenBSSatisOperasyon({super.key, required this.shop_code});

  @override
  State<ShopVisitingFormMainScreenBSSatisOperasyon> createState() =>
      _ShopVisitingFormMainScreenBSSatisOperasyonState();
}

class _ShopVisitingFormMainScreenBSSatisOperasyonState extends State<ShopVisitingFormMainScreenBSSatisOperasyon> with TickerProviderStateMixin {

  late Future<List<ShopVisitingFormBS>> futureShopVisitingFormBS;

  late double deviceHeight;
  late double deviceWidth;

  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    futureShopVisitingFormBS = fetchShopVisitingFormBS('${constUrl}api/MagazaZiyaretFormuBS');
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
          shopVisitingFormMainScreenBSSatisOperasyonUI(),
          SizedBox(height: deviceHeight*0.02,),
          saveButtonForm(context),
          SizedBox(height: deviceHeight*0.02,),
        ],
      ),
    );
  }

  Widget shopVisitingFormMainScreenBSSatisOperasyonUI() {
    return Expanded(
      child: FutureBuilder<List<ShopVisitingFormBS>>(
        future: futureShopVisitingFormBS,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // Listeyi al
            List<ShopVisitingFormBS> formItems = snapshot.data!
                .where((item) => item.isActive == 1)
                .toList();

            // Sıralama işlemi
            formItems.sort((a, b) {
              String itemID_A = a.itemID.toString();
              String itemID_B = b.itemID.toString();

              bool isAnsweredA = boxBSSatisOperasyonShopVisitingFormShops
                  .get(box.get("currentShopID"))[itemID_A][0] !=
                  "test";
              bool isAnsweredB = boxBSSatisOperasyonShopVisitingFormShops
                  .get(box.get("currentShopID"))[itemID_B][0] !=
                  "test";

              if (isAnsweredA == isAnsweredB) {
                return 0; // İkisi de aynı durumdaysa sıralamayı değiştirme
              }
              return isAnsweredA ? 1 : -1; // Cevaplanmış olanlar sona gider
            });

            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: formItems.length,
              itemBuilder: (BuildContext context, int index) {
                String itemID = formItems[index].itemID.toString();
                bool isAnswered = boxBSSatisOperasyonShopVisitingFormShops
                    .get(box.get("currentShopID"))[itemID][0] !=
                    "test"; // Cevaplanma durumu kontrolü

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ShopVisitingFormItemCard(
                      formItemText: formItems[index].itemName,
                      icon: Icons.arrow_forward_ios,
                      isAnswered: isAnswered,
                      onTaps: () {
                        naviShopVisitingFormDetailScreenBSSatisOperasyon(
                            context, formItems[index].itemID, formItems[index].itemName);
                      },
                    ),
                    SizedBox(
                      height: deviceHeight * 0.005,
                    ),
                  ],
                );
              },
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Column(children: [
              SizedBox(
                height: deviceHeight * 0.06,
              ),
              CircularProgressIndicator(
                value: controller.value,
                semanticsLabel: 'Circular progress indicator',
              ),
            ]);
          } else {
            return Text("Veri yok");
          }
        },
      ),
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

          var formAnswers = boxBSSatisOperasyonShopVisitingFormShops.get(box.get("currentShopID"));
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
              convertMapToJsonString(boxBSSatisOperasyonShopVisitingFormShops.get(box.get("currentShopID"))),
              '${constUrl}api/MagazaZiyaretFormuCevaplar'
            );

            await sendShopVisitingFormMail(
              box.get("groupNo"),
              boxBSSatisOperasyonShopVisitingFormShops.get("questions"),
              boxBSSatisOperasyonShopVisitingFormShops.get(box.get("currentShopID")),
              "${box.get("currentShopID")} ${box.get("currentShopName")} Bölge Sorumlusu Ziyaret Formu",
              [
                box.get("PMEmail"),
                box.get("BMEmail"),
                box.get("userEmail"),
                "mag${box.get("currentShopID")}@hakmarmagazacilik.com.tr"
              ]
            );

            boxBSSatisOperasyonShopVisitingFormShops.get(box.get("currentShopID")).forEach((key, value) {
              boxBSSatisOperasyonShopVisitingFormShops.get(box.get("currentShopID"))[key] = ["test", "0"];
            });

            Navigator.of(context).pop(); // Close the dialog
            showAlertDialogWidget(context, 'Form Kaydedildi', 'Formunuz başarıyla veritabanına kaydedildi!', (){
              naviShopVisitingProcessesScreen(context,box.get("currentShopID"), box.get("currentShopName"),box.get("groupNo"));
            });
          }
        },
        borderWidht: 1,
        backgroundColor: secondaryColor,
        borderColor: secondaryColor,
        textColor: textColor);
  }
}