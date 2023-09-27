import 'package:deneme/constants/constants.dart';
import 'package:deneme/routing/bottomNavigationBar.dart';
import 'package:deneme/widgets/cards/shopCard.dart';
import 'package:deneme/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class NearShopsMainScreen extends StatefulWidget {
  const NearShopsMainScreen({super.key});

  @override
  State<NearShopsMainScreen> createState() =>
      _NearShopsMainScreenState();
}

class _NearShopsMainScreenState extends State<NearShopsMainScreen> {

  int _selectedIndex = 2;

  late double deviceHeight;
  late double deviceWidth;

  @override
  Widget build(BuildContext context) {

    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: const Text('Çevre Mağazalar'),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(0, deviceWidth*0.04, 0, 0),
          child:Container(
            alignment: Alignment.center,
            child: nearShopsMainScreenUI(),
          ),
        ),
        bottomNavigationBar: BottomNaviBar(selectedIndex: _selectedIndex,itemList: itemListBS,pageList: pages,)
    );
  }

  Widget nearShopsMainScreenUI(){
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
                TextWidget(text: "Yakınınızda olan mağazaların kodlarını ve\nisimlerini inceleyebilir, haritada görüntüleyebilirsiniz.", heightConst: 0, widhtConst: 0, size: 16, fontWeight: FontWeight.w400, color: Colors.black),
                SizedBox(height: deviceHeight*0.03,),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ShopCard(heightConst: 0.25, widthConst: 0.47, shopName: "Taşlıbayır/Pendik", shopCode: "5168", location: "pendik"),
                      ShopCard(heightConst: 0.25, widthConst: 0.47, shopName: "Taşlıbayır/Pendik", shopCode: "5168", location: "pendik")
                    ]
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ShopCard(heightConst: 0.25, widthConst: 0.47, shopName: "Taşlıbayır/Pendik", shopCode: "5168", location: "pendik"),
                      ShopCard(heightConst: 0.25, widthConst: 0.47, shopName: "Taşlıbayır/Pendik", shopCode: "5168", location: "pendik")
                    ]
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ShopCard(heightConst: 0.25, widthConst: 0.47, shopName: "Taşlıbayır/Pendik", shopCode: "5168", location: "pendik"),
                      ShopCard(heightConst: 0.25, widthConst: 0.47, shopName: "Taşlıbayır/Pendik", shopCode: "5168", location: "pendik")
                    ]
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ShopCard(heightConst: 0.25, widthConst: 0.47, shopName: "Taşlıbayır/Pendik", shopCode: "5168", location: "pendik"),
                      ShopCard(heightConst: 0.25, widthConst: 0.47, shopName: "Taşlıbayır/Pendik", shopCode: "5168", location: "pendik")
                    ]
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ShopCard(heightConst: 0.25, widthConst: 0.47, shopName: "Taşlıbayır/Pendik", shopCode: "5168", location: "pendik"),
                      ShopCard(heightConst: 0.25, widthConst: 0.47, shopName: "Taşlıbayır/Pendik", shopCode: "5168", location: "pendik")
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


