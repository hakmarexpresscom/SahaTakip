import 'package:deneme/constants/constants.dart';
import 'package:deneme/services/shopClosingControlServices.dart';
import 'package:deneme/styles/styleConst.dart';
import 'package:deneme/widgets/button_widget.dart';
import 'package:deneme/widgets/cards/checkingCard.dart';
import 'package:flutter/material.dart';
import '../../../../constants/shopOpenCloseChekingLists.dart';
import '../../../../main.dart';
import '../../../../models/shopClosingControl.dart';
import '../../../../routing/landing.dart';
import '../../../../utils/generalFunctions.dart';
import '../../../../utils/sendShopVsitingReportFuncstions.dart';

class ShopClosingCheckingScreen extends StatefulWidget {
  int shop_code = 0;
  ShopClosingCheckingScreen({super.key, required this.shop_code});

  @override
  State<ShopClosingCheckingScreen> createState() =>
      _ShopClosingCheckingScreenState();
}

class _ShopClosingCheckingScreenState extends State<ShopClosingCheckingScreen> {

  late Future<List<InShopCloseControl>> futureInShopCloseControl;
  late Future<List<OutShopCloseControl>> futureOutShopCloseControl;

  late double deviceHeight;
  late double deviceWidth;

  DateTime now = DateTime.now();

  @override
  void initState() {
    super.initState();
    futureInShopCloseControl = fetchInShopCloseControl('${constUrl}api/KapanisKontroluMagazaIci/filterInShopCloseForm?magaza_kodu=${widget.shop_code}&kayit_tarihi=${DateTime.now().toIso8601String()}');
    futureOutShopCloseControl = fetchOutShopCloseControl('${constUrl}api/KapanisKontroluMagazaDisi/filterOutShopCloseForm?magaza_kodu=${widget.shop_code}&kayit_tarihi=${DateTime.now().toIso8601String()}');
  }

  @override
  Widget build(BuildContext context) {

    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    return DefaultTabController(
        initialIndex: 0,
        length: 2,
        child:Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              foregroundColor: appbarForeground,
              backgroundColor: appbarBackground,
              title: const Text('Mağaza Kapanış Kontrolü'),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  naviShopVisitingProcessesScreen(context, box.get('currentShopID'), box.get('currentShopName'), box.get("groupNo"));
                },
              ),
              bottom: TabBar(
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white30,
                tabs: [
                  Tab(text: "Mağaza İçi"),
                  Tab(text: "Mağaza Dışı")
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                FutureBuilder<List<InShopCloseControl>>(
                    future: futureInShopCloseControl,
                    builder: (context, snapshot){
                      if(snapshot.hasData){
                        box.put("inShopCloseForm",1);
                        return Text("Mağaza içi kapanış kontrol formunu bu ziyaret için doldurdunuz.");
                      }
                      else{
                        box.put("inShopCloseForm",0);
                        return inShopClosingCheckingUI(context);
                      }
                    }
                ),
                FutureBuilder<List<OutShopCloseControl>>(
                    future: futureOutShopCloseControl,
                    builder: (context, snapshot){
                      if(snapshot.hasData){
                        setState(() {
                          box.put("outShopCloseForm",1);
                        });
                        return Text("Mağaza dışı kapanış kontrol formunu bu ziyaret için doldurdunuz.");
                      }
                      else{
                        setState(() {
                          box.put("outShopCloseForm",0);
                        });
                        return outShopClosingCheckingUI(context);
                      }
                    }
                ),
              ],
            ),
        ));
  }

  Widget inShopClosingCheckingUI(BuildContext context){
    return Column(
        children: [
          Expanded(
            child:ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: inShopClosingCheckingList.length,
              itemBuilder: (BuildContext context, int index){
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: deviceHeight*0.01,),
                    CheckingCard(heightConst: 0.13, widthConst: 0.95, taskName: inShopClosingCheckingList.keys.toList()[index],value: inShopClosingCheckingList.values.toList()[index],checkMap: inShopClosingCheckingList,checkKey: inShopClosingCheckingList.keys.toList()[index]),
                  ],
                );
              },
            ),
          ),
          SizedBox(height: deviceHeight*0.02,),
          saveButtonInshop(context),
          SizedBox(height: deviceHeight*0.02,),
        ]
    );
  }

  Widget outShopClosingCheckingUI(BuildContext context){
    return Column(
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: outShopClosingCheckingList.length,
              itemBuilder: (BuildContext context, int index){
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: deviceHeight*0.01,),
                    CheckingCard(heightConst: 0.13, widthConst: 0.95, taskName: outShopClosingCheckingList.keys.toList()[index],value: outShopClosingCheckingList.values.toList()[index],checkMap: outShopClosingCheckingList,checkKey: outShopClosingCheckingList.keys.toList()[index]),
                  ],
                );
              },
            ),
          ),
          SizedBox(height: deviceHeight*0.02,),
          saveButtonOutshop(context),
          SizedBox(height: deviceHeight*0.02,),
        ]
    );
  }

  Widget saveButtonInshop(BuildContext context){
    return ButtonWidget(
        text: "Kaydet",
        heightConst: 0.06,
        widthConst: 0.8,
        size: 18,
        radius: 20,
        fontWeight: FontWeight.w600,
        onTaps: (){
          createInShopCloseControl(
              widget.shop_code,
              box.get('currentShopName'),
              (isBS)?userID:null,
              (isBS)?null:userID,
              now.toIso8601String(),
              inShopClosingCheckingList.values.toList()[0],
              inShopClosingCheckingList.values.toList()[1],
              inShopClosingCheckingList.values.toList()[2],
              inShopClosingCheckingList.values.toList()[3],
              inShopClosingCheckingList.values.toList()[4],
              inShopClosingCheckingList.values.toList()[5],
              inShopClosingCheckingList.values.toList()[6],
              inShopClosingCheckingList.values.toList()[7],
              inShopClosingCheckingList.values.toList()[8],
              inShopClosingCheckingList.values.toList()[9],
              inShopClosingCheckingList.values.toList()[10],
              inShopClosingCheckingList.values.toList()[11],
              inShopClosingCheckingList.values.toList()[12],
              inShopClosingCheckingList.values.toList()[13],
              inShopClosingCheckingList.values.toList()[14],
              inShopClosingCheckingList.values.toList()[15],
              inShopClosingCheckingList.values.toList()[16],
              inShopClosingCheckingList.values.toList()[17],
              inShopClosingCheckingList.values.toList()[18],
              inShopClosingCheckingList.values.toList()[19],
              "${constUrl}api/KapanisKontroluMagazaIci"
          );
          boxShopVisitingForms.put("inShopCloseFormList", formatFormToHTML(inShopClosingCheckingList));
          box.put("inShopCloseForm",1);
          showAlertDialogWidget(
              context,
              'Kontroller Yapıldı', 'Kapanış formunu başarıyla doldurdunuz!',
              (){
                inShopClosingCheckingList.forEach((key, value) {inShopClosingCheckingList[key] = 0;});
                naviShopClosingCheckingScreen(context, widget.shop_code);
              }
          );
        },
        borderWidht: 1,
        backgroundColor: secondaryColor,
        borderColor: secondaryColor,
        textColor: textColor);
  }

  Widget saveButtonOutshop(BuildContext context){
    return ButtonWidget(
        text: "Kaydet",
        heightConst: 0.06,
        widthConst: 0.8,
        size: 18,
        radius: 20,
        fontWeight: FontWeight.w600,
        onTaps: (){
          createOutShopCloseControl(
              widget.shop_code,
              box.get('currentShopName'),
              (isBS)?userID:null,
              (isBS)?null:userID,
              now.toIso8601String(),
              outShopClosingCheckingList.values.toList()[0],
              outShopClosingCheckingList.values.toList()[1],
              outShopClosingCheckingList.values.toList()[2],
              outShopClosingCheckingList.values.toList()[3],
              outShopClosingCheckingList.values.toList()[4],
              outShopClosingCheckingList.values.toList()[5],
              outShopClosingCheckingList.values.toList()[6],
              outShopClosingCheckingList.values.toList()[7],
              "${constUrl}api/KapanisKontroluMagazaDisi"
          );
          boxShopVisitingForms.put("outShopCloseFormList", formatFormToHTML(inShopClosingCheckingList));
          box.put("outShopCloseForm",1);
          showAlertDialogWidget(
            context,
            'Kontroller Yapıldı', 'Kapanış formunu başarıyla doldurdunuz!',
            (){
              outShopClosingCheckingList.forEach((key, value) {outShopClosingCheckingList[key] = 0;});
              naviShopClosingCheckingScreen(context, widget.shop_code);
            }
          );
        },
        borderWidht: 1,
        backgroundColor: secondaryColor,
        borderColor: secondaryColor,
        textColor: textColor);
  }

}

