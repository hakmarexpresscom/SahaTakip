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

class TatbakGroupFormScreen extends StatefulWidget {

  int shop_code = 0;
  TatbakGroupFormScreen({super.key, required this.shop_code});

  @override
  State<TatbakGroupFormScreen> createState() => _TatbakGroupFormScreenState();
}

class _TatbakGroupFormScreenState extends State<TatbakGroupFormScreen> {

  late Future<List<TatbakGroupForm>> futureTatbakGroupForm;

  late double deviceHeight;
  late double deviceWidth;

  DateTime now = DateTime.now();

  @override
  void initState() {
    super.initState();
    futureTatbakGroupForm = fetchTatbakGroupForm('${constUrl}api/TatbakGrubu/filterTatbakGrubuForm?magaza_kodu=${widget.shop_code}&kayit_tarihi=${DateTime.now().toIso8601String()}');
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
          title: const Text('Tatbak Grubu Formu'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              naviShopVisitingProcessesScreen(context, box.get('currentShopID'), box.get('currentShopName'), box.get("groupNo"));
            },
          ),
        ),
        body: Container(
          alignment: Alignment.center,
          child: FutureBuilder<List<TatbakGroupForm>>(
              future: futureTatbakGroupForm,
              builder: (context, snapshot){
                if(snapshot.hasData){
                  box.put("tatbakGroupForm",1);
                  return Text("Tatbak Grubu formunu bu ziyaret için doldurdunuz.");
                }
                else{
                  box.put("tatbakGroupForm",1);
                  return tatbakGroupFormScreenUI(context);
                }
              }
          ),
        )
    );
  }

  Widget tatbakGroupFormScreenUI(BuildContext context){
    return Column(
        children: [
          Expanded(
            child:ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: tatbakGroupList.length,
              itemBuilder: (BuildContext context, int index){
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: deviceHeight*0.01,),
                    CheckingCard(heightConst: 0.13, widthConst: 0.95, taskName: tatbakGroupList.keys.toList()[index],value: tatbakGroupList.values.toList()[index], checkMap: tatbakGroupList,checkKey: tatbakGroupList.keys.toList()[index]),
                  ],
                );
              },
            ),
          ),
          SizedBox(height: deviceHeight*0.02,),
          saveButtonTatbakGroupForm(context),
          SizedBox(height: deviceHeight*0.02,),
        ]
    );
  }

  Widget saveButtonTatbakGroupForm(BuildContext context){
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
              tatbakGroupList.values.toList()[0],
              tatbakGroupList.values.toList()[1],
              tatbakGroupList.values.toList()[2],
              tatbakGroupList.values.toList()[3],
              tatbakGroupList.values.toList()[4],
              tatbakGroupList.values.toList()[5],
              tatbakGroupList.values.toList()[6],
              tatbakGroupList.values.toList()[7],
              tatbakGroupList.values.toList()[8],
              tatbakGroupList.values.toList()[9],
              "${constUrl}api/TatbakGrubu"
          );
          boxShopVisitingForms.put("tatbakGroupFormList", formatFormToHTML(tatbakGroupList));
          box.put("tatbakGroupForm",1);
          showAlertDialogWidget(
              context,
              'Kontroller Yapıldı', 'Mağaza formunu başarıyla doldurdunuz!',
                  (){
                tatbakGroupList.forEach((key, value) {tatbakGroupList[key] = 0;});
                naviTatbakGroupFormScreen(context, widget.shop_code);
              }
          );
        },
        borderWidht: 1,
        backgroundColor: secondaryColor,
        borderColor: secondaryColor,
        textColor: textColor);
  }

}
