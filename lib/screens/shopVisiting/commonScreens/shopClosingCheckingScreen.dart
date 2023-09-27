import 'package:deneme/constants/constants.dart';
import 'package:deneme/routing/bottomNavigationBar.dart';
import 'package:deneme/widgets/button_widget.dart';
import 'package:deneme/widgets/cards/checkingCard.dart';
import 'package:flutter/material.dart';

class ShopClosingCheckingScreen extends StatefulWidget {
  const ShopClosingCheckingScreen({super.key});

  @override
  State<ShopClosingCheckingScreen> createState() =>
      _ShopClosingCheckingScreenState();
}

class _ShopClosingCheckingScreenState extends State<ShopClosingCheckingScreen> {

  int _selectedIndex = 0;

  late double deviceHeight;
  late double deviceWidth;

  @override
  Widget build(BuildContext context) {

    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    return DefaultTabController(
        initialIndex: 0,
        length: 2,
        child:Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: Colors.indigo,
              title: const Text('Mağaza Kapanış Kontrolü'),
              bottom: TabBar(
                tabs: [
                  Tab(text: "Mağaza İçi"),
                  Tab(text: "Mağaza Dışı")
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                SingleChildScrollView(padding: EdgeInsets.fromLTRB(0, deviceWidth*0.04, 0, 0),child:inShopClosingCheckingUI()),
                SingleChildScrollView(padding: EdgeInsets.fromLTRB(0, deviceWidth*0.04, 0, 0),child:outShopClosingCheckingUI())
              ],
            ),
            bottomNavigationBar: BottomNaviBar(selectedIndex: _selectedIndex,itemList: itemListBS,pageList: pages,)
        ));
  }

  Widget inShopClosingCheckingUI(){
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
                CheckingCard(heightConst: 0.13, widthConst: 0.95, taskName: "Temizlik görevi"),
                SizedBox(height: deviceHeight*0.005,),
                CheckingCard(heightConst: 0.13, widthConst: 0.95, taskName: "Temizlik görevi"),
                SizedBox(height: deviceHeight*0.005,),
                CheckingCard(heightConst: 0.13, widthConst: 0.95, taskName: "Temizlik görevi"),
                SizedBox(height: deviceHeight*0.005,),
                CheckingCard(heightConst: 0.13, widthConst: 0.95, taskName: "Temizlik görevi"),
                SizedBox(height: deviceHeight*0.005,),
                CheckingCard(heightConst: 0.13, widthConst: 0.95, taskName: "Temizlik görevi"),
                SizedBox(height: deviceHeight*0.005,),
                CheckingCard(heightConst: 0.13, widthConst: 0.95, taskName: "Temizlik görevi"),
                SizedBox(height: deviceHeight*0.005,),
                SizedBox(height: deviceHeight*0.03,),
                saveButton(),
                SizedBox(height: deviceHeight*0.03,),
              ],
            )
          ],
        ),
      );
    });
  }

  Widget outShopClosingCheckingUI(){
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
                CheckingCard(heightConst: 0.13, widthConst: 0.95, taskName: "Temizlik görevi"),
                SizedBox(height: deviceHeight*0.005,),
                CheckingCard(heightConst: 0.13, widthConst: 0.95, taskName: "Temizlik görevi"),
                SizedBox(height: deviceHeight*0.005,),
                CheckingCard(heightConst: 0.13, widthConst: 0.95, taskName: "Temizlik görevi"),
                SizedBox(height: deviceHeight*0.005,),
                CheckingCard(heightConst: 0.13, widthConst: 0.95, taskName: "Temizlik görevi"),
                SizedBox(height: deviceHeight*0.005,),
                CheckingCard(heightConst: 0.13, widthConst: 0.95, taskName: "Temizlik görevi"),
                SizedBox(height: deviceHeight*0.005,),
                CheckingCard(heightConst: 0.13, widthConst: 0.95, taskName: "Temizlik görevi"),
                SizedBox(height: deviceHeight*0.005,),
                SizedBox(height: deviceHeight*0.03,),
                saveButton(),
                SizedBox(height: deviceHeight*0.03,),
              ],
            )
          ],
        ),
      );
    });
  }

  Widget saveButton(){
    return ButtonWidget(text: "Kaydet", heightConst: 0.06, widthConst: 0.8, size: 18, radius: 20, fontWeight: FontWeight.w600, onTaps: (){}, borderWidht: 1, backgroundColor: Colors.lightGreen.withOpacity(0.6), borderColor: Colors.lightGreen.withOpacity(0.6), textColor: Colors.black);
  }
}


