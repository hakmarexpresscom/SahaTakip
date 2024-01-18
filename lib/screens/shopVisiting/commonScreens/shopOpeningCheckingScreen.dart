import 'package:deneme/constants/constants.dart';
import 'package:deneme/routing/landing.dart';
import 'package:deneme/services/shopOpeningControlServices.dart';
import 'package:deneme/widgets/alert_dialog.dart';
import 'package:deneme/widgets/button_widget.dart';
import 'package:deneme/widgets/cards/checkingCard.dart';
import 'package:flutter/material.dart';
import '../../../constants/shopOpenCloseChekingLists.dart';
import '../../../main.dart';
import '../../../models/shopOpeningControl.dart';
import '../../../styles/styleConst.dart';

class ShopOpeningCheckingScreen extends StatefulWidget {
  int shop_code = 0;
  ShopOpeningCheckingScreen({super.key, required this.shop_code});

  @override
  State<ShopOpeningCheckingScreen> createState() =>
      _ShopOpeningCheckingScreenState();
}

class _ShopOpeningCheckingScreenState extends State<ShopOpeningCheckingScreen> {

  late Future<List<InShopOpenControl>> futureInShopOpenControl;
  late Future<List<OutShopOpenControl>> futureOutShopOpenControl;

  late double deviceHeight;
  late double deviceWidth;

  DateTime now = DateTime.now();

  @override
  void initState() {
    super.initState();
    futureInShopOpenControl = fetchInShopOpenControl('${constUrl}api/AcilisKontroluMagazaIci/filterInShopOpenForm?magaza_kodu=${widget.shop_code}&kayit_tarihi=${now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString()}');
    futureOutShopOpenControl = fetchOutShopOpenControl('${constUrl}api/AcilisKontroluMagazaDisi/filterOutShopOpenForm?magaza_kodu=${widget.shop_code}&kayit_tarihi=${now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString()}');
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
              title: const Text('Mağaza Açılış Kontrolü'),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  naviShopVisitingProcessesScreen(context, box.get('currentShopID'), box.get('currentShopName'));
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
                FutureBuilder<List<InShopOpenControl>>(
                    future: futureInShopOpenControl,
                    builder: (context, snapshot){
                      if(snapshot.hasData){
                        return Text("Mağaza içi açılış kontrol formunu bu ziyaret için doldurdunuz.");
                      }
                      else{
                        return inShopOpeningCheckingUI();
                      }
                    }
                ),
                FutureBuilder<List<OutShopOpenControl>>(
                    future: futureOutShopOpenControl,
                    builder: (context, snapshot){
                      if(snapshot.hasData){
                        return Text("Mağaza dışı açılış kontrol formunu bu ziyaret için doldurdunuz.");
                      }
                      else{
                        return outShopOpeningCheckingUI();
                      }
                    }
                ),
              ],
            ),
        ));
  }

  Widget inShopOpeningCheckingUI(){
    return Column(
      children: [
        Expanded(
          child:ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: inShopOpeningCheckingList.length,
            itemBuilder: (BuildContext context, int index){
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: deviceHeight*0.01,),
                  CheckingCard(heightConst: 0.13, widthConst: 0.95, taskName: inShopOpeningCheckingList.keys.toList()[index],value: inShopOpeningCheckingList.values.toList()[index], checkMap: inShopOpeningCheckingList,checkKey: inShopOpeningCheckingList.keys.toList()[index]),
                ],
              );
            },
          ),
        ),
        SizedBox(height: deviceHeight*0.02,),
        saveButtonInshop(),
        SizedBox(height: deviceHeight*0.02,),
      ]
    );
  }

  Widget outShopOpeningCheckingUI(){
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: outShopOpeningCheckingList.length,
            itemBuilder: (BuildContext context, int index){
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: deviceHeight*0.01,),
                  CheckingCard(heightConst: 0.13, widthConst: 0.95, taskName: outShopOpeningCheckingList.keys.toList()[index],value: outShopOpeningCheckingList.values.toList()[index],checkMap: outShopOpeningCheckingList,checkKey: outShopOpeningCheckingList.keys.toList()[index]),
                ],
              );
            },
          ),
        ),
        SizedBox(height: deviceHeight*0.02,),
        saveButtonOutshop(),
        SizedBox(height: deviceHeight*0.02,),
      ]
    );
  }

  Widget saveButtonInshop(){
    return ButtonWidget(
        text: "Kaydet",
        heightConst: 0.06,
        widthConst: 0.8,
        size: 18,
        radius: 20,
        fontWeight: FontWeight.w600,
        onTaps: (){
          print(inShopOpeningCheckingList.values.toList());
          createInShopOpenControl(
              widget.shop_code,
              (isBS)?userID:null,
              (isBS)?null:userID,
              now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString(),
              inShopOpeningCheckingList.values.toList()[0],
              inShopOpeningCheckingList.values.toList()[1],
              inShopOpeningCheckingList.values.toList()[2],
              inShopOpeningCheckingList.values.toList()[3],
              inShopOpeningCheckingList.values.toList()[4],
              inShopOpeningCheckingList.values.toList()[5],
              inShopOpeningCheckingList.values.toList()[6],
              inShopOpeningCheckingList.values.toList()[7],
              inShopOpeningCheckingList.values.toList()[8],
              inShopOpeningCheckingList.values.toList()[9],
              inShopOpeningCheckingList.values.toList()[10],
              inShopOpeningCheckingList.values.toList()[11],
              inShopOpeningCheckingList.values.toList()[12],
              inShopOpeningCheckingList.values.toList()[13],
              inShopOpeningCheckingList.values.toList()[14],
              inShopOpeningCheckingList.values.toList()[15],
              inShopOpeningCheckingList.values.toList()[16],
              inShopOpeningCheckingList.values.toList()[17],
              inShopOpeningCheckingList.values.toList()[18],
              inShopOpeningCheckingList.values.toList()[19],
              inShopOpeningCheckingList.values.toList()[20],
              "${constUrl}api/AcilisKontroluMagazaIci"
          );
          showFormFilledDialog(context,inShopOpeningCheckingList);
        },
        borderWidht: 1,
        backgroundColor: secondaryColor,
        borderColor: secondaryColor,
        textColor: textColor);
  }

  Widget saveButtonOutshop(){
    return ButtonWidget(
        text: "Kaydet",
        heightConst: 0.06,
        widthConst: 0.8,
        size: 18,
        radius: 20,
        fontWeight: FontWeight.w600,
        onTaps: (){
          createOutShopOpenControl(
              widget.shop_code,
              (isBS)?userID:null,
              (isBS)?null:userID,
              now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString(),
              outShopOpeningCheckingList.values.toList()[0],
              outShopOpeningCheckingList.values.toList()[1],
              outShopOpeningCheckingList.values.toList()[2],
              outShopOpeningCheckingList.values.toList()[3],
              outShopOpeningCheckingList.values.toList()[4],
              "${constUrl}api/AcilisKontroluMagazaDisi"
          );
          showFormFilledDialog(context,outShopOpeningCheckingList);
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
            content: 'Açılış formunu başarıyla doldurdunuz!',
            onTaps: (){
              list.forEach((key, value) {list[key] = 0;});
              naviShopOpeningCheckingScreen(context, widget.shop_code);
              },
        );
        }
    );
  }
}