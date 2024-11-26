import 'package:deneme/styles/context_extension.dart';
import 'package:deneme/styles/styleConst.dart';
import 'package:deneme/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class ShopVisitingFormItemCard extends StatefulWidget {

  late String formItemText;
  final VoidCallback onTaps;
  final IconData icon;

  ShopVisitingFormItemCard({Key? key, required this.formItemText, required this.onTaps, required this.icon}): super(key: key);

  @override
  State<ShopVisitingFormItemCard> createState() => _ShopVisitingFormItemCardState();
}

class _ShopVisitingFormItemCardState extends State<ShopVisitingFormItemCard> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: (){widget.onTaps();},
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                  color: primaryColor,
                  width: 3
              )
          ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: context.dynamicHeight(0.02),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                      child: TextWidget(
                        text: widget.formItemText,
                        size: 17,
                        fontWeight: FontWeight.w400,
                        color: textColor,
                        overflow: TextOverflow.visible, // Yazının devam etmesini sağlar
                      ),
                    ),
                    Icon(
                      widget.icon,
                      size: 25,
                    ),
                  ],
                ),
                SizedBox(height: context.dynamicHeight(0.02),),
              ],
          )
        ),
        )
    );
  }
}