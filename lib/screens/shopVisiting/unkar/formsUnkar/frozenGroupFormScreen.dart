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
import '../../../../utils/sendShopVsitingReportMailFunctions.dart';
import '../../../../widgets/button_widget.dart';
import '../../../../widgets/cards/checkingCard.dart';

class FrozenGroupFormScreen extends StatefulWidget {

  int shop_code = 0;
  FrozenGroupFormScreen({super.key, required this.shop_code});

  @override
  State<FrozenGroupFormScreen> createState() => _FrozenGroupFormScreenState();
}

class _FrozenGroupFormScreenState extends State<FrozenGroupFormScreen> {

  late Future<List<FrozenGroupForm>> futureFrozenGroupForm;

  late double deviceHeight;
  late double deviceWidth;

  DateTime now = DateTime.now();

  @override
  void initState() {
    super.initState();
    futureFrozenGroupForm = fetchFrozenGroupForm('${constUrl}api/DonukUrunGrubu/filterDonukUrunGrubuForm?magaza_kodu=${widget.shop_code}&kayit_tarihi=${DateTime.now().toIso8601String()}');
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
          title: const Text('Donuk Ürün Grubu Formu'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              naviShopVisitingProcessesScreen(context, box.get('currentShopID'), box.get('currentShopName'), box.get("groupNo"));
            },
          ),
        ),
        body: Container(
          alignment: Alignment.center,
          child: FutureBuilder<List<FrozenGroupForm>>(
              future: futureFrozenGroupForm,
              builder: (context, snapshot){
                if(snapshot.hasData){
                  box.put("frozenGroupForm",1);
                  return Text("Donuk Urun Grubu formunu bu ziyaret için doldurdunuz.");
                }
                else{
                  box.put("frozenGroupForm",1);
                  return frozenGroupFormScreenUI(context);
                }
              }
          ),
        )
    );
  }

  Widget frozenGroupFormScreenUI(BuildContext context){
    return Column(
        children: [
          Expanded(
            child:ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: frozenGroupList.length,
              itemBuilder: (BuildContext context, int index){
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: deviceHeight*0.01,),
                    CheckingCard(heightConst: 0.13, widthConst: 0.95, taskName: frozenGroupList.keys.toList()[index],value: frozenGroupList.values.toList()[index], checkMap: frozenGroupList,checkKey: frozenGroupList.keys.toList()[index]),
                  ],
                );
              },
            ),
          ),
          SizedBox(height: deviceHeight*0.02,),
          saveButtonFrozenGroupForm(context),
          SizedBox(height: deviceHeight*0.02,),
        ]
    );
  }

  Widget saveButtonFrozenGroupForm(BuildContext context){
    return ButtonWidget(
        text: "Kaydet",
        heightConst: 0.06,
        widthConst: 0.8,
        size: 18,
        radius: 20,
        fontWeight: FontWeight.w600,
        onTaps: (){
          createFrozenGroupForm(
              widget.shop_code,
              box.get('currentShopName'),
              (isBS)?userID:null,
              (isBS)?null:userID,
              now.toIso8601String(),
              frozenGroupList.values.toList()[0],
              frozenGroupList.values.toList()[1],
              frozenGroupList.values.toList()[2],
              frozenGroupList.values.toList()[3],
              frozenGroupList.values.toList()[4],
              frozenGroupList.values.toList()[5],
              frozenGroupList.values.toList()[6],
              "${constUrl}api/DonukUrunGrubu"
          );
          boxShopVisitingForms.put("frozenGroupFormList", formatFormToHTML(frozenGroupList));
          box.put("frozenGroupForm",1);
          showAlertDialogWidget(
              context,
              'Kontroller Yapıldı', 'Mağaza formunu başarıyla doldurdunuz!',
                  (){
                frozenGroupList.forEach((key, value) {frozenGroupList[key] = 0;});
                naviFrozenGroupFormScreen(context, widget.shop_code);
              }
          );
        },
        borderWidht: 1,
        backgroundColor: secondaryColor,
        borderColor: secondaryColor,
        textColor: textColor);
  }

}
