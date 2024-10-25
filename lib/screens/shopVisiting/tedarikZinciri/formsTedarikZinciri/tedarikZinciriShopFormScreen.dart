import 'package:deneme/models/tedarikZinciriShopForm.dart';
import 'package:deneme/services/tedarikZinciriShopFormServices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../constants/constants.dart';
import '../../../../constants/manavFormLists.dart';
import '../../../../constants/tedarikZinciriFormLists.dart';
import '../../../../main.dart';
import '../../../../routing/landing.dart';
import '../../../../styles/styleConst.dart';
import '../../../../utils/generalFunctions.dart';
import '../../../../utils/sendShopVsitingReportFuncstions.dart';
import '../../../../widgets/button_widget.dart';
import '../../../../widgets/cards/checkingCard.dart';

class TedarikZinciriShopFormScreen extends StatefulWidget {

  int shop_code = 0;
  TedarikZinciriShopFormScreen({super.key, required this.shop_code});

  @override
  State<TedarikZinciriShopFormScreen> createState() => _TedarikZinciriShopFormScreenState();
}

class _TedarikZinciriShopFormScreenState extends State<TedarikZinciriShopFormScreen> {

  late Future<List<TedarikZinciriForm>> futureTedarikZinciriShopForm;

  late double deviceHeight;
  late double deviceWidth;

  DateTime now = DateTime.now();

  @override
  void initState() {
    super.initState();
    futureTedarikZinciriShopForm = fetchTedarikZinciriForm('${constUrl}api/TedarikZinciriMagazaForm/filterTedarikZinciriMagazaForm?magaza_kodu=${widget.shop_code}&kayit_tarihi=${DateTime.now().toIso8601String()}');
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
          title: const Text('Tedarik Zinciri Mağaza Formu'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              naviShopVisitingProcessesScreen(context, box.get('currentShopID'), box.get('currentShopName'), box.get("groupNo"));
            },
          ),
        ),
        body: Container(
          alignment: Alignment.center,
          child: FutureBuilder<List<TedarikZinciriForm>>(
              future: futureTedarikZinciriShopForm,
              builder: (context, snapshot){
                if(snapshot.hasData){
                  box.put("tedarikZinciriShopForm",1);
                  return Text("Tedarik Zinciri magaza formunu bu ziyaret için doldurdunuz.");
                }
                else{
                  box.put("tedarikZinciriShopForm",0);
                  return tedarikZinciriShopFormScreenUI(context);
                }
              }
          ),
        )
    );
  }

  Widget tedarikZinciriShopFormScreenUI(BuildContext context){
    return Column(
        children: [
          Expanded(
            child:ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: shopFormList.length,
              itemBuilder: (BuildContext context, int index){
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: deviceHeight*0.01,),
                    CheckingCard(heightConst: 0.13, widthConst: 0.95, taskName: shopFormList.keys.toList()[index],value: shopFormList.values.toList()[index], checkMap: shopFormList,checkKey: shopFormList.keys.toList()[index]),
                  ],
                );
              },
            ),
          ),
          SizedBox(height: deviceHeight*0.02,),
          saveButtonTedarikZinciriShopForm(context),
          SizedBox(height: deviceHeight*0.02,),
        ]
    );
  }

  Widget saveButtonTedarikZinciriShopForm(BuildContext context){
    return ButtonWidget(
        text: "Kaydet",
        heightConst: 0.06,
        widthConst: 0.8,
        size: 18,
        radius: 20,
        fontWeight: FontWeight.w600,
        onTaps: (){
          createTedarikZinciriForm(
              widget.shop_code,
              box.get('currentShopName'),
              (isBS)?userID:null,
              (isBS)?null:userID,
              now.toIso8601String(),
              tedarikZinciriList.values.toList()[0],
              tedarikZinciriList.values.toList()[1],
              tedarikZinciriList.values.toList()[2],
              tedarikZinciriList.values.toList()[3],
              tedarikZinciriList.values.toList()[4],
              tedarikZinciriList.values.toList()[5],
              tedarikZinciriList.values.toList()[6],
              tedarikZinciriList.values.toList()[7],
              tedarikZinciriList.values.toList()[8],
              tedarikZinciriList.values.toList()[9],
              tedarikZinciriList.values.toList()[10],
              "${constUrl}api/TedarikZinciriMagazaForm"
          );
          boxShopVisitingForms.put("tedarikZinciriShopFormList", formatFormToHTML(tedarikZinciriList));
          box.put("tedarikZinciriShopForm",1);
          showAlertDialogWidget(
              context,
              'Kontroller Yapıldı', 'Mağaza formunu başarıyla doldurdunuz!',
              (){
                tedarikZinciriList.forEach((key, value) {tedarikZinciriList[key] = 0;});
                naviTedarikZinciriFormScreen(context, widget.shop_code);
              }
          );
        },
        borderWidht: 1,
        backgroundColor: secondaryColor,
        borderColor: secondaryColor,
        textColor: textColor);
  }

}
