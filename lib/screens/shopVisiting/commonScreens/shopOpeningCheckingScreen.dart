import 'package:deneme/constants/constants.dart';
import 'package:deneme/routing/bottomNavigationBar.dart';
import 'package:deneme/services/shopOpeningControlServices.dart';
import 'package:deneme/widgets/button_widget.dart';
import 'package:deneme/widgets/cards/checkingCard.dart';
import 'package:flutter/material.dart';
import '../../../constants/bottomNaviBarLists.dart';
import '../../../constants/pagesLists.dart';
import '../../../constants/shopOpenCloseChekingLists.dart';

class ShopOpeningCheckingScreen extends StatefulWidget {
  int shop_code = 0;
  ShopOpeningCheckingScreen({super.key, required this.shop_code});

  @override
  State<ShopOpeningCheckingScreen> createState() =>
      _ShopOpeningCheckingScreenState();
}

class _ShopOpeningCheckingScreenState extends State<ShopOpeningCheckingScreen> {

  int _selectedIndex = 0;

  List<BottomNavigationBarItem> naviBarList = [];
  List<Widget> pageList = [];

  late double deviceHeight;
  late double deviceWidth;

  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {

    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    void userCondition(String user){
      if(user=="BS"){
        naviBarList = itemListBS;
        if(isStoreVisitInProgress.value){
          pageList = pagesBS2;
        }
        else if(isStoreVisitInProgress.value==false){
          pageList = pagesBS;
        }
      }
      if(user=="PM"){
        naviBarList = itemListPM;
        if(isStoreVisitInProgress.value){
          pageList = pagesPM2;
        }
        else if(isStoreVisitInProgress.value==false){
          pageList = pagesPM;
        }
      }
      if(user=="BM" || user=="GK"){
        naviBarList = itemListBMandGK;
        pageList = pagesBMGK;
      }
      if(user=="NK"){
        naviBarList = itemListNK;
        pageList = pagesNK;
      }
    }

    userCondition(userType);

    return DefaultTabController(
        initialIndex: 0,
        length: 2,
        child:Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              foregroundColor: Colors.white,
              backgroundColor: Colors.indigo,
              title: const Text('Mağaza Açılış Kontrolü'),
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
                inShopOpeningCheckingUI(),
                outShopOpeningCheckingUI()
              ],
            ),
            bottomNavigationBar: BottomNaviBar(selectedIndex: _selectedIndex,itemList: naviBarList,pageList: pageList,)
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
        saveButtonInshop(),
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
        saveButtonOutshop(),
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
              "http://172.23.21.112:7042/api/AcilisKontroluMagazaIci"
          );
          /*inShopOpeningCheckingList.forEach((key, value) {
            inShopOpeningCheckingList[key] = 0;
          });
          Navigator.pop(context);*/
        },
        borderWidht: 1,
        backgroundColor: Colors.lightGreen.withOpacity(0.6),
        borderColor: Colors.lightGreen.withOpacity(0.6),
        textColor: Colors.black);
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
              "http://172.23.21.112:7042/api/AcilisKontroluMagazaDisi"
          );
          /*outShopOpeningCheckingList.forEach((key, value) {
            outShopOpeningCheckingList[key] = 0;
          });
          Navigator.pop(context);*/
        },
        borderWidht: 1,
        backgroundColor: Colors.lightGreen.withOpacity(0.6),
        borderColor: Colors.lightGreen.withOpacity(0.6),
        textColor: Colors.black);
  }

  showTaskAssignedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Kontroller Yapıldı'),
          content: Text('Açılış formunu başarıyla doldurdunuz!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Tamam'),
            ),
          ],
        );
      },
    );
  }
}


