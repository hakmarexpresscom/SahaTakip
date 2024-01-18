import 'package:deneme/screens/googleMap/googleMap.dart';
import 'package:deneme/styles/context_extension.dart';
import 'package:deneme/styles/styleConst.dart';
import 'package:deneme/widgets/button_widget.dart';
import 'package:deneme/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class ShopCard extends StatefulWidget {

  late double heightConst;
  late double widthConst;
  late double sizedBoxConst1;
  late double sizedBoxConst2;
  late double sizedBoxConst3;
  late String shopName;
  late String shopCode;
  late String lat;
  late String long;
  final IconData icon;
  late double textSizeCode;
  late double textSizeName;
  late double textSizeButton;

  ShopCard({Key? key, required this.heightConst,required this.widthConst, required this.sizedBoxConst1, required this.sizedBoxConst2, required this.sizedBoxConst3,required this.shopName, required this.shopCode, required this.lat, required this.long, required this.icon, required this.textSizeCode, required this.textSizeButton, required this.textSizeName}): super(key: key);

  @override
  State<ShopCard> createState() => _ShopCardState();
}

class _ShopCardState extends State<ShopCard> {

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
      child: Container(
        height: context.dynamicHeight(widget.heightConst),
        width: context.dynamicWidth(widget.widthConst),
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
            ButtonWidget(text: "Haritada Gör", heightConst: 0.04, widthConst: 0.35, size: widget.textSizeButton, radius: 20, fontWeight: FontWeight.w500, onTaps: (){Navigator.push(context, MaterialPageRoute(builder: (context) => MapScreen(targetLat: widget.lat, targetLong: widget.long)));}, borderWidht: 1, backgroundColor: secondaryColor, borderColor: Colors.transparent, textColor: textColor),
        ],
        ),
      ),
    );
  }
}
