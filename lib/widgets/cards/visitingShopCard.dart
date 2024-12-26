import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:deneme/styles/context_extension.dart';
import 'package:deneme/styles/styleConst.dart';
import 'package:deneme/widgets/button_widget.dart';
import 'package:deneme/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../constants/constants.dart';
import '../../main.dart';
import '../../routing/landing.dart';
import '../../services/shiftServices.dart';
import '../../services/visitingDurationsServices.dart';
import '../../utils/appStateManager.dart';
import '../../utils/distanceFunctions.dart';
import '../../utils/generalFunctions.dart';

class VisitingShopCard extends StatefulWidget {

  late double sizedBoxConst1;
  late double sizedBoxConst2;
  late double sizedBoxConst3;
  late String shopName;
  late int shopCode;
  late String lat;
  late String long;
  late String currentLat;
  late String currentLong;
  final IconData icon;
  late double textSizeCode;
  late double textSizeName;
  late double textSizeButton;
  final StoreVisitManager storeVisitManager = Get.put(StoreVisitManager());
  final StoreVisitManager2 storeVisitManager2 = Get.put(StoreVisitManager2());
  final ShiftManager shiftManager = Get.put(ShiftManager());

  VisitingShopCard({Key? key,
    required this.sizedBoxConst1,
    required this.sizedBoxConst2,
    required this.sizedBoxConst3,
    required this.shopName,
    required this.shopCode,
    required this.lat,
    required this.long,
    required this.currentLat,
    required this.currentLong,
    required this.icon,
    required this.textSizeCode,
    required this.textSizeButton,
    required this.textSizeName,
  }
  ): super(key: key);

  @override
  State<VisitingShopCard> createState() => _VisitingShopCardState();
}

class _VisitingShopCardState extends State<VisitingShopCard> {

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
              color: primaryColor,
              width: 3
          )
      ),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [Icon(widget.icon,size: 35,),],
            ),
            SizedBox(height: context.dynamicHeight(widget.sizedBoxConst1),),
            TextWidget(text: widget.shopCode.toString(), size: widget.textSizeCode, fontWeight: FontWeight.w600, color: textColor),
            SizedBox(height: context.dynamicHeight(widget.sizedBoxConst2),),
            TextWidget(text: widget.shopName, size: widget.textSizeName, fontWeight: FontWeight.w400, color: textColor),
            SizedBox(height: context.dynamicHeight(widget.sizedBoxConst3),),
            ButtonWidget(
                text: "Ziyarete Başla",
                heightConst: 0.04,
                widthConst: 0.35,
                size: widget.textSizeButton,
                radius: 20,
                fontWeight: FontWeight.w500,
                onTaps: () async{

                  DateTime now = DateTime.now();

                  DateTime startTime = DateTime(now.year, now.month, now.day, 8, 30);
                  DateTime endTime = DateTime(now.year, now.month, now.day, 18, 30);

                  bool isWithinTimeRange = now.isAfter(startTime) && now.isBefore(endTime);

                  var connectivityResult = await (Connectivity().checkConnectivity());

                  if(connectivityResult[0] == ConnectivityResult.none){
                    showAlertDialogWidget(context, 'Internet Bağlantı Hatası', 'Telefonunuzun internet bağlantısı bulunmamaktadır. Lütfen telefonunuzu internete bağlayınız.', (){Navigator.of(context).pop();});
                  }

                  /*else if (getDistance(double.parse(widget.currentLat), double.parse(widget.currentLong), double.parse(widget.lat), double.parse(widget.long)) <= 250.0 && connectivityResult[0] != ConnectivityResult.none) {
                    showAlertDialogWithoutButtonWidget(context,"Ziyaret Başlatılıyor","Ziyaretiniz başlatılıyor, lütfen bekleyiniz.");

                    if((box.get("onDayShift")==0 || boxStateManagement.get('isStartShift')==false)&&isWithinTimeRange){
                      widget.shiftManager.startShift();

                      box.put("onDayShift",1);
                      box.put("startTime",DateTime.now());
                      box.put("shiftDate","");
                      box.put("shiftDate",DateTime.now().toIso8601String());

                      await createShift(
                        (isBS)?userID:null,
                        (isBS)?null:userID,
                        "Mesai",
                        box.get("shiftDate"),
                        box.get("startTime").toIso8601String(),
                        null,
                        null,
                        "${constUrl}api/mesai"
                      );
                    }

                    resetShopVisitingFormInfo(box.get("groupNo"));
                    resetShopVisitingBeforeAfterPhoto();

                    (isWithinTimeRange)?widget.storeVisitManager.startStoreVisit():widget.storeVisitManager2.startStoreVisit2();

                    box.put("currentShopName", widget.shopName);
                    box.put("currentShopID", widget.shopCode);
                    box.put("visitingStartTime", DateTime.now());

                    await createVisitingDurations(
                      box.get('currentShopID'),
                      (isBS == true) ? userID : null,
                      (isBS == true) ? null : userID,
                      (isWithinTimeRange)?box.get("visitingStartTime").toIso8601String():DateTime(now.year, now.month, now.day, 21, 0, 0,).toIso8601String(),
                      null,
                      (isWithinTimeRange)?box.get("shiftDate"):DateTime(now.year, now.month, now.day, 21, 0, 0,).toIso8601String(),
                      null,
                      "${constUrl}api/ZiyaretSureleri"
                    );

                    boxVisitTimer.put('elapsedTime', 0);
                    boxVisitTimer.put('timerStartTime', DateTime.now());

                    Navigator.of(context).pop(); // Close the dialog
                    if(box.get("groupNo")==0||box.get("groupNo")==3){
                      naviShopVisitingProcessesScreen(context, widget.shopCode, widget.shopName, box.get("groupNo"));
                    }
                    else if(box.get("groupNo")==1||box.get("groupNo")==2){
                      naviShopVisitingBeforeAfterPhotoScreen(context, true);
                    }
                  }

                  else if(getDistance(double.parse(widget.currentLat), double.parse(widget.currentLong), double.parse(widget.lat), double.parse(widget.long)) > 250.0 && connectivityResult[0] != ConnectivityResult.none){
                    showAlertDialogWidget(context, 'Mesafe Kontrolü', 'Ziyaret etmek istediğiniz mağazanın en az 250 metre yakınında olmanız gerekmektedir!', (){naviShopVisitingShopsScreenBS(context);});
                  }*/


                  showAlertDialogWithoutButtonWidget(context,"Ziyaret Başlatılıyor","Ziyaretiniz başlatılıyor, lütfen bekleyiniz.");

                  if((box.get("onDayShift")==0 || boxStateManagement.get('isStartShift')==false)&&isWithinTimeRange){
                    widget.shiftManager.startShift();

                    box.put("onDayShift",1);
                    box.put("startTime",DateTime.now());
                    box.put("shiftDate","");
                    box.put("shiftDate",DateTime.now().toIso8601String());

                    await createShift(
                        (isBS)?userID:null,
                        (isBS)?null:userID,
                        "Mesai",
                        box.get("shiftDate"),
                        box.get("startTime").toIso8601String(),
                        null,
                        null,
                        "${constUrl}api/mesai"
                    );
                  }

                  resetShopVisitingFormInfo(box.get("groupNo"));
                  resetShopVisitingBeforeAfterPhoto();

                  (isWithinTimeRange)?widget.storeVisitManager.startStoreVisit():widget.storeVisitManager2.startStoreVisit2();

                  box.put("currentShopName", widget.shopName);
                  box.put("currentShopID", widget.shopCode);
                  box.put("visitingStartTime", DateTime.now());

                  await createVisitingDurations(
                      box.get('currentShopID'),
                      (isBS == true) ? userID : null,
                      (isBS == true) ? null : userID,
                      (isWithinTimeRange)?box.get("visitingStartTime").toIso8601String():DateTime(now.year, now.month, now.day, 21, 0, 0,).toIso8601String(),
                      null,
                      (isWithinTimeRange)?box.get("shiftDate"):DateTime(now.year, now.month, now.day, 21, 0, 0,).toIso8601String(),
                      null,
                      "${constUrl}api/ZiyaretSureleri"
                  );

                  boxVisitTimer.put('elapsedTime', 0);
                  boxVisitTimer.put('timerStartTime', DateTime.now());

                  Navigator.of(context).pop(); // Close the dialog
                  if(box.get("groupNo")==0||box.get("groupNo")==3){
                    naviShopVisitingProcessesScreen(context, widget.shopCode, widget.shopName, box.get("groupNo"));
                  }
                  else if(box.get("groupNo")==1||box.get("groupNo")==2){
                    naviShopVisitingBeforeAfterPhotoScreen(context, true);
                  }
                },
                borderWidht: 1,
                backgroundColor:
                secondaryColor,
                borderColor: Colors.transparent,
                textColor: textColor
            ),
            SizedBox(height: context.dynamicHeight(0.02),),
          ],
      ),
    );
  }
}

