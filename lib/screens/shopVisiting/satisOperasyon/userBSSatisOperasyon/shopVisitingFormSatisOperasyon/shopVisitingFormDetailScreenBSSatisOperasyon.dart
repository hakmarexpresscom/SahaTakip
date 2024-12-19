import 'package:deneme/constants/constants.dart';
import 'package:flutter/material.dart';
import '../../../../../main.dart';
import '../../../../../models/shopVisitingFormBS.dart';
import '../../../../../routing/landing.dart';
import '../../../../../services/shopVisitingFormBSServices.dart';
import '../../../../../styles/styleConst.dart';
import '../../../../../utils/generalFunctions.dart';
import '../../../../../widgets/button_widget.dart';
import '../../../../../widgets/text_form_field.dart';
import '../../../../../widgets/text_widget.dart';

class ShopVisitingFormDetailScreenBSSatisOperasyon extends StatefulWidget {

  static var explanation = "";

  int item_id = 0;
  String item_name = "test";
  ShopVisitingFormDetailScreenBSSatisOperasyon({super.key, required this.item_id, required this.item_name});

  @override
  State<ShopVisitingFormDetailScreenBSSatisOperasyon> createState() =>
      _ShopVisitingFormDetailScreenBSSatisOperasyonState();
}

class _ShopVisitingFormDetailScreenBSSatisOperasyonState extends State<ShopVisitingFormDetailScreenBSSatisOperasyon> with TickerProviderStateMixin {

  late Future<List<ShopVisitingFormBS>> futureShopVisitingFormBS;

  late double deviceHeight;
  late double deviceWidth;

  late AnimationController controller;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String point = pointList[0];

  final explanationController = TextEditingController();

  bool isSaved = false;

  @override
  void initState() {
    super.initState();
    futureShopVisitingFormBS = fetchShopVisitingFormBS('${constUrl}api/MagazaZiyaretFormuBS');
    explanationController.text = ((boxBSSatisOperasyonShopVisitingFormShops.get(box.get("currentShopID")))[widget.item_id.toString()][0]=="test") ? "" : (boxBSSatisOperasyonShopVisitingFormShops.get(box.get("currentShopID")))[widget.item_id.toString()][0];
    point = ((boxBSSatisOperasyonShopVisitingFormShops.get(box.get("currentShopID")))[widget.item_id.toString()][1]=="0") ? pointList[0] : (boxBSSatisOperasyonShopVisitingFormShops.get(box.get("currentShopID")))[widget.item_id.toString()][1];
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {});
    controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        foregroundColor: appbarForeground,
        backgroundColor: appbarBackground,
        title: const Text('Cevap Sayfası'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            if (!isSaved) {
              showAlertDialogDoubleButtonWidget(
                context,
                "Uyarı",
                "Cevabı Kaydet butonuna basmayı unuttunuz!",
                (){
                  naviShopVisitingFormMainScreenBSSatisOperasyon(context, box.get("currentShopID"),);
                },
                (){
                  var formAnswers = boxBSSatisOperasyonShopVisitingFormShops.get(box.get("currentShopID"));
                  formAnswers[widget.item_id.toString()] = [explanationController.text, point];
                  boxBSSatisOperasyonShopVisitingFormShops.put(box.get("currentShopID"), formAnswers);
                  setState(() {
                    isSaved = true;
                  });
                  naviShopVisitingFormMainScreenBSSatisOperasyon(context, box.get("currentShopID"),);
                }
              );
            } else {
              naviShopVisitingFormMainScreenBSSatisOperasyon(context, box.get("currentShopID"),);
            }
          },
        ),
      ),
      body: PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) {},
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(0),
          child: Container(
            alignment: Alignment.center,
            child: shopVisitingFormDetailScreenBSSatisOperasyonUI(),
          ),
        ),
      ),
    );
  }

  Widget shopVisitingFormDetailScreenBSSatisOperasyonUI() {
    return Builder(builder: (BuildContext context) {
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: deviceHeight * 0.02),
            TextWidget(text: widget.item_name, size: 17, fontWeight: FontWeight.w400, color: textColor),
            SizedBox(height: deviceHeight * 0.02),
            TextWidget(text: "Puan:", size: 17, fontWeight: FontWeight.w400, color: textColor),
            SizedBox(height: deviceHeight * 0.02),
            pointDropDown(),
            SizedBox(height: deviceHeight * 0.03),
            inputForm(),
            SizedBox(height: deviceHeight * 0.03),
            saveButtonFormAnswers(context),
          ],
        ),
      );
    });
  }

  Widget inputForm() {
    return Container(
      width: deviceWidth * 0.8,
      child: Form(
        key: _formKey,
        onChanged: () {
          _formKey.currentState!.save();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextFormFieldWidget(
              text: "Açıklama",
              borderWidht: 2,
              titleColor: textColor,
              borderColor: textColor,
              controller: explanationController,
              value: ShopVisitingFormDetailScreenBSSatisOperasyon.explanation,
              paddingValue: 5,
              maxLines: 15,
              maxLength: 1500,
              controllerString: explanationController.text,
              enabled: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget pointDropDown() {
    return DropdownMenu<String>(
      initialSelection: point,
      onSelected: (String? value) {
        setState(() {
          point = value!;
        });
      },
      dropdownMenuEntries: pointList.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
  }

  Widget saveButtonFormAnswers(BuildContext context) {
    return ButtonWidget(
      text: "Cevabı Kaydet",
      heightConst: 0.06,
      widthConst: 0.8,
      size: 18,
      radius: 20,
      fontWeight: FontWeight.w600,
      onTaps: () {
        var formAnswers = boxBSSatisOperasyonShopVisitingFormShops.get(box.get("currentShopID"));
        formAnswers[widget.item_id.toString()] = [explanationController.text, point];
        boxBSSatisOperasyonShopVisitingFormShops.put(box.get("currentShopID"), formAnswers);
        setState(() {
          isSaved = true;
        });
        naviShopVisitingFormMainScreenBSSatisOperasyon(context, box.get("currentShopID"),);
      },
      borderWidht: 1,
      backgroundColor: secondaryColor,
      borderColor: secondaryColor,
      textColor: textColor,
    );
  }
}
