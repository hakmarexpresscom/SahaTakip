import 'dart:async';
import 'package:deneme/constants/constants.dart';
import 'package:deneme/routing/bottomNavigationBar.dart';
import 'package:deneme/widgets/cards/visitingShopCard.dart';
import 'package:flutter/material.dart';
import '../../../constants/bottomNaviBarLists.dart';
import '../../../constants/pagesLists.dart';
import '../../../models/shop.dart';
import '../../../routing/landing.dart';
import '../../../services/shopServices.dart';

class ShopVisitingShopsScreenPM extends StatefulWidget {
  const ShopVisitingShopsScreenPM({super.key});

  @override
  State<ShopVisitingShopsScreenPM> createState() =>
      _ShopVisitingShopsScreenPMState();
}

class _ShopVisitingShopsScreenPMState extends State<ShopVisitingShopsScreenPM> with TickerProviderStateMixin{

  late Future<List<Shop>> futureOwnShopListPM;

  int _selectedIndex = 0;

  List<BottomNavigationBarItem> naviBarList = [];
  List<Widget> pageList = [];

  late double deviceHeight;
  late double deviceWidth;

  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    futureOwnShopListPM = fetchShop('http://172.23.21.112:7042/api/magaza/byPmId?pm_id=${userID}');
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

    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: const Text('Kendi Mağazalarım'),
        ),
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints){
            if(350<constraints.maxWidth && constraints.maxWidth<420 && deviceHeight<800){
              return Column(
                children: <Widget>[
                  ownShopsScreenUI(0.00, 0.015, 0.02, 0.20, 0.80, 20, 18, 15),
                ],
              );
            }
            else if(651<constraints.maxWidth && constraints.maxWidth<1000){
              return Column(
                children: <Widget>[
                  ((deviceHeight-deviceWidth)<150) ? ownShopsScreenUI(0.00, 0.02, 0.02, 0.20, 0.60, 20, 18, 15) : ownShopsScreenUI(0.00, 0.02, 0.015, 0.17, 0.70, 30, 25, 20),
                ],
              );
            }
            else if(deviceHeight>800 || (421<constraints.maxWidth && constraints.maxWidth<650)){
              return Column(
                children: <Widget>[
                  ownShopsScreenUI(0.00, 0.01, 0.015, 0.17, 0.80, 20, 18, 15),
                ],
              );
            }
            else{
              return Container();
            }
          },
        ),
        bottomNavigationBar: BottomNaviBar(selectedIndex: _selectedIndex,itemList: naviBarList,pageList: pageList,)
    );
  }

  Widget ownShopsScreenUI(double sizedBoxConst1, double sizedBoxConst2, double sizedBoxConst3, double heightConst, double widthConst, double textSizeCode, double textSizeName, double textSizeButton){
    return Expanded(
        child: FutureBuilder<List<Shop>>(
            future: futureOwnShopListPM,
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
                          VisitingShopCard(icon: Icons.store, sizedBoxConst1: sizedBoxConst1,sizedBoxConst2: sizedBoxConst2,sizedBoxConst3: sizedBoxConst3,heightConst: heightConst, widthConst: widthConst, textSizeCode: textSizeCode, textSizeName: textSizeName, textSizeButton: textSizeButton, shopName: snapshot.data![index].shopName, shopCode: snapshot.data![index].shopCode.toString(), lat: snapshot.data![index].Lat, long: snapshot.data![index].Long,onTaps: (){naviShopVisitingProcessesScreen(context,snapshot.data![index].shopCode);})
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
          );
  }

}

