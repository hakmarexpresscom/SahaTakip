import 'package:deneme/constants/constants.dart';
import 'package:deneme/routing/bottomNavigationBar.dart';
import 'package:deneme/widgets/cards/shopCard.dart';
import 'package:deneme/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import '../../models/shop.dart';
import '../../services/shopServices.dart';

class NavigationMainScreen extends StatefulWidget {
  const NavigationMainScreen({super.key});

  @override
  State<NavigationMainScreen> createState() =>
      _NavigationMainScreenState();
}

class _NavigationMainScreenState extends State<NavigationMainScreen> {

  late Future<List<Shop>> futureShopList;

  int _selectedIndex = 1;

  List<BottomNavigationBarItem> naviBarList = [];
  List<Widget> pageList = [];

  late double deviceHeight;
  late double deviceWidth;

  @override
  void initState() {
    super.initState();
    futureShopList = fetchShop();
  }

  @override
  Widget build(BuildContext context) {

    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    void userCondition(String user){
      if(user=="BS"){
        naviBarList = itemListBS;
        pageList = pagesBS;
        _selectedIndex = 1;
      }
      if(user=="PM"){
        naviBarList = itemListPM;
        pageList = pagesPM;
        _selectedIndex = 1;
      }
      if(user=="BM" || user=="GK"){
        naviBarList = itemListBMandGK;
        pageList = pagesBMGK;
        _selectedIndex = 0;
      }
      if(user=="NK"){
        naviBarList = itemListNK;
        pageList = pagesNK;
        _selectedIndex = 0;
      }
    }

    userCondition(userType);

    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: const Text('Navigasyon'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: deviceHeight*0.03,),
              TextWidget(text: "Tüm mağazalarımızın kodlarını ve\nisimlerini inceleyebilir, haritada görüntüleyebilirsiniz.", heightConst: 0, widhtConst: 0, size: 16, fontWeight: FontWeight.w400, color: Colors.black),
              SizedBox(height: deviceHeight*0.03,),
              navigationMainScreenUI(),
            ],
          ),

        bottomNavigationBar: BottomNaviBar(selectedIndex: _selectedIndex,itemList: naviBarList,pageList: pageList,)
    );
  }
  
  Widget navigationMainScreenUI(){
    return Expanded(child: FutureBuilder<List<Shop>>(
          future: futureShopList,
          builder: (context, snapshot){
            if(snapshot.hasData){
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index){
                  return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:<Widget>[
                        ShopCard(heightConst: 0.25, widthConst: 0.47, shopName: snapshot.data![index].shopName, shopCode: snapshot.data![index].shopCode.toString(), lat: snapshot.data![index].Lat, long: snapshot.data![index].Long)
                      ]
                  );
                },
              );
            }
            else{
              return TextWidget(text: "No data", heightConst: 0, widhtConst: 0, size: 20, fontWeight: FontWeight.w600, color: Colors.black);
            }
        }));
  }

}


