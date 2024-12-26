import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:deneme/constants/constants.dart';
import 'package:deneme/services/visitingDurationsServices.dart';
import 'package:deneme/styles/styleConst.dart';
import 'package:deneme/widgets/button_widget.dart';
import 'package:deneme/widgets/cards/shopVisitingProcessCard.dart';
import 'package:deneme/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../main.dart';
import '../../../routing/landing.dart';
import '../../../utils/appStateManager.dart';
import '../../../utils/generalFunctions.dart';

class ShopVisitingProcessesScreenSatisOperasyon extends StatefulWidget {
  int shop_code = 0;
  String shop_name = "";

  ShopVisitingProcessesScreenSatisOperasyon({super.key, required this.shop_code, required this.shop_name});

  @override
  State<ShopVisitingProcessesScreenSatisOperasyon> createState() => _ShopVisitingProcessesScreenSatisOperasyonState();
}

class _ShopVisitingProcessesScreenSatisOperasyonState extends State<ShopVisitingProcessesScreenSatisOperasyon> {
  List<String> splittedName = [];

  late double deviceHeight;
  late double deviceWidth;

  DateTime now = DateTime.now();

  bool isWithinTimeRange = true;

  final StoreVisitManager storeVisitManager = Get.put(StoreVisitManager());
  final StoreVisitManager2 storeVisitManager2 = Get.put(StoreVisitManager2());
  final ReportManager reportManager = Get.put(ReportManager());

  Timer? _timer;
  int _start = 0;

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _start++;
        boxVisitTimer.put('elapsedTime', _start);
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  String _formatTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();

    splittedName = widget.shop_name.split("/");

    DateTime startTime = DateTime(now.year, now.month, now.day, 8, 30);
    DateTime endTime = DateTime(now.year, now.month, now.day, 18, 30);

    isWithinTimeRange = now.isAfter(startTime) && now.isBefore(endTime);

    // Sayaç başlatma saatini alın
    DateTime? timerStartTime = boxVisitTimer.get('timerStartTime');

    // Eğer startTime kaydedilmişse, aradaki süreyi hesaplayın
    if (timerStartTime != null) {
      int elapsedSeconds = DateTime.now().difference(timerStartTime).inSeconds;
      _start = elapsedSeconds;
    } else {
      _start = boxVisitTimer.get('elapsedTime', defaultValue: 0) ?? 0;
    }

    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          foregroundColor: appbarForeground,
          backgroundColor: appbarBackground,
          title: const Text('Mağaza Ziyareti'),
        ),
        body: PopScope(
          canPop: false,
          onPopInvoked: (bool didPop) {},
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Container(
              alignment: Alignment.center,
              child: (isBS) ? shopVisitingProcessesScreenBSUI(context) : shopVisitingProcessesScreenPMUI(context),
            ),
          ),
        )
    );
  }

  Widget shopVisitingProcessesScreenBSUI(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              color: Colors.grey.withOpacity(0.4),
              height: deviceHeight * 0.13,
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Geçen süre:'),
                      Text(
                        _formatTime(_start),
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      stopVisitingButton(context),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: deviceHeight * 0.02),
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
                    (isWithinTimeRange)?ShopVisitingProcessCard(
                      heightConst: 0.25,
                      widthConst: 0.47,
                      processName: "Mağaza\nAçılış\nKontrolü",
                      processIcon: Icons.checklist,
                      onTaps: () {
                        _stopTimer();
                        naviShopOpeningCheckingScreen(context, widget.shop_code);
                      },
                    ): SizedBox(width: deviceWidth*0.0,),
                    ShopVisitingProcessCard(
                      heightConst: 0.25,
                      widthConst: 0.47,
                      processName: "Mağaza\nKapanış\nKontrolü",
                      processIcon: Icons.checklist,
                      onTaps: () {
                        _stopTimer();
                        naviShopClosingCheckingScreen(context, widget.shop_code);
                      },
                    )
                  ],
                ),
                (isWithinTimeRange)?Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ShopVisitingProcessCard(
                      heightConst: 0.25,
                      widthConst: 0.47,
                      processName: "Ziyaret Tespit\nRaporu Maddeleri",
                      processIcon: Icons.assignment,
                      onTaps: () {
                        _stopTimer();
                        naviVisitingReportTaskMainScreen(context, widget.shop_code,box.get("groupNo"));
                      },
                    ),
                    ShopVisitingProcessCard(
                      heightConst: 0.25,
                      widthConst: 0.47,
                      processName: "Yerinde\nGörevler",
                      processIcon: Icons.assignment,
                      onTaps: () {
                        _stopTimer();
                        naviInPlaceTaskMainScreen(context, widget.shop_code,box.get("groupNo"));
                      },
                    )
                  ],
                ): SizedBox(height: deviceHeight*0.0,),
                (isWithinTimeRange)?Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    /*ShopVisitingProcessCard(
                      heightConst: 0.25,
                      widthConst: 0.47,
                      processName: "Kasa\nSayımı",
                      processIcon: Icons.price_check,
                      onTaps: () {
                        _stopTimer();
                        naviCashCountingScreen(context, widget.shop_code, widget.shopName);
                      },
                    ),*/
                    ShopVisitingProcessCard(
                      heightConst: 0.25,
                      widthConst: 0.47,
                      processName: "Mağaza\nZiyaret\nFormu",
                      processIcon: Icons.content_paste_outlined,
                      onTaps: () async{
                        _stopTimer();
                        naviShopVisitingFormMainScreenBSSatisOperasyon(context,widget.shop_code);
                      },
                    ),
                  ],
                ): SizedBox(height: deviceHeight*0.0,),
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget shopVisitingProcessesScreenPMUI(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              color: Colors.grey.withOpacity(0.4),
              height: deviceHeight * 0.16,
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Geçen süre:'),
                      Text(
                        _formatTime(_start),
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      stopVisitingButton(context),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: deviceHeight * 0.02),
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
                    (isWithinTimeRange)?ShopVisitingProcessCard(
                      heightConst: 0.25,
                      widthConst: 0.47,
                      processName: "Mağaza\nAçılış\nKontrolü",
                      processIcon: Icons.checklist,
                      onTaps: () {
                        _stopTimer();
                        naviShopOpeningCheckingScreen(context, widget.shop_code);
                      },
                    ): SizedBox(width: deviceWidth*0.0,),
                    ShopVisitingProcessCard(
                      heightConst: 0.25,
                      widthConst: 0.47,
                      processName: "Mağaza\nKapanış\nKontrolü",
                      processIcon: Icons.checklist,
                      onTaps: () {
                        _stopTimer();
                        naviShopClosingCheckingScreen(context, widget.shop_code);
                      },
                    )
                  ],
                ),
                (isWithinTimeRange)?Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ShopVisitingProcessCard(
                      heightConst: 0.25,
                      widthConst: 0.47,
                      processName: "Ziyaret\nTespit\nRaporu",
                      processIcon: Icons.assignment,
                      onTaps: () {
                        _stopTimer();
                        naviVisitingReportMainScreen(context, widget.shop_code,box.get("groupNo"));
                      },
                    ),
                    ShopVisitingProcessCard(
                      heightConst: 0.25,
                      widthConst: 0.47,
                      processName: "Mağaza\nZiyaret\nFormu",
                      processIcon: Icons.content_paste_outlined,
                      onTaps: () async{
                        _stopTimer();
                        naviShopVisitingFormMainScreenPMSatisOperasyon(context,widget.shop_code);
                      },
                    ),
                  ],
                ): SizedBox(height: deviceHeight*0.0,),
                /*Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ShopVisitingProcessCard(
                      heightConst: 0.25,
                      widthConst: 0.47,
                      processName: "Kasa\nSayımı",
                      processIcon: Icons.price_check,
                      onTaps: () {
                        _stopTimer();
                        naviCashCountingScreen(context, widget.shop_code, widget.shopName);
                      },
                    ),
                  ],
                )*/
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget shopNameInfo() {
    return TextWidget(text: splittedName[0] + "\n" + splittedName[1], size: 18, fontWeight: FontWeight.w600, color: textColor);
  }

  Widget shopCodeInfo() {
    return TextWidget(text: "${widget.shop_code}", size: 20, fontWeight: FontWeight.w600, color: textColor);
  }

  Widget stopVisitingButton(BuildContext context) {
    return ButtonWidget(
      text: "Ziyareti Bitir",
      heightConst: 0.055,
      widthConst: 0.25,
      size: 15,
      radius: 20,
      fontWeight: FontWeight.w600,
      onTaps: () async{

        var connectivityResult = await (Connectivity().checkConnectivity());

        if(connectivityResult[0] == ConnectivityResult.none){
          showAlertDialogWidget(context, 'Internet Bağlantı Hatası', 'Telefonunuzun internet bağlantısı bulunmamaktadır. Lütfen telefonunuzu internete bağlayınız.', (){Navigator.of(context).pop();});
        }

        /*else if(box.get("inShopOpenForm")==0||box.get("outShopOpenForm")==0||box.get("inShopCloseForm")==0||box.get("outShopCloseForm")==0){
          showAlertDialogWidget(context, 'Form Hatası', 'Mağaza Formlarını doldurmadınız. Lütfen formların hepsini doldurunuz.', (){Navigator.of(context).pop();});
        }*/

        else if(connectivityResult[0] != ConnectivityResult.none){

          showAlertDialogWithoutButtonWidget(context,"Ziyaret Bitiriliyor","Ziyaretiniz bitiriliyor, lütfen bekleyiniz.");

          (isWithinTimeRange)?storeVisitManager.endStoreVisit():storeVisitManager2.endStoreVisit2();
          reportManager.noReport();

          box.put("visitingFinishTime", DateTime.now());
          String visitingDuration = calculateElapsedTime(box.get("visitingStartTime"), box.get("visitingFinishTime"));
          updateFinishHourWorkDurationVisitingDurations(
            box.get("visitingDurationsCount"),
            box.get('currentShopID'),
            (isBS == true) ? userID : null,
            (isBS == true) ? null : userID,
            (isWithinTimeRange)?box.get("visitingStartTime").toIso8601String():DateTime(now.year, now.month, now.day, 21, 0, 0,).toIso8601String(),
            (isWithinTimeRange)?box.get("visitingFinishTime").toIso8601String():DateTime(now.year, now.month, now.day, 21, 5, 0,).toIso8601String(),
            (isWithinTimeRange)?box.get("shiftDate"):DateTime(now.year, now.month, now.day, 21, 0, 0,).toIso8601String(),
            visitingDuration,
            "${constUrl}api/ZiyaretSureleri/${box.get("visitingDurationsCount")}",
          );

          _stopTimer();
          _start = 0; // Sayaç değerini sıfırla
          boxVisitTimer.put('elapsedTime', 0); // Ziyaret bittiğinde süreyi sıfırla
          boxVisitTimer.put('timerStartTime', null); // Sayaç başlangıç zamanını sil

          Navigator.of(context).pop(); // Close the dialog
          (isBS == true) ? naviShopVisitingShopsScreenBS(context) : naviShopVisitingShopsScreenPM(context);
        }
      },
      borderWidht: 1,
      backgroundColor: redColor,
      borderColor: redColor,
      textColor: textColor,
    );
  }

}
