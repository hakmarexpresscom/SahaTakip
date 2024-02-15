import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../constants/constants.dart';
import '../../main.dart';
import '../../routing/landing.dart';
import '../../services/shiftServices.dart';
import '../../services/visitingDurationsServices.dart';
import '../../styles/styleConst.dart';
import '../../utils/appStateManager.dart';
import '../../utils/generalFunctions.dart';
import '../../widgets/alert_dialog.dart';

class WarningScreen extends StatefulWidget {
  const WarningScreen({super.key});

  @override
  State<WarningScreen> createState() => _WarningScreenState();
}

class _WarningScreenState extends State<WarningScreen> {

  late double deviceHeight;
  late double deviceWidth;

  DateTime now = DateTime.now();

  final ShopVisitWorkManager shopVisitWorkManager = Get.put(ShopVisitWorkManager());
  final StoreVisitManager storeVisitManager = Get.put(StoreVisitManager());

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
          title: const Text('Uyarı Ekranı'),
        ),
        body: Container(
            alignment: Alignment.center,
            child: showShiftTimeDialog(context),
          ),
        );
  }

  showShiftTimeDialog(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialogWidget(
            title: 'Mesai Saati Kontrolü',
            content: 'Mağaza ziyaretini durdurmayı unuttuğunuz için uygulama ziyareti otomatik olarak durdurmuştur!',
            onTaps: () async{
              if(boxStateManagement.get('isStoreVisit')==true){
                storeVisitManager.endStoreVisit();
                box.put("visitingFinishHour",DateTime.now().hour);
                box.put("visitingFinishMinute",DateTime.now().minute);
                box.put("visitingFinishSecond",DateTime.now().second);
                List<dynamic> tarih = box.get("shiftDate").split("-");
                String visitingDuration = calculateElapsedTime(DateTime(int.parse(tarih[2]),int.parse(tarih[1]),int.parse(tarih[0]),box.get("visitingStartHour"),box.get("visitingStartMinute"),box.get("visitingStartSecond"),0,0),DateTime(int.parse(tarih[2]),int.parse(tarih[1]),int.parse(tarih[0]),box.get("visitingFinishHour"),box.get("visitingFinishMinute"),box.get("visitingFinishSecond"),0,0));
                await countVisitingDurations("${constUrl}api/ZiyaretSureleri");
                await createVisitingDurations(
                    box.get('currentShopID'),
                    (isBS==true)?userID:null,
                    (isBS==true)?null:userID,
                    box.get("visitingStartHour").toString()+":"+box.get("visitingStartMinute").toString()+":"+box.get("visitingStartSecond").toString(),
                    box.get("visitingFinishHour").toString()+":"+box.get("visitingFinishMinute").toString()+":"+box.get("visitingFinishSecond").toString(),
                    box.get("shiftDate"),
                    visitingDuration,
                    "${constUrl}api/ZiyaretSureleri"
                );
              }
              shopVisitWorkManager.endShopVisitWork();
              List<dynamic> tarih = box.get("shiftDate").split("-");
              String workDuration = calculateElapsedTime(DateTime(int.parse(tarih[2]),int.parse(tarih[1]),int.parse(tarih[0]),box.get("startHour"),box.get("startMinute"),box.get("startSecond"),0,0),DateTime(int.parse(tarih[2]),int.parse(tarih[1]),int.parse(tarih[0]),18,30,0,0,0));
              await createShift(
                  (isBS)?userID:null,
                  (isBS)?null:userID,
                  "Mağaza Ziyareti",
                  box.get("shiftDate"),
                  box.get("startHour").toString()+":"+box.get("startMinute").toString()+":"+box.get("startSecond").toString(),
                  "18:30:0",
                  workDuration,
                  "${constUrl}api/mesai"
              );
              naviStartWorkMainScreen(context);
            },
          );
        },
      );
    });
  }
}
