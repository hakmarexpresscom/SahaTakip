import 'package:deneme/styles/context_extension.dart';
import 'package:deneme/styles/styleConst.dart';
import 'package:deneme/widgets/button_widget.dart';
import 'package:deneme/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import '../../utils/generalFunctions.dart';

class NearShopCard extends StatefulWidget {

  late double sizedBoxConst1;
  late double sizedBoxConst2;
  late double sizedBoxConst3;
  late double sizedBoxConst4;
  late String shopName;
  late String shopCode;
  late String lat;
  late String long;
  final IconData icon;
  late double textSizeCode;
  late double textSizeName;
  late double textSizeButton;
  late String distance;

  NearShopCard({Key? key, required this.sizedBoxConst1, required this.sizedBoxConst2, required this.sizedBoxConst3,required this.sizedBoxConst4,required this.shopName, required this.shopCode, required this.lat, required this.long, required this.icon, required this.textSizeCode, required this.textSizeButton, required this.textSizeName, required this.distance}): super(key: key);

  @override
  State<NearShopCard> createState() => _ShopCardState();
}

class _ShopCardState extends State<NearShopCard> {

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
            TextWidget(text: widget.shopCode, size: widget.textSizeCode, fontWeight: FontWeight.w600, color: textColor),
            SizedBox(height: context.dynamicHeight(widget.sizedBoxConst2),),
            TextWidget(text: widget.shopName, size: widget.textSizeName, fontWeight: FontWeight.w400, color: textColor),
            SizedBox(height: context.dynamicHeight(widget.sizedBoxConst3),),
            TextWidget(text: "Mağazaya uzaklığınız: ${widget.distance} km", size: widget.textSizeName, fontWeight: FontWeight.w400, color: textColor),
            SizedBox(height: context.dynamicHeight(widget.sizedBoxConst4),),
            ButtonWidget(
                text: "Haritada Gör",
                heightConst: 0.04,
                widthConst: 0.35,
                size: widget.textSizeButton,
                radius: 20,
                fontWeight: FontWeight.w500,
                onTaps: (){
                  if(Platform.isAndroid){
                    openGoogleMaps(double.parse(widget.lat), double.parse(widget.long));
                  }
                  else if (Platform.isIOS){
                    openAppleMaps(double.parse(widget.lat), double.parse(widget.long));
                  }
                },
                borderWidht: 1,
                backgroundColor: secondaryColor,
                borderColor: Colors.transparent,
                textColor: textColor
            ),
            SizedBox(height: context.dynamicHeight(0.02),),
          ],
        ),
    );
  }
}