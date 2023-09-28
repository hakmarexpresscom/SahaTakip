import 'dart:async';
import 'package:deneme/constants/constants.dart';
import 'package:deneme/routing/bottomNavigationBar.dart';
import 'package:deneme/widgets/cards/visitingShopCard.dart';
import 'package:flutter/material.dart';

class ShopVisitingShopsScreen extends StatefulWidget {
  const ShopVisitingShopsScreen({super.key});

  @override
  State<ShopVisitingShopsScreen> createState() =>
      _ShopVisitingShopsScreenState();
}

class _ShopVisitingShopsScreenState extends State<ShopVisitingShopsScreen> {

  int _selectedIndex = 0;

  List<BottomNavigationBarItem> naviBarList = [];
  List<Widget> pageList = [];

  late double deviceHeight;
  late double deviceWidth;

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
          backgroundColor: Colors.indigo,
          title: const Text('Mağaza Ziyareti'),
          bottom: TabBar(
            tabs: [
              Tab(text: "Kendi Mağazalarım"),
              Tab(text: "Partner Mağazalar")
            ],
          ),
        ),
         body: TabBarView(
           children: <Widget>[
             SingleChildScrollView(child:ownShopsScreenUI(),),
              SingleChildScrollView(child:partnerShopsScreenUI(),)
           ],
         ),
          bottomNavigationBar: BottomNaviBar(selectedIndex: _selectedIndex,itemList: naviBarList,pageList: pageList,)
    ));
  }

  Widget ownShopsScreenUI(){
    return Builder(builder: (BuildContext context){
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      VisitingShopCard(heightConst: 0.25, widthConst: 0.47, shopName: "Taşlıbayır/Pendik", shopCode: "5168", location: "pendik"),
                      VisitingShopCard(heightConst: 0.25, widthConst: 0.47, shopName: "Taşlıbayır/Pendik", shopCode: "5168", location: "pendik")
                    ]
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      VisitingShopCard(heightConst: 0.25, widthConst: 0.47, shopName: "Taşlıbayır/Pendik", shopCode: "5168", location: "pendik"),
                      VisitingShopCard(heightConst: 0.25, widthConst: 0.47, shopName: "Taşlıbayır/Pendik", shopCode: "5168", location: "pendik")
                    ]
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      VisitingShopCard(heightConst: 0.25, widthConst: 0.47, shopName: "Taşlıbayır/Pendik", shopCode: "5168", location: "pendik"),
                      VisitingShopCard(heightConst: 0.25, widthConst: 0.47, shopName: "Taşlıbayır/Pendik", shopCode: "5168", location: "pendik")
                    ]
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      VisitingShopCard(heightConst: 0.25, widthConst: 0.47, shopName: "Taşlıbayır/Pendik", shopCode: "5168", location: "pendik"),
                      VisitingShopCard(heightConst: 0.25, widthConst: 0.47, shopName: "Taşlıbayır/Pendik", shopCode: "5168", location: "pendik")
                    ]
                ),
              ],
            )
          ],
        ),
      );
    });
  }

  Widget partnerShopsScreenUI(){
    return Builder(builder: (BuildContext context){
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      VisitingShopCard(heightConst: 0.25, widthConst: 0.47, shopName: "Taşlıbayır/Pendik", shopCode: "5168", location: "pendik"),
                      VisitingShopCard(heightConst: 0.25, widthConst: 0.47, shopName: "Taşlıbayır/Pendik", shopCode: "5168", location: "pendik")
                    ]
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      VisitingShopCard(heightConst: 0.25, widthConst: 0.47, shopName: "Taşlıbayır/Pendik", shopCode: "5168", location: "pendik"),
                      VisitingShopCard(heightConst: 0.25, widthConst: 0.47, shopName: "Taşlıbayır/Pendik", shopCode: "5168", location: "pendik")
                    ]
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      VisitingShopCard(heightConst: 0.25, widthConst: 0.47, shopName: "Taşlıbayır/Pendik", shopCode: "5168", location: "pendik"),
                      VisitingShopCard(heightConst: 0.25, widthConst: 0.47, shopName: "Taşlıbayır/Pendik", shopCode: "5168", location: "pendik")
                    ]
                ),
              ],
            )
          ],
        ),
      );
    });
  }

}


