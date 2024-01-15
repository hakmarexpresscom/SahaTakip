import 'package:deneme/constants/constants.dart';
import 'package:deneme/routing/bottomNavigationBar.dart';
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

  double textSizeName3 = 0;

  int _selectedIndex = 1;

  List<BottomNavigationBarItem> naviBarList = [];
  List<Widget> pageList = [];

  late double deviceHeight;
  late double deviceWidth;

  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    createShopList("${constUrl}api/magaza");
    controller = AnimationController(
      /// [AnimationController]s can be created with `vsync: this` because of
      /// [TickerProviderStateMixin].
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
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
        if(isStartShopVisitWorkObs.value==false&&isStartExternalTaskWorkObs.value==false){
          pageList = pagesBS;
        }
        else if(isStartShopVisitWorkObs.value){
          pageList = pagesBS2;
        }
        else if(isStartExternalTaskWorkObs.value){
          pageList = pagesBS3;
        }
        _selectedIndex = 1;
      }
      if(user=="PM"){
        naviBarList = itemListPM;
        if(isStartShopVisitWorkObs.value==false&&isStartExternalTaskWorkObs.value==false){
          pageList = pagesPM;
        }
        else if(isStartShopVisitWorkObs.value){
          pageList = pagesPM2;
        }
        else if(isStartExternalTaskWorkObs.value){
          pageList = pagesPM3;
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
          foregroundColor: Colors.white,
          backgroundColor: Colors.indigo,
          title: const Text('Navigasyon'),
        ),
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints){
            if(350<constraints.maxWidth && constraints.maxWidth<420 && deviceHeight<800){
              return Column(
                  children: [
                    SizedBox(height: deviceHeight*0.03,),
                    TextWidget(text: "Tüm mağazalarımızın kodlarını ve\nisimlerini inceleyebilir, haritada görüntüleyebilirsiniz.", size: 16, fontWeight: FontWeight.w400, color: Colors.black),
                    SizedBox(height: deviceHeight*0.03,),
                    searchBar(),
                    SizedBox(height: deviceHeight*0.03,),
                    navigationMainScreenUI(0.00, 0.015, 0.02, 0.22, 0.80, 20, 18, 15)
                  ]
              );
            }
            else if(651<constraints.maxWidth && constraints.maxWidth<1000){
              return Column(
                  children: [
                    SizedBox(height: deviceHeight*0.03,),
                    TextWidget(text: "Tüm mağazalarımızın kodlarını ve\nisimlerini inceleyebilir, haritada görüntüleyebilirsiniz.", size: 16, fontWeight: FontWeight.w400, color: Colors.black),
                    SizedBox(height: deviceHeight*0.03,),
                    searchBar(),
                    SizedBox(height: deviceHeight*0.03,),
                    ((deviceHeight-deviceWidth)<150) ? navigationMainScreenUI(0.00, 0.02, 0.02, 0.22, 0.60, 20, 18, 15) : navigationMainScreenUI(0.00, 0.02, 0.015, 0.19, 0.70, 30, 25, 20),
                  ]
              );
            }
            else if(deviceHeight>800 || (421<constraints.maxWidth && constraints.maxWidth<650)){
              return Column(
                  children: [
                    SizedBox(height: deviceHeight*0.03,),
                    TextWidget(text: "Tüm mağazalarımızın kodlarını ve\nisimlerini inceleyebilir, haritada görüntüleyebilirsiniz.", size: 16, fontWeight: FontWeight.w400, color: Colors.black),
                    SizedBox(height: deviceHeight*0.03,),
                    searchBar(),
                    SizedBox(height: deviceHeight*0.03,),
                    navigationMainScreenUI(0.00, 0.01, 0.015, 0.19, 0.80, 20, 18, 15),
                  ]
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
  
  Widget navigationMainScreenUI(double sizedBoxConst1, double sizedBoxConst2, double sizedBoxConst3, double heightConst, double widthConst, double textSizeCode, double textSizeName, double textSizeButton){
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
                            ShopCard(icon: Icons.store,sizedBoxConst1: sizedBoxConst1,sizedBoxConst2: sizedBoxConst2,sizedBoxConst3: sizedBoxConst3,heightConst: heightConst, widthConst: widthConst, textSizeCode: textSizeCode, textSizeName: textSizeName, textSizeButton: textSizeButton, shopName: snapshot.data![index].shopName, shopCode: snapshot.data![index].shopCode.toString(), lat: snapshot.data![index].Lat, long: snapshot.data![index].Long)
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
                            ShopCard(icon: Icons.store,sizedBoxConst1: sizedBoxConst1,sizedBoxConst2: sizedBoxConst2,sizedBoxConst3: sizedBoxConst3,heightConst: heightConst, widthConst: widthConst, textSizeCode: textSizeCode, textSizeName: textSizeName, textSizeButton: textSizeButton, shopName: snapshot.data![index].shopName, shopCode: snapshot.data![index].shopCode.toString(), lat: snapshot.data![index].Lat, long: snapshot.data![index].Long)
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


