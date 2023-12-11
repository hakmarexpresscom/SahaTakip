import 'package:deneme/styles/context_extension.dart';
import 'package:deneme/widgets/button_widget.dart';
import 'package:deneme/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class ShopVisitingProcessCard extends StatefulWidget {

  late double heightConst;
  late double widthConst;
  late String processName;
  late IconData processIcon;
  final VoidCallback onTaps;

  ShopVisitingProcessCard({Key? key, required this.heightConst,required this.widthConst, required this.processName, required this.processIcon, required this.onTaps}): super(key: key);

  @override
  State<ShopVisitingProcessCard> createState() => _ShopVisitingProcessCardState();
}

class _ShopVisitingProcessCardState extends State<ShopVisitingProcessCard> {

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
        width: context.dynamicWidth(widget.widthConst),
        child: InkWell(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: context.dynamicHeight(0.03),),
              Icon(widget.processIcon,size: 50,),
              SizedBox(height: context.dynamicHeight(0.04),),
              TextWidget(text: widget.processName, heightConst: 0, widhtConst: 0, size: 20, fontWeight: FontWeight.w600, color: Colors.black),
            ],
          ),
        onTap: ()=>{widget.onTaps()})
      ),
    );
  }
}
