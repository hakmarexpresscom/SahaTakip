import 'package:deneme/constants/unkarFormLists.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../constants/constants.dart';
import '../../../../main.dart';
import '../../../../models/unkarShopForm.dart';
import '../../../../routing/landing.dart';
import '../../../../services/unkarShopFormServices.dart';
import '../../../../styles/styleConst.dart';
import '../../../../utils/generalFunctions.dart';
import '../../../../utils/sendShopVsitingReportFuncstions.dart';
import '../../../../widgets/button_widget.dart';
import '../../../../widgets/cards/checkingCard.dart';

class BreadGroupFormScreen extends StatefulWidget {

  int shop_code = 0;
  BreadGroupFormScreen({super.key, required this.shop_code});

  @override
  State<BreadGroupFormScreen> createState() => _BreadGroupFormScreenState();
}

class _BreadGroupFormScreenState extends State<BreadGroupFormScreen> {

  late Future<List<BreadGroupForm>> futureBreadGroupForm;

  late double deviceHeight;
  late double deviceWidth;

  DateTime now = DateTime.now();

  @override
  void initState() {
    super.initState();
    futureBreadGroupForm = fetchBreadGroupForm('${constUrl}api/EkmekGrubu/filterEkmekGrubuForm?magaza_kodu=${widget.shop_code}&kayit_tarihi=${DateTime.now().toIso8601String()}');
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
          title: const Text('Ekmek Grubu Formu'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              naviShopVisitingProcessesScreen(context, box.get('currentShopID'), box.get('currentShopName'), box.get("groupNo"));
            },
          ),
        ),
        body: Container(
          alignment: Alignment.center,
          child: FutureBuilder<List<BreadGroupForm>>(
              future: futureBreadGroupForm,
              builder: (context, snapshot){
                if(snapshot.hasData){
                  box.put("breadGroupForm",1);
                  return Text("Ekmek Grubu formunu bu ziyaret için doldurdunuz.");
                }
                else{
                  box.put("breadGroupForm",1);
                  return breadGroupFormScreenUI(context);
                }
              }
          ),
        )
    );
  }

  Widget breadGroupFormScreenUI(BuildContext context){
    return Column(
        children: [
          Expanded(
            child:ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: breadGroupList.length,
              itemBuilder: (BuildContext context, int index){
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: deviceHeight*0.01,),
                    CheckingCard(heightConst: 0.13, widthConst: 0.95, taskName: breadGroupList.keys.toList()[index],value: breadGroupList.values.toList()[index], checkMap: breadGroupList,checkKey: breadGroupList.keys.toList()[index]),
                  ],
                );
              },
            ),
          ),
          SizedBox(height: deviceHeight*0.02,),
          saveButtonBreadGroupForm(context),
          SizedBox(height: deviceHeight*0.02,),
        ]
    );
  }

  Widget saveButtonBreadGroupForm(BuildContext context){
    return ButtonWidget(
        text: "Kaydet",
        heightConst: 0.06,
        widthConst: 0.8,
        size: 18,
        radius: 20,
        fontWeight: FontWeight.w600,
        onTaps: (){
          createBreadGroupForm(
              widget.shop_code,
              box.get('currentShopName'),
              (isBS)?userID:null,
              (isBS)?null:userID,
              now.toIso8601String(),
              breadGroupList.values.toList()[0],
              breadGroupList.values.toList()[1],
              breadGroupList.values.toList()[2],
              breadGroupList.values.toList()[3],
              breadGroupList.values.toList()[4],
              breadGroupList.values.toList()[5],
              breadGroupList.values.toList()[6],
              breadGroupList.values.toList()[7],
              breadGroupList.values.toList()[8],
              breadGroupList.values.toList()[9],
              "${constUrl}api/EkmekGrubu"
          );
          boxShopVisitingForms.put("breadGroupFormList", formatFormToHTML(breadGroupList));
          box.put("breadGroupForm",1);
          showAlertDialogWidget(
              context,
              'Kontroller Yapıldı', 'Mağaza formunu başarıyla doldurdunuz!',
                  (){
                breadGroupList.forEach((key, value) {breadGroupList[key] = 0;});
                naviBreadGroupFormScreen(context, widget.shop_code);
              }
          );
        },
        borderWidht: 1,
        backgroundColor: secondaryColor,
        borderColor: secondaryColor,
        textColor: textColor);
  }

}
