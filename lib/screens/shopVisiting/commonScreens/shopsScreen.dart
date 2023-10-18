import 'dart:async';
import 'package:deneme/constants/constants.dart';
import 'package:deneme/routing/bottomNavigationBar.dart';
import 'package:deneme/widgets/cards/visitingShopCard.dart';
import 'package:flutter/material.dart';

import '../../../models/shop.dart';
import '../../../widgets/cards/shopCard.dart';

class ShopVisitingShopsScreen extends StatefulWidget {
  const ShopVisitingShopsScreen({super.key});

  @override
  State<ShopVisitingShopsScreen> createState() =>
      _ShopVisitingShopsScreenState();
}

class _ShopVisitingShopsScreenState extends State<ShopVisitingShopsScreen> with TickerProviderStateMixin{

  int _selectedIndex = 0;

  List<BottomNavigationBarItem> naviBarList = [];
  List<Widget> pageList = [];

  late double deviceHeight;
  late double deviceWidth;

  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      /// [AnimationController]s can be created with `vsync: this` because of
      /// [TickerProviderStateMixin].
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
      setState(() {});
    });
    controller.repeat(reverse: true);
  }

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
             ownShopsScreenUI(),
              partnerShopsScreenUI()
           ],
         ),
          bottomNavigationBar: BottomNaviBar(selectedIndex: _selectedIndex,itemList: naviBarList,pageList: pageList,)
    ));
  }

  Widget ownShopsScreenUI(){
    return Flex(
        direction: Axis.vertical,
        children:[
          Expanded(
            child: FutureBuilder<List<Shop>>(
              future: futureShopList2,
              builder: (context, snapshot){
                if(snapshot.hasData){
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index){
                        return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children:<Widget>[
                              VisitingShopCard(icon: Icons.store, sizedBoxConst1: 0.00,sizedBoxConst2: 0.01,sizedBoxConst3: 0.01,heightConst: 0.17, widthConst: 0.80, shopName: snapshot.data![index].shopName, shopCode: snapshot.data![index].shopCode.toString(), lat: snapshot.data![index].Lat, long: snapshot.data![index].Long)
                            ]
                        );
                      },
                    );
                }
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Column(
                      children:[
                        SizedBox(height: deviceHeight*0.06),
                        CircularProgressIndicator(
                          value: controller.value,
                          semanticsLabel: 'Circular progress indicator',
                        ),
                      ]
                  );
                }
                else{
                  return Text("Veri yok");
                }
              })
          )
        ]
    );
  }

  Widget partnerShopsScreenUI() {
    return Flex(
        direction: Axis.vertical,
        children: [
          Expanded(
              child: FutureBuilder<List<Shop>>(
                  future: futureShopList2,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                VisitingShopCard(icon: Icons.store, sizedBoxConst1: 0.00, sizedBoxConst2: 0.01, sizedBoxConst3: 0.01, heightConst: 0.17, widthConst: 0.80, shopName: snapshot.data![index].shopName, shopCode: snapshot.data![index].shopCode.toString(), lat: snapshot.data![index].Lat, long: snapshot.data![index].Long)
                              ]
                          );
                        },
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Column(
                          children: [
                            SizedBox(height: deviceHeight * 0.06),
                            CircularProgressIndicator(
                              value: controller.value,
                              semanticsLabel: 'Circular progress indicator',
                            ),
                          ]
                      );
                    }
                    else {
                      return Text("Veri yok");
                    }
                  })
          )
        ]
    );
  }

}


