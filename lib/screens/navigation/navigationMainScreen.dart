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

class _NavigationMainScreenState extends State<NavigationMainScreen> with TickerProviderStateMixin  {

  TextEditingController shopSearchController = TextEditingController();
  List<String> shopListOnSearch = [];
  List<String> shopList = [
    '5000 Pendik',
    '5001 Kartal',
    '5002 Maltepe',
    '5003 Sancaktepe',
    '5004 Umraniye',
    '5005 Uskudar',
    '5006 Sultanbeyli',
    '5007 Tuzla',
    '5008 Bostanci',
    '5009 Goztepe',
    '5010 Atasehir',
  ];

  late Future<List<Shop>> futureShopList;

  int _selectedIndex = 1;

  List<BottomNavigationBarItem> naviBarList = [];
  List<Widget> pageList = [];

  late double deviceHeight;
  late double deviceWidth;

  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    futureShopList = fetchShop();
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
              SizedBox(height: deviceHeight*0.04,),
              searchBar(),
              SizedBox(height: deviceHeight*0.04,),
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
              if(shopSearchController.text.isEmpty){
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
                          ShopCard(icon: Icons.store,sizedBoxConst1: 0.00,sizedBoxConst2: 0.01,sizedBoxConst3: 0.01,heightConst: 0.17, widthConst: 0.80, shopName: snapshot.data![index].shopName, shopCode: snapshot.data![index].shopCode.toString(), lat: snapshot.data![index].Lat, long: snapshot.data![index].Long)
                        ]
                    );
                  },
                );
              }
              else if(shopSearchController.text.isNotEmpty){
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index){
                    if(shopListOnSearch.contains(snapshot.data![index].shopCode.toString()+" "+snapshot.data![index].shopName)){
                      return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children:<Widget>[
                            ShopCard(icon: Icons.store,sizedBoxConst1: 0.00,sizedBoxConst2: 0.01,sizedBoxConst3: 0.01,heightConst: 0.17, widthConst: 0.80, shopName: snapshot.data![index].shopName, shopCode: snapshot.data![index].shopCode.toString(), lat: snapshot.data![index].Lat, long: snapshot.data![index].Long)
                          ]
                      );
                    }
                    else{
                      return Container();
                    }
                  },
                );
              }
              else{
                return Container();
              }
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

  Widget searchBar(){
    return TextField(
      controller: shopSearchController,
        onChanged: (value){
      setState ((){
        shopListOnSearch = shopList
            .where((element) => element.toLowerCase().contains(value.toLowerCase()))
            .toList();
        print(shopListOnSearch);
      });},
      decoration: InputDecoration(
        labelText: "Mağaza Ara",
        hintText: "Mağaza Ara",
        prefixIcon: Icon(Icons.search),
        suffixIcon: shopSearchController.text.isEmpty ? null
            : InkWell(
                onTap: () {
                  shopListOnSearch.clear();
                  shopSearchController.clear();
                  setState (() {
                    shopSearchController.text = '';
                  });},
                child: Icon(Icons.clear),
              ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
      ),
    );
  }

}


