import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:deneme/constants/constants.dart';
import 'package:deneme/services/visitingDurationsServices.dart';
import 'package:deneme/styles/styleConst.dart';
import 'package:deneme/widgets/button_widget.dart';
import 'package:deneme/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../main.dart';
import '../../../routing/landing.dart';
import '../../../utils/appStateManager.dart';
import '../../../utils/generalFunctions.dart';
import '../../../constants/bottomNaviBarLists.dart';
import '../../../constants/pagesLists.dart';
import '../../../routing/bottomNavigationBar.dart';

class RegionCenterVisitingProcessesScreenUnkar extends StatefulWidget {
  int region_code = 0;
  String region_name = "";

  RegionCenterVisitingProcessesScreenUnkar({super.key, required this.region_code, required this.region_name});

  @override
  State<RegionCenterVisitingProcessesScreenUnkar> createState() => _RegionCenterVisitingProcessesScreenUnkarState();
}

class _RegionCenterVisitingProcessesScreenUnkarState extends State<RegionCenterVisitingProcessesScreenUnkar> {
  int _selectedIndex = 0;

  late double deviceHeight;
  late double deviceWidth;

  List<BottomNavigationBarItem> naviBarList = [];
  List<Widget> pageList = [];

  DateTime now = DateTime.now();

  final RegionCenterVisitManager regionCenterVisitManager = Get.put(RegionCenterVisitManager());

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

    void userCondition(String user) {
      if(user=="BS" && box.get("groupNo") == 2 && box.get("groupNo") == 3){
        naviBarList = itemListTZ;
        if(isStartShiftObs.value==false&&isRegionCenterVisitInProgress.value==false){
          pageList = pagesUnkarTZ;
        }
        else if(isStartShiftObs.value&&isRegionCenterVisitInProgress.value==false){
          pageList = pagesUnkarTZ2;
        }
      }
      else if (user == "BS") {
        naviBarList = itemListBS;
        if (isStartShiftObs.value == false && isRegionCenterVisitInProgress.value == false) {
          pageList = pagesBS;
        }
        else if (isStartShiftObs.value && isRegionCenterVisitInProgress.value == false) {
          pageList = pagesBS2;
        }
      }
      else if (user == "PM") {
        naviBarList = itemListPM;
        if (isStartShiftObs.value == false && isRegionCenterVisitInProgress.value == false) {
          pageList = pagesPM;
        }
        else if (isStartShiftObs.value && isRegionCenterVisitInProgress.value == false) {
          pageList = pagesPM2;
        }
      }
      else if (user == "BM" || user == "GK") {
        naviBarList = itemListBMandGK;
        pageList = pagesBMGK;
      }
      else if (user == "NK") {
        naviBarList = itemListNK;
        pageList = pagesNK;
      }
    }

    userCondition(userType);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        foregroundColor: appbarForeground,
        backgroundColor: appbarBackground,
        title: const Text('Bölge Merkezi Ziyareti'),
      ),
      body: PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) {},
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Container(
            alignment: Alignment.center,
            child: regionCenterVisitingMainScreenUI(),
          ),
        ),
      ),
      bottomNavigationBar: BottomNaviBar(
        selectedIndex: _selectedIndex,
        itemList: naviBarList,
        pageList: pageList,
      ),
    );
  }

  Widget regionCenterVisitingMainScreenUI() {
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
            Container()
          ],
        ),
      );
    });
  }

  Widget shopNameInfo() {
    return TextWidget(text: widget.region_name, size: 18, fontWeight: FontWeight.w600, color: textColor);
  }

  Widget shopCodeInfo() {
    return TextWidget(text: "${widget.region_code}", size: 20, fontWeight: FontWeight.w600, color: textColor);
  }

  Widget stopVisitingButton(BuildContext context) {
    return ButtonWidget(
        text: "Ziyareti Bitir",
        heightConst: 0.055,
        widthConst: 0.25,
        size: 15,
        radius: 20,
        fontWeight: FontWeight.w600,
        onTaps: () async {
          var connectivityResult = await (Connectivity().checkConnectivity());

          if (connectivityResult == ConnectivityResult.none) {
            showAlertDialogWidget(context, 'Internet Bağlantı Hatası', 'Telefonunuzun internet bağlantısı bulunmamaktadır. Lütfen telefonunuzu internete bağlayınız.', () { Navigator.of(context).pop(); });
          }
          else if (connectivityResult != ConnectivityResult.none) {
            showAlertDialogWithoutButtonWidget(context, "Ziyaret Bitiriliyor", "Ziyaretiniz bitiriliyor, lütfen bekleyiniz.");

            regionCenterVisitManager.endRegionCenterVisit();
            box.put("visitingFinishTime", DateTime.now());
            String visitingDuration = calculateElapsedTime(box.get("visitingStartTime"), box.get("visitingFinishTime"));
            updateFinishHourWorkDurationVisitingDurations(
                box.get("visitingDurationsCount"),
                box.get('currentCenterID'),
                (isBS == true) ? userID : null,
                (isBS == true) ? null : userID,
                box.get("visitingStartTime").toIso8601String(),
                box.get("visitingFinishTime").toIso8601String(),
                box.get("shiftDate"),
                visitingDuration,
                "${constUrl}api/ZiyaretSureleri/${box.get("visitingDurationsCount")}"
            );

            _stopTimer();
            _start = 0; // Sayaç değerini sıfırla
            boxVisitTimer.put('elapsedTime', 0); // Ziyaret bittiğinde süreyi sıfırla
            boxVisitTimer.put('timerStartTime', null); // Sayaç başlangıç zamanını sil

            Navigator.of(context).pop(); // Close the dialog
            naviShiftTypeScreen(context);
          }
        },
        borderWidht: 1,
        backgroundColor: redColor,
        borderColor: redColor,
        textColor: textColor
    );
  }
}
