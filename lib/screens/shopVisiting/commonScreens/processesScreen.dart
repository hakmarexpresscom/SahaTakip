import 'package:deneme/constants/constants.dart';
import 'package:deneme/widgets/button_widget.dart';
import 'package:deneme/widgets/cards/shopVisitingProcessCard.dart';
import 'package:deneme/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../routing/landing.dart';
import '../../../utils/appStateManager.dart';

class ShopVisitingProcessesScreen extends StatefulWidget {
  int shop_code = 0;
  String shopName = "";

  ShopVisitingProcessesScreen({super.key, required this.shop_code,required this.shopName});

  @override
  State<ShopVisitingProcessesScreen> createState() =>
      _ShopVisitingProcessesScreenState();
}

class _ShopVisitingProcessesScreenState extends State<ShopVisitingProcessesScreen> {

  List<String> splittedName=[];

  late double deviceHeight;
  late double deviceWidth;

  DateTime now = DateTime.now();

  final StoreVisitManager storeVisitManager = Get.put(StoreVisitManager());

  @override
  void initState() {
    super.initState();
    splittedName = widget.shopName.split("/");
  }

  @override
  Widget build(BuildContext context) {

    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          foregroundColor: Colors.white,
          backgroundColor: Colors.indigo,
          title: const Text('Mağaza Ziyareti'),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child:Container(
            alignment: Alignment.center,
            child: (isBS)?shopVisitingProcessesScreenBSUI():shopVisitingProcessesScreenPMUI(),
          ),
        ),
    );
  }

  Widget shopVisitingProcessesScreenBSUI(){
    return Builder(builder: (BuildContext context){
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              color: Colors.grey.withOpacity(0.4),
              height: deviceHeight*0.18,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      shopCodeInfo(),
                      shopNameInfo(),
                    ],
                  ),
                  stopVisitingButton(),
                ],
              ),
            ),
            SizedBox(height: deviceHeight*0.02,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ShopVisitingProcessCard(heightConst: 0.25, widthConst: 0.47, processName: "Mağaza\nAçılış\nKontrolü", processIcon: Icons.store,onTaps: (){naviShopOpeningCheckingScreen(context, widget.shop_code);}),
                      ShopVisitingProcessCard(heightConst: 0.25, widthConst: 0.47, processName: "Mağaza\nKapanış\nKontrolü", processIcon: Icons.store,onTaps: (){naviShopClosingCheckingScreen(context, widget.shop_code);}),
                    ]
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ShopVisitingProcessCard(heightConst: 0.25, widthConst: 0.47, processName: "Ziyaret\nRaporu\nGörevleri", processIcon: Icons.assignment,onTaps: (){naviVisitingReportTaskMainScreen(context,widget.shop_code);}),
                      ShopVisitingProcessCard(heightConst: 0.25, widthConst: 0.47, processName: "Yerinde\nGörevler", processIcon: Icons.assignment,onTaps: (){naviInPlaceTaskMainScreen(context, widget.shop_code);}),
                    ]
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ShopVisitingProcessCard(heightConst: 0.25, widthConst: 0.47, processName: "Kasa\nSayımı", processIcon: Icons.price_check,onTaps: (){naviCashCountingScreen(context, widget.shop_code, widget.shopName);}),
                    ]
                ),
              ],
            )
          ],
        ));
    });
  }

  Widget shopVisitingProcessesScreenPMUI(){
    return Builder(builder: (BuildContext context){
      return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                color: Colors.grey.withOpacity(0.4),
                height: deviceHeight*0.18,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        shopCodeInfo(),
                        shopNameInfo(),
                      ],
                    ),
                    stopVisitingButton(),
                  ],
                ),
              ),
              SizedBox(height: deviceHeight*0.02,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        ShopVisitingProcessCard(heightConst: 0.25, widthConst: 0.47, processName: "Mağaza\nAçılış\nKontrolü", processIcon: Icons.store,onTaps: (){naviShopOpeningCheckingScreen(context, widget.shop_code);}),
                        ShopVisitingProcessCard(heightConst: 0.25, widthConst: 0.47, processName: "Mağaza\nKapanış\nKontrolü", processIcon: Icons.store,onTaps: (){naviShopClosingCheckingScreen(context, widget.shop_code);}),
                      ]
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        ShopVisitingProcessCard(heightConst: 0.25, widthConst: 0.47, processName: "Ziyaret\nTespit Raporu\nGirişi", processIcon: Icons.assignment,onTaps: (){naviVisitingReportMainScreen(context,widget.shop_code);}),
                        ShopVisitingProcessCard(heightConst: 0.25, widthConst: 0.47, processName: "Kasa\nSayımı", processIcon: Icons.price_check,onTaps: (){naviCashCountingScreen(context, widget.shop_code, widget.shopName);}),
                      ]
                  ),
                ],
              )
            ],
          ));
    });
  }


  Widget shopNameInfo(){
    return TextWidget(text: splittedName[0]+"\n"+splittedName[1], size: 18, fontWeight: FontWeight.w600, color: Colors.black);
  }
  Widget shopCodeInfo(){
    return TextWidget(text: "${widget.shop_code}", size: 20, fontWeight: FontWeight.w600, color: Colors.black);
  }
  Widget stopVisitingButton(){
    return ButtonWidget(
        text: "Ziyareti Bitir",
        heightConst: 0.05,
        widthConst: 0.22,
        size: 15,
        radius: 20,
        fontWeight: FontWeight.w600,
        onTaps: (){
          storeVisitManager.endStoreVisit();
          (isBS==true)?naviShopVisitingShopsScreen(context):naviShopVisitingShopsScreenPM(context);
          },
        borderWidht: 1,
        backgroundColor: Colors.red.withOpacity(0.6),
        borderColor: Colors.red.withOpacity(0.6),
        textColor: Colors.black);
  }

}


