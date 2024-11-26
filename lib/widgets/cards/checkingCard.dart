import 'package:deneme/styles/context_extension.dart';
import 'package:deneme/styles/styleConst.dart';
import 'package:deneme/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class CheckingCard extends StatefulWidget {

  late double heightConst;
  late double widthConst;
  late String taskName;
  late int value;
  late Map<String, int> checkMap;
  late String checkKey;

  CheckingCard({Key? key, required this.heightConst,required this.widthConst, required this.taskName,required this.value,required this.checkMap, required this.checkKey}): super(key: key);

  @override
  State<CheckingCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<CheckingCard> {

  //bool light = false;

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
                      text: widget.taskName,
                      size: 17,
                      fontWeight: FontWeight.w400,
                      color: textColor,
                      overflow: TextOverflow.visible, // Yazının devam etmesini sağlar
                    ),
                  ),
                  Switch(
                    value: (widget.value)==0?false:true,
                    activeColor: Colors.green,
                    onChanged: (bool newValue) {
                      setState(() {
                        widget.value = newValue?1:0;
                        widget.checkMap[widget.checkKey]=newValue?1:0;
                      }
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: context.dynamicHeight(0.02),),
            ],
        )
      ),
    );
  }
}
