import 'package:deneme/screens/shopVisiting/commonScreens/processesScreen.dart';
import 'package:deneme/styles/context_extension.dart';
import 'package:deneme/widgets/button_widget.dart';
import 'package:deneme/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class VisitingShopCard extends StatefulWidget {

  late double heightConst;
  late double widthConst;
  late String shopName;
  late String shopCode;
  late String location;

  VisitingShopCard({Key? key, required this.heightConst,required this.widthConst, required this.shopName, required this.shopCode, required this.location}): super(key: key);

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
              children: [Icon(Icons.store,size: 45,),],
            ),
            SizedBox(height: context.dynamicHeight(0.02),),
            TextWidget(text: widget.shopCode, heightConst: 0, widhtConst: 0, size: 20, fontWeight: FontWeight.w600, color: Colors.black),
            SizedBox(height: context.dynamicHeight(0.02),),
            TextWidget(text: widget.shopName, heightConst: 0, widhtConst: 0, size: 18, fontWeight: FontWeight.w400, color: Colors.black),
            SizedBox(height: context.dynamicHeight(0.04),),
            ButtonWidget(text: "Ziyarete Başla", heightConst: 0.04, widthConst: 0.35, size: 15, radius: 20, fontWeight: FontWeight.w500, onTaps: (){Navigator.push(context, MaterialPageRoute(builder: (context) => ShopVisitingProcessesScreen()));}, borderWidht: 1, backgroundColor: Colors.lightGreen.withOpacity(0.6), borderColor: Colors.transparent, textColor: Colors.black),
          ],
        ),
      ),
    );
  }
}
