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
  final ExternalTaskWorkManager externalTaskWorkManager = Get.put(ExternalTaskWorkManager());

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
                box.put("visitingFinishTime",DateTime.now());
                String visitingDuration = calculateElapsedTime(box.get("visitingStartTime"),box.get("visitingFinishTime"));
                await createVisitingDurations(
                    box.get('currentShopID'),
                    (isBS==true)?userID:null,
                    (isBS==true)?null:userID,
                    box.get("visitingStartTime").toIso8601String(),
                    box.get("visitingFinishTime").toIso8601String(),
                    box.get("shiftDate"),
                    visitingDuration,
                    "${constUrl}api/ZiyaretSureleri"
                );
              }
              else if(boxStateManagement.get('isStartShopVisitWork')==true&&boxStateManagement.get('isStoreVisit')==false){
                shopVisitWorkManager.endShopVisitWork();
                box.put("finishTime",DateTime.now());
                String workDuration = calculateElapsedTime(box.get("startTime"),box.get("finishTime"));
                await createShift(
                    (isBS)?userID:null,
                    (isBS)?null:userID,
                    "Mağaza Ziyareti",
                    box.get("shiftDate"),
                    box.get("startTime").toIso8601String(),
                    box.get("finishTime").toIso8601String(),
                    workDuration,
                    "${constUrl}api/mesai"
                );
              }
              else if(boxStateManagement.get('isStartExternalTaskWork')==true){
                externalTaskWorkManager.endExternalTaskWork();
                box.put("finishTime",DateTime.now());
                String workDuration = calculateElapsedTime(box.get("startTime"),box.get("finishTime"));
                await createShift(
                    (isBS)?userID:null,
                    (isBS)?null:userID,
                    "Harici İş",
                    box.get("shiftDate"),
                    box.get("startTime").toIso8601String(),
                    box.get("finishTime").toIso8601String(),
                    workDuration,
                    "${constUrl}api/mesai"
                );
              }
              naviStartWorkMainScreen(context);
            },
          );
        },
      );
    });
  }
}
