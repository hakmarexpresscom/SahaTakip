import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../constants/constants.dart';
import '../../../../constants/manavFormLists.dart';
import '../../../../main.dart';
import '../../../../models/manavShopForm.dart';
import '../../../../routing/landing.dart';
import '../../../../services/manavShopFormServices.dart';
import '../../../../styles/styleConst.dart';
import '../../../../utils/generalFunctions.dart';
import '../../../../widgets/button_widget.dart';
import '../../../../widgets/cards/checkingCard.dart';

class ManavShopFormScreen extends StatefulWidget {

  int shop_code = 0;
  ManavShopFormScreen({super.key, required this.shop_code});

  @override
  State<ManavShopFormScreen> createState() => _ManavShopFormScreenState();
}

class _ManavShopFormScreenState extends State<ManavShopFormScreen> {

  late Future<List<ManavShopForm>> futureManavShopForm;

  late double deviceHeight;
  late double deviceWidth;

  DateTime now = DateTime.now();

  @override
  void initState() {
    super.initState();
    futureManavShopForm = fetchManavShopForm('${constUrl}api/ManavMagazaForm/filterManavMagazaForm?magaza_kodu=${widget.shop_code}&kayit_tarihi=${DateTime.now().toIso8601String()}');
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
        title: const Text('Manav Mağaza Formu'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            naviShopVisitingProcessesScreen(context, box.get('currentShopID'), box.get('currentShopName'), box.get("groupNo"));
          },
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: FutureBuilder<List<ManavShopForm>>(
            future: futureManavShopForm,
            builder: (context, snapshot){
              if(snapshot.hasData){
                return Text("Manav magaza formunu bu ziyaret için doldurdunuz.");
              }
              else{
                return manavShopFormScreenUI(context);
              }
            }
        ),
      )
    );
  }

  Widget manavShopFormScreenUI(BuildContext context){
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
          saveButtonManavShopForm(context),
          SizedBox(height: deviceHeight*0.02,),
        ]
    );
  }

  Widget saveButtonManavShopForm(BuildContext context){
    return ButtonWidget(
        text: "Kaydet",
        heightConst: 0.06,
        widthConst: 0.8,
        size: 18,
        radius: 20,
        fontWeight: FontWeight.w600,
        onTaps: (){
          createManavShopForm(
              widget.shop_code,
              (isBS)?userID:null,
              (isBS)?null:userID,
              now.toIso8601String(),
              shopFormList.values.toList()[0],
              shopFormList.values.toList()[1],
              shopFormList.values.toList()[2],
              shopFormList.values.toList()[3],
              shopFormList.values.toList()[4],
              shopFormList.values.toList()[5],
              shopFormList.values.toList()[6],
              shopFormList.values.toList()[7],
              shopFormList.values.toList()[8],
              shopFormList.values.toList()[9],
              shopFormList.values.toList()[10],
              shopFormList.values.toList()[11],
              shopFormList.values.toList()[12],
              shopFormList.values.toList()[13],
              shopFormList.values.toList()[14],
              shopFormList.values.toList()[15],
              shopFormList.values.toList()[16],
              shopFormList.values.toList()[17],
              shopFormList.values.toList()[18],
              shopFormList.values.toList()[19],
              shopFormList.values.toList()[20],
              shopFormList.values.toList()[21],
              shopFormList.values.toList()[22],
              "${constUrl}api/ManavMagazaFormu"
          );
          showAlertDialogWidget(
            context,
            'Kontroller Yapıldı', 'Mağaza formunu başarıyla doldurdunuz!',
            (){
              shopFormList.forEach((key, value) {shopFormList[key] = 0;});
              naviManavShopFormScreen(context, widget.shop_code);
            }
          );
        },
        borderWidht: 1,
        backgroundColor: secondaryColor,
        borderColor: secondaryColor,
        textColor: textColor);
  }

}
