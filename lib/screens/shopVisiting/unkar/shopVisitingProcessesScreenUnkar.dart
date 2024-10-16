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

class ShopVisitingProcessesScreenUnkar extends StatefulWidget {
  int shop_code = 0;
  String shopName = "";

  ShopVisitingProcessesScreenUnkar({super.key, required this.shop_code, required this.shopName});

  @override
  State<ShopVisitingProcessesScreenUnkar> createState() => _ShopVisitingProcessesScreenUnkarState();
}

class _ShopVisitingProcessesScreenUnkarState extends State<ShopVisitingProcessesScreenUnkar> {
  List<String> splittedName = [];

  late double deviceHeight;
  late double deviceWidth;

  DateTime now = DateTime.now();

  final StoreVisitManager storeVisitManager = Get.put(StoreVisitManager());

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

    splittedName = widget.shopName.split("/");

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
                    ShopVisitingProcessCard(
                      heightConst: 0.25,
                      widthConst: 0.47,
                      processName: "Ekmek\nGrubu\nFormu",
                      processIcon: Icons.assignment,
                      onTaps: () {
                        _stopTimer();
                        naviBreadGroupFormScreen(context, widget.shop_code);
                      },
                    ),
                    ShopVisitingProcessCard(
                      heightConst: 0.25,
                      widthConst: 0.47,
                      processName: "Tatbak\nGrubu\nFormu",
                      processIcon: Icons.checklist,
                      onTaps: () {
                        _stopTimer();
                        naviTatbakGroupFormScreen(context, widget.shop_code);
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ShopVisitingProcessCard(
                      heightConst: 0.25,
                      widthConst: 0.47,
                      processName: "Donuk Urunler\nGrubu\nFormu",
                      processIcon: Icons.assignment,
                      onTaps: () {
                        _stopTimer();
                        naviFrozenGroupFormScreen(context, widget.shop_code);
                      },
                    ),
                  ],
                ),
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
                    ShopVisitingProcessCard(
                      heightConst: 0.25,
                      widthConst: 0.47,
                      processName: "Ekmek\nGrubu\nFormu",
                      processIcon: Icons.assignment,
                      onTaps: () {
                        _stopTimer();
                        naviBreadGroupFormScreen(context, widget.shop_code);
                      },
                    ),
                    ShopVisitingProcessCard(
                      heightConst: 0.25,
                      widthConst: 0.47,
                      processName: "Tatbak\nGrubu\nFormu",
                      processIcon: Icons.checklist,
                      onTaps: () {
                        _stopTimer();
                        naviTatbakGroupFormScreen(context, widget.shop_code);
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ShopVisitingProcessCard(
                      heightConst: 0.25,
                      widthConst: 0.47,
                      processName: "Donuk Urunler\nGrubu\nFormu",
                      processIcon: Icons.assignment,
                      onTaps: () {
                        _stopTimer();
                        naviFrozenGroupFormScreen(context, widget.shop_code);
                      },
                    ),
                  ],
                ),
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

        else if(box.get("breadGroupForm")==0||box.get("frozenGroupForm")||box.get("tatbakGroupForm")==0){
          showAlertDialogWidget(context, 'Form Hatası', 'Mağaza Formunlarını doldurmadınız. Lütfen formlarını hepsini doldurunuz.', (){Navigator.of(context).pop();});
        }

        else if(connectivityResult[0] != ConnectivityResult.none){

          showAlertDialogWithoutButtonWidget(context,"Ziyaret Bitiriliyor","Ziyaretiniz bitiriliyor, lütfen bekleyiniz.");

          storeVisitManager.endStoreVisit();
          box.put("visitingFinishTime", DateTime.now());
          String visitingDuration = calculateElapsedTime(box.get("visitingStartTime"), box.get("visitingFinishTime"));
          updateFinishHourWorkDurationVisitingDurations(
            box.get("visitingDurationsCount"),
            box.get('currentShopID'),
            (isBS == true) ? userID : null,
            (isBS == true) ? null : userID,
            box.get("visitingStartTime").toIso8601String(),
            box.get("visitingFinishTime").toIso8601String(),
            box.get("shiftDate"),
            visitingDuration,
            "${constUrl}api/ZiyaretSureleri/${box.get("visitingDurationsCount")}",
          );

          _stopTimer();
          _start = 0; // Sayaç değerini sıfırla
          boxVisitTimer.put('elapsedTime', 0); // Ziyaret bittiğinde süreyi sıfırla
          boxVisitTimer.put('timerStartTime', null); // Sayaç başlangıç zamanını sil

          Navigator.of(context).pop(); // Close the dialog
          //(isBS == true) ? naviShopVisitingShopsScreenBS(context) : naviShopVisitingShopsScreenPM(context);
          naviShopVisitingBeforeAfterPhotoScreen(context, false);
        }
      },
      borderWidht: 1,
      backgroundColor: redColor,
      borderColor: redColor,
      textColor: textColor,
    );
  }

}
