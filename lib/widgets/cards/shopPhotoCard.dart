import 'package:deneme/styles/context_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../button_widget.dart';
import '../text_widget.dart';

class ShopPhotoCard extends StatefulWidget {
  late double heightConst;
  late double widthConst;
  late double sizedBoxConst1;
  late double sizedBoxConst2;
  late double sizedBoxConst3;
  late double sizedBoxConst4;
  late String shopName;
  late int shopCode;
  final IconData icon;
  late double textSizeCode;
  late double textSizeName;
  late double textSizeButton;
  final VoidCallback onTaps;
  late bool value;

  ShopPhotoCard({Key? key, required this.heightConst,required this.widthConst, required this.sizedBoxConst1, required this.sizedBoxConst2, required this.sizedBoxConst3, required this.sizedBoxConst4,required this.shopName, required this.shopCode, required this.icon, required this.textSizeCode, required this.textSizeButton, required this.textSizeName,required this.onTaps, required this.value}): super(key: key);

  @override
  State<ShopPhotoCard> createState() => _ShopPhotoCardState();
}

class _ShopPhotoCardState extends State<ShopPhotoCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
              color: Colors.orangeAccent,
              width: 3
          )
      ),
      child: Container(
        height: context.dynamicHeight(widget.heightConst),
        width: context.dynamicWidht(widget.widthConst),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Checkbox(value: widget.value, onChanged: (newvalue){setState(() {widget.value=newvalue!;});}),
                TextWidget(text: "${widget.shopCode}", heightConst: 0, widhtConst: 0, size: widget.textSizeCode, fontWeight: FontWeight.w600, color: Colors.black),
              ],
            ),
            SizedBox(height: context.dynamicHeight(widget.sizedBoxConst2),),
            TextWidget(text: widget.shopName, heightConst: 0, widhtConst: 0, size: widget.textSizeName, fontWeight: FontWeight.w400, color: Colors.black),
            SizedBox(height: context.dynamicHeight(widget.sizedBoxConst3),),
            ButtonWidget(text: "Fotoğraf Ekle", heightConst: 0.04, widthConst: 0.35, size: widget.textSizeButton, radius: 20, fontWeight: FontWeight.w500, onTaps: (){widget.onTaps;}, borderWidht: 1, backgroundColor: Colors.lightGreen.withOpacity(0.6), borderColor: Colors.transparent, textColor: Colors.black),
            SizedBox(height: context.dynamicHeight(widget.sizedBoxConst4),),
            ButtonWidget(text: "Fotoğrafı Gör", heightConst: 0.04, widthConst: 0.35, size: widget.textSizeButton, radius: 20, fontWeight: FontWeight.w500, onTaps: (){widget.onTaps;}, borderWidht: 1, backgroundColor: Colors.lightGreen.withOpacity(0.6), borderColor: Colors.transparent, textColor: Colors.black),
          ],
        ),
      ),
    );
  }
}