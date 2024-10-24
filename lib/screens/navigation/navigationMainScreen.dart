import 'package:customized_search_bar/customized_search_bar.dart';
import 'package:deneme/constants/constants.dart';
import 'package:deneme/routing/bottomNavigationBar.dart';
import 'package:deneme/styles/styleConst.dart';
import 'package:deneme/widgets/cards/shopCard.dart';
import 'package:deneme/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import '../../constants/bottomNaviBarLists.dart';
import '../../constants/pagesLists.dart';
import '../../models/shop.dart';
import '../../utils/generalFunctions.dart';

class NavigationMainScreen extends StatefulWidget {
  const NavigationMainScreen({super.key});

  @override
  State<NavigationMainScreen> createState() =>
      _NavigationMainScreenState();
}

class _NavigationMainScreenState extends State<NavigationMainScreen> with TickerProviderStateMixin  {

  TextEditingController shopSearchController = TextEditingController();
  List<String> shopListOnSearch = [];

  int _selectedIndex = 1;

  List<BottomNavigationBarItem> naviBarList = [];
  List<Widget> pageList = [];

  late double deviceHeight;
  late double deviceWidth;

  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    createShopList("${constUrl}api/MagazaV112");
    controller = AnimationController(
      /// [AnimationController]s can be created with `vsync: this` because of
      /// [TickerProviderStateMixin].
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
    });
    controller.repeat(reverse: true);
    shopListOnSearch = shopList;
  }

  void updateSearchResults(List<String> results) {
    setState(() {
      shopListOnSearch = results;
    });
  }

  @override
  Widget build(BuildContext context) {

    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    void userCondition(String user){
      if(user=="BS"){
        naviBarList = itemListBS;
        if(isStartShiftObs.value==false&&isRegionCenterVisitInProgress.value==false){
          pageList = pagesBS;
        }
        else if(isStartShiftObs.value&&isRegionCenterVisitInProgress.value==false){
          pageList = pagesBS2;
        }
        _selectedIndex = 1;
      }
      if(user=="PM"){
        naviBarList = itemListPM;
        if(isStartShiftObs.value==false&&isRegionCenterVisitInProgress.value==false){
          pageList = pagesPM;
        }
        else if(isStartShiftObs.value&&isRegionCenterVisitInProgress.value==false){
          pageList = pagesPM2;
        }
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
          automaticallyImplyLeading: false,
          foregroundColor: appbarForeground,
          backgroundColor: appbarBackground,
          title: const Text('Navigasyon'),
        ),
        body: PopScope(
          canPop: false,
          onPopInvoked: (bool didPop) {},
          child:LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints){
              if(350<constraints.maxWidth && constraints.maxWidth<420 && deviceHeight<800){
                return Column(
                    children: [
                      SizedBox(height: deviceHeight*0.03,),
                      TextWidget(text: "Tüm mağazalarımızın kodlarını ve\nisimlerini inceleyebilir, haritada görüntüleyebilirsiniz.", size: 16, fontWeight: FontWeight.w400, color: textColor),
                      SizedBox(height: deviceHeight*0.03,),
                      CustomizedSearchBar(hintText: "Mağaza Ara", prefixIcon: Icons.search, suffixIcon: Icons.close, prefixIconColor: Colors.blueAccent, suffixIconColor: Colors.red, focusedBorderColor: secondaryColor, cursorColor: Colors.black, prefixIconSize: 30.0, suffixIconSize: 30.0, borderRadiusValue: 30.0, borderWidth: 3.0, searchList: shopList, onSearchResultChanged: updateSearchResults, searchController: shopSearchController),
                      SizedBox(height: deviceHeight*0.03,),
                      navigationMainScreenUI(0.00, 0.015, 0.02, 20, 18, 15)
                    ]
                );
              }
              else if(651<constraints.maxWidth && constraints.maxWidth<1000){
                return Column(
                    children: [
                      SizedBox(height: deviceHeight*0.03,),
                      TextWidget(text: "Tüm mağazalarımızın kodlarını ve\nisimlerini inceleyebilir, haritada görüntüleyebilirsiniz.", size: 16, fontWeight: FontWeight.w400, color: textColor),
                      SizedBox(height: deviceHeight*0.03,),
                      CustomizedSearchBar(hintText: "Mağaza Ara", prefixIcon: Icons.search, suffixIcon: Icons.close, prefixIconColor: Colors.blueAccent, suffixIconColor: Colors.red, focusedBorderColor: secondaryColor, cursorColor: Colors.black, prefixIconSize: 30.0, suffixIconSize: 30.0, borderRadiusValue: 30.0, borderWidth: 3.0, searchList: shopList, onSearchResultChanged: updateSearchResults, searchController: shopSearchController),
                      SizedBox(height: deviceHeight*0.03,),
                      ((deviceHeight-deviceWidth)<150) ? navigationMainScreenUI(0.00, 0.02, 0.02, 20, 18, 15) : navigationMainScreenUI(0.00, 0.02, 0.015, 30, 25, 20),
                    ]
                );
              }
              else if(deviceHeight>800 || (421<constraints.maxWidth && constraints.maxWidth<650)){
                return Column(
                    children: [
                      SizedBox(height: deviceHeight*0.03,),
                      TextWidget(text: "Tüm mağazalarımızın kodlarını ve\nisimlerini inceleyebilir, haritada görüntüleyebilirsiniz.", size: 16, fontWeight: FontWeight.w400, color: textColor),
                      SizedBox(height: deviceHeight*0.03,),
                      CustomizedSearchBar(hintText: "Mağaza Ara", prefixIcon: Icons.search, suffixIcon: Icons.close, prefixIconColor: Colors.blueAccent, suffixIconColor: Colors.red, focusedBorderColor: secondaryColor, cursorColor: Colors.black, prefixIconSize: 30.0, suffixIconSize: 30.0, borderRadiusValue: 30.0, borderWidth: 3.0, searchList: shopList, onSearchResultChanged: updateSearchResults, searchController: shopSearchController),
                      SizedBox(height: deviceHeight*0.03,),
                      navigationMainScreenUI(0.00, 0.01, 0.015, 20, 18, 15),
                    ]
                );
              }
              else{
                return Container();
              }
            },
          )
        ),
        bottomNavigationBar: BottomNaviBar(selectedIndex: _selectedIndex,itemList: naviBarList,pageList: pageList,)
    );
  }
  
  Widget navigationMainScreenUI(double sizedBoxConst1, double sizedBoxConst2, double sizedBoxConst3, double textSizeCode, double textSizeName, double textSizeButton){
    return Expanded(
        child: FutureBuilder<List<Shop>>(
          future: futureShopList,
          builder: (context, snapshot){
            if(snapshot.hasData){
              if(shopSearchController.text.isEmpty){
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index){
                    if(snapshot.data![index].isActive==1){
                      return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children:<Widget>[
                            ShopCard(icon: Icons.store,sizedBoxConst1: sizedBoxConst1,sizedBoxConst2: sizedBoxConst2,sizedBoxConst3: sizedBoxConst3, textSizeCode: textSizeCode, textSizeName: textSizeName, textSizeButton: textSizeButton, shopName: snapshot.data![index].shopName, shopCode: snapshot.data![index].shopCode.toString(), lat: snapshot.data![index].Lat, long: snapshot.data![index].Long)
                          ]
                      );
                    }
                    else{
                      return Container();
                    }
                  },
                );
              }
              else if(shopSearchController.text.isNotEmpty){
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index){
                    if(shopListOnSearch.contains(snapshot.data![index].shopCode.toString()+" "+snapshot.data![index].shopName)&&snapshot.data![index].isActive==1){
                      return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children:<Widget>[
                            ShopCard(icon: Icons.store,sizedBoxConst1: sizedBoxConst1,sizedBoxConst2: sizedBoxConst2,sizedBoxConst3: sizedBoxConst3, textSizeCode: textSizeCode, textSizeName: textSizeName, textSizeButton: textSizeButton, shopName: snapshot.data![index].shopName, shopCode: snapshot.data![index].shopCode.toString(), lat: snapshot.data![index].Lat, long: snapshot.data![index].Long)
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

}


