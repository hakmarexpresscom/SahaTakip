import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../constants/constants.dart';
import '../../../../constants/manavFormLists.dart';
import '../../../../main.dart';
import '../../../../models/manavDepoForm.dart';
import '../../../../routing/landing.dart';
import '../../../../services/manavDepoFormServices.dart';
import '../../../../styles/styleConst.dart';
import '../../../../utils/generalFunctions.dart';
import '../../../../utils/sendShopVsitingReportMailFunctions.dart';
import '../../../../widgets/button_widget.dart';
import '../../../../widgets/cards/checkingCard.dart';

class ManavDepoFormScreen extends StatefulWidget {

  int region_code = 0;
  ManavDepoFormScreen({super.key, required this.region_code});

  @override
  State<ManavDepoFormScreen> createState() => _ManavDepoFormScreenState();
}

class _ManavDepoFormScreenState extends State<ManavDepoFormScreen> {

  late Future<List<ManavDepoForm>> futureManavDepoForm;

  late double deviceHeight;
  late double deviceWidth;

  DateTime now = DateTime.now();

  @override
  void initState() {
    super.initState();
    futureManavDepoForm = fetchManavDepoForm('${constUrl}api/ManavDepoForm/filterManavDepoForm?magaza_kodu=${widget.region_code}&kayit_tarihi=${DateTime.now().toIso8601String()}');
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
        title: const Text('Manav Depo Formu'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            naviRegionCenterVisitingProcessesScreen(context, box.get('currentCenterID'), box.get('currentCenterName'), box.get("groupNo"));
          },
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: FutureBuilder<List<ManavDepoForm>>(
            future: futureManavDepoForm,
            builder: (context, snapshot){
              if(snapshot.hasData){
                box.put("manavDepoForm",1);
                return Text("Manav depo formunu bu ziyaret için doldurdunuz.");
              }
              else{
                box.put("manavDepoForm",0);
                return manavDepoFormScreenUI(context);
              }
            }
        ),
      )
    );
  }

  Widget manavDepoFormScreenUI(BuildContext context){
    return Column(
        children: [
          Expanded(
            child:ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: depoFormList.length,
              itemBuilder: (BuildContext context, int index){
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: deviceHeight*0.01,),
                    CheckingCard(heightConst: 0.13, widthConst: 0.95, taskName: depoFormList.keys.toList()[index],value: depoFormList.values.toList()[index], checkMap: depoFormList,checkKey: depoFormList.keys.toList()[index]),
                  ],
                );
              },
            ),
          ),
          SizedBox(height: deviceHeight*0.02,),
          saveButtonManavDepoForm(context),
          SizedBox(height: deviceHeight*0.02,),
        ]
    );
  }

  Widget saveButtonManavDepoForm(BuildContext context){
    return ButtonWidget(
      text: "Kaydet",
      heightConst: 0.06,
      widthConst: 0.8,
      size: 18,
      radius: 20,
      fontWeight: FontWeight.w600,
      onTaps: (){
        createManavDepoForm(
            widget.region_code,
            (isBS)?userID:null,
            (isBS)?null:userID,
            now.toIso8601String(),
            depoFormList.values.toList()[0],
            depoFormList.values.toList()[1],
            depoFormList.values.toList()[2],
            depoFormList.values.toList()[3],
            depoFormList.values.toList()[4],
            depoFormList.values.toList()[5],
            depoFormList.values.toList()[6],
            depoFormList.values.toList()[7],
            depoFormList.values.toList()[8],
            depoFormList.values.toList()[9],
            "${constUrl}api/ManavDepoForm"
        );
        boxShopVisitingForms.put("manavDepoFormList", formatFormToHTML(depoFormList));
        box.put("manavDepoForm",1);
        showAlertDialogWidget(
          context,
          'Kontroller Yapıldı', 'Depo formunu başarıyla doldurdunuz!',
          (){
            depoFormList.forEach((key, value) {depoFormList[key] = 0;});
            naviManavDepoFormScreen(context, widget.region_code);
          }
        );
      },
      borderWidht: 1,
      backgroundColor: secondaryColor,
      borderColor: secondaryColor,
      textColor: textColor);
  }

}
