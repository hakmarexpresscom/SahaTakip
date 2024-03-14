import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../constants/constants.dart';
import '../../constants/manavFormLists.dart';
import '../../models/manavDepoForm.dart';
import '../../routing/landing.dart';
import '../../services/manavDepoFormServices.dart';
import '../../styles/styleConst.dart';
import '../../widgets/alert_dialog.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/cards/checkingCard.dart';

class ManavDepoFormScreen extends StatefulWidget {

  int shop_code = 0;
  ManavDepoFormScreen({super.key, required this.shop_code});

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
    futureManavDepoForm = fetchManavDepoForm('${constUrl}api/ManavDepoForm/filterManavDepoForm?magaza_kodu=${widget.shop_code}&kayit_tarihi=${DateTime.now().toIso8601String()}');
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
          onPressed: () {},
        ),
      ),
      body: SingleChildScrollView(
          child:Container(
            alignment: Alignment.center,
            child: FutureBuilder<List<ManavDepoForm>>(
                future: futureManavDepoForm,
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    return Text("Manav depo formunu bu ziyaret için doldurdunuz.");
                  }
                  else{
                    return manavDepoFormScreenUI();
                  }
                }
            ),
          )
      ),
    );
  }

  Widget manavDepoFormScreenUI(){
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
          saveButtonManavDepoForm(),
          SizedBox(height: deviceHeight*0.02,),
        ]
    );
  }

  Widget saveButtonManavDepoForm(){
    return ButtonWidget(
        text: "Kaydet",
        heightConst: 0.06,
        widthConst: 0.8,
        size: 18,
        radius: 20,
        fontWeight: FontWeight.w600,
        onTaps: (){
          createManavDepoForm(
              widget.shop_code,
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
              "${constUrl}api/ManavDepoFormu"
          );
          showFormFilledDialog(context,depoFormList);
        },
        borderWidht: 1,
        backgroundColor: secondaryColor,
        borderColor: secondaryColor,
        textColor: textColor);
  }

  showFormFilledDialog(BuildContext context, Map<String, int>list) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialogWidget(
            title: 'Kontroller Yapıldı',
            content: 'Depo formunu başarıyla doldurdunuz!',
            onTaps: (){
              list.forEach((key, value) {list[key] = 0;});
              naviManavDepoFormScreen(context, widget.shop_code);
            },
          );
        }
    );
  }
}
