import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../constants/constants.dart';
import '../../main.dart';
import '../../routing/landing.dart';
import '../../services/shiftServices.dart';
import '../../utils/appStateManager.dart';
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
              shopVisitWorkManager.endShopVisitWork();
              await countShift("http://172.23.21.112:7042/api/Mesai");
              await createShift(shiftCount+1,(isBS)?userID:null,(isBS)?null:userID,"Mağaza Ziyareti",now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString(),box.get("startHour").toString()+":"+box.get("startMinute").toString()+":"+box.get("startSecond").toString(),"21:0:0","http://172.23.21.112:7042/api/mesai");
              naviStartWorkMainScreen(context);
            },
          );
        },
      );
    });
  }


}