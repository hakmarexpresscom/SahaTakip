import 'package:deneme/constants/constants.dart';
import 'package:deneme/routing/bottomNavigationBar.dart';
import 'package:deneme/services/shopClosingControlServices.dart';
import 'package:deneme/widgets/button_widget.dart';
import 'package:deneme/widgets/cards/checkingCard.dart';
import 'package:flutter/material.dart';
import '../../../constants/bottomNaviBarLists.dart';
import '../../../constants/pagesLists.dart';
import '../../../constants/shopOpenCloseChekingLists.dart';

class ShopClosingCheckingScreen extends StatefulWidget {
  int shop_code = 0;
  ShopClosingCheckingScreen({super.key, required this.shop_code});

  @override
  State<ShopClosingCheckingScreen> createState() =>
      _ShopClosingCheckingScreenState();
}

class _ShopClosingCheckingScreenState extends State<ShopClosingCheckingScreen> {

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
        pageList = pagesBS;
      }
      if(user=="PM"){
        naviBarList = itemListPM;
        pageList = pagesPM;
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
              title: const Text('Mağaza Kapanış Kontrolü'),
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
                inShopClosingCheckingUI(),
                outShopClosingCheckingUI()
              ],
            ),
            bottomNavigationBar: BottomNaviBar(selectedIndex: _selectedIndex,itemList: naviBarList,pageList: pageList,)
        ));
  }

  Widget inShopClosingCheckingUI(){
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
          saveButtonInshop(),
        ]
    );
  }

  Widget outShopClosingCheckingUI(){
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
          createInShopCloseControl(
              widget.shop_code,
              (isBS)?userID:null,
              (isBS)?null:userID,
              now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString(),
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
              "http://172.23.21.112:7042/api/KapanisKontroluMagazaIci"
          );
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
          createOutShopCloseControl(
              widget.shop_code,
              (isBS)?userID:null,
              (isBS)?null:userID,
              now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString(),
              outShopClosingCheckingList.values.toList()[0],
              outShopClosingCheckingList.values.toList()[1],
              outShopClosingCheckingList.values.toList()[2],
              outShopClosingCheckingList.values.toList()[3],
              outShopClosingCheckingList.values.toList()[4],
              outShopClosingCheckingList.values.toList()[5],
              outShopClosingCheckingList.values.toList()[6],
              outShopClosingCheckingList.values.toList()[7],
              "http://172.23.21.112:7042/api/KapanisKontroluMagazaDisi"
          );
        },
        borderWidht: 1,
        backgroundColor: Colors.lightGreen.withOpacity(0.6),
        borderColor: Colors.lightGreen.withOpacity(0.6),
        textColor: Colors.black);
  }
}


