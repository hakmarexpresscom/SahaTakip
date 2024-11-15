import 'dart:async';
import 'dart:io' show Platform;
import 'package:deneme/constants/constants.dart';
import 'package:deneme/routing/bottomNavigationBar.dart';
import 'package:deneme/screens/googleMap/googleMapNearShops.dart';
import 'package:deneme/styles/styleConst.dart';
import 'package:deneme/utils/distanceFunctions.dart';
import 'package:deneme/widgets/button_widget.dart';
import 'package:deneme/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../../constants/bottomNaviBarLists.dart';
import '../../constants/pagesLists.dart';
import '../../main.dart';
import '../../models/shop.dart';
import '../../services/shopServices.dart';
import '../../widgets/cards/nearShopCard.dart';

class NearShopsMainScreen extends StatefulWidget {
  const NearShopsMainScreen({super.key});

  @override
  State<NearShopsMainScreen> createState() =>
      _NearShopsMainScreenState();
}

class _NearShopsMainScreenState extends State<NearShopsMainScreen> with TickerProviderStateMixin {

  late Future<List<Shop>> futureShopList;

  int _selectedIndex = 2;

  List<BottomNavigationBarItem> naviBarList = [];
  List<Widget> pageList = [];

  late double deviceHeight;
  late double deviceWidth;

  late AnimationController controller;

  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;
  String long = "1", lat = "1";
  late StreamSubscription<Position> positionStream;

  @override
  void initState() {
    futureShopList = fetchShop('${constUrl}api/MagazaV113');
    checkGps();
    controller = AnimationController(
      /// [AnimationController]s can be created with `vsync: this` because of
      /// [TickerProviderStateMixin].
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
    });
    controller.repeat(reverse: true);
    super.initState();
  }

  checkGps() async {
    servicestatus = await Geolocator.isLocationServiceEnabled();
    if(servicestatus){
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Location permissions are denied');
        }else if(permission == LocationPermission.deniedForever){
          print("'Location permissions are permanently denied");
        }else{
          haspermission = true;
        }
      }else{
        haspermission = true;
      }

      if(haspermission){
        setState(() {
          //refresh the UI
        });

        getLocation();
      }
    }else{
      print("GPS Service is not enabled, turn on GPS location");
    }

    setState(() {
      //refresh the UI
    });
  }

  getLocation() async {
    position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position.longitude);
    print(position.latitude);

    long = position.longitude.toString();
    lat = position.latitude.toString();

    setState(() {
      //refresh UI
    });

    LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );

    StreamSubscription<Position> positionStream = Geolocator.getPositionStream(
        locationSettings: locationSettings).listen((Position position) {
      print(position.longitude);
      print(position.latitude);

      long = position.longitude.toString();
      lat = position.latitude.toString();

      setState(() {
        //refresh UI on update
      });
    });
  }


  @override
  Widget build(BuildContext context) {

    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    void userCondition(String user){
      if(user=="BS" && box.get("groupNo") == 2 && box.get("groupNo") == 3){
        naviBarList = itemListTZ;
        if(isStartShiftObs.value==false&&isRegionCenterVisitInProgress.value==false){
          pageList = pagesUnkarTZ;
        }
        else if(isStartShiftObs.value&&isRegionCenterVisitInProgress.value==false){
          pageList = pagesUnkarTZ2;
        }
        _selectedIndex = 2;
      }
      else if(user=="BS"){
        naviBarList = itemListBS;
        if(isStartShiftObs.value==false&&isRegionCenterVisitInProgress.value==false){
          pageList = pagesBS;
        }
        else if(isStartShiftObs.value&&isRegionCenterVisitInProgress.value==false){
          pageList = pagesBS2;
        }
        _selectedIndex = 2;
      }
      else if(user=="PM"){
        naviBarList = itemListPM;
        if(isStartShiftObs.value==false&&isRegionCenterVisitInProgress.value==false){
          pageList = pagesPM;
        }
        else if(isStartShiftObs.value&&isRegionCenterVisitInProgress.value==false){
          pageList = pagesPM2;
        }
        _selectedIndex = 2;
      }
      else if(user=="BM" || user=="GK"){
        naviBarList = itemListBMandGK;
        pageList = pagesBMGK;
        _selectedIndex = 1;
      }
      else if(user=="NK"){
        naviBarList = itemListNK;
        pageList = pagesNK;
        _selectedIndex = 1;
      }
    }

    userCondition(userType);


    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          foregroundColor: appbarForeground,
          backgroundColor: appbarBackground,
          title: const Text('Çevre Mağazalar'),
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
                      TextWidget(text: "Yakınınızda olan mağazaların kodlarını ve\nisimlerini inceleyebilir, haritada görüntüleyebilirsiniz.", size: 16, fontWeight: FontWeight.w400, color: textColor),
                      SizedBox(height: deviceHeight*0.03,),
                      nearShopsMainScreenUI(0.00, 0.015, 0.015, 0.02, 20, 18, 15),
                      (Platform.isAndroid)?SizedBox(height: deviceHeight*0.02,):SizedBox(height: deviceHeight*0.00,),
                      (Platform.isAndroid)?seeAllShops():SizedBox(height: deviceHeight*0.00,),
                      (Platform.isAndroid)?SizedBox(height: deviceHeight*0.02,):SizedBox(height: deviceHeight*0.00,),
                    ]
                );
              }
              else if(651<constraints.maxWidth && constraints.maxWidth<1000){
                return Column(
                    children: [
                      SizedBox(height: deviceHeight*0.03,),
                      TextWidget(text: "Yakınınızda olan mağazaların kodlarını ve\nisimlerini inceleyebilir, haritada görüntüleyebilirsiniz.", size: 16, fontWeight: FontWeight.w400, color: textColor),
                      SizedBox(height: deviceHeight*0.03,),
                      ((deviceHeight-deviceWidth)<150) ? nearShopsMainScreenUI(0.00, 0.02, 0.02, 0.02, 20, 18, 15) : nearShopsMainScreenUI(0.00, 0.02, 0.02, 0.015, 30, 25, 20),
                      SizedBox(height: deviceHeight*0.02,),
                      (Platform.isAndroid)?SizedBox(height: deviceHeight*0.02,):SizedBox(height: deviceHeight*0.00,),
                      (Platform.isAndroid)?seeAllShops():SizedBox(height: deviceHeight*0.00,),
                      (Platform.isAndroid)?SizedBox(height: deviceHeight*0.02,):SizedBox(height: deviceHeight*0.00,),
                    ]
                );
              }
              else if(deviceHeight>800 || (421<constraints.maxWidth && constraints.maxWidth<650)){
                return Column(
                    children: [
                      SizedBox(height: deviceHeight*0.03,),
                      TextWidget(text: "Yakınınızda olan mağazaların kodlarını ve\nisimlerini inceleyebilir, haritada görüntüleyebilirsiniz.", size: 16, fontWeight: FontWeight.w400, color: textColor),
                      SizedBox(height: deviceHeight*0.03,),
                      nearShopsMainScreenUI(0.00, 0.01, 0.01, 0.015, 20, 18, 15),
                      (Platform.isAndroid)?SizedBox(height: deviceHeight*0.02,):SizedBox(height: deviceHeight*0.00,),
                      (Platform.isAndroid)?seeAllShops():SizedBox(height: deviceHeight*0.00,),
                      (Platform.isAndroid)?SizedBox(height: deviceHeight*0.02,):SizedBox(height: deviceHeight*0.00,),
                    ]
                );
              }
              else{
                return Container();
              }
            },
          )
        ),
        bottomNavigationBar: BottomNaviBar(selectedIndex: _selectedIndex,itemList: naviBarList,pageList: pageList,),
    );
  }


  Widget nearShopsMainScreenUI(double sizedBoxConst1, double sizedBoxConst2, double sizedBoxConst3, double sizedBoxConst4, double textSizeCode, double textSizeName, double textSizeButton){
    return Expanded(child: FutureBuilder<List<Shop>>(
        future: futureShopList,
        builder: (context, snapshot){
          if(snapshot.hasData){
            List<Map<String, dynamic>> shopsWithDistance = [];
            for (var shop in snapshot.data!) {
              double distance = getDistance(double.parse(lat), double.parse(long), double.parse(shop.Lat), double.parse(shop.Long));
              if (distance <= 5000.0 && shop.isActive == 1) {
                shopsWithDistance.add({
                  "shop": shop,
                  "distance": distance,
                });
                GoogleMapMarkerList.list.add({"id": shop.shopCode.toString(),"lat": shop.Lat, "long": shop.Long });
              }
            }
            shopsWithDistance.sort((a, b) => a["distance"].compareTo(b["distance"]));

            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: shopsWithDistance.length,
              itemBuilder: (BuildContext context, int index){

                var shopData = shopsWithDistance[index];
                Shop shop = shopData["shop"];
                double distance = shopData["distance"];

                return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      NearShopCard(
                          icon: Icons.near_me,
                          sizedBoxConst1: sizedBoxConst1,
                          sizedBoxConst2: sizedBoxConst2,
                          sizedBoxConst3: sizedBoxConst3,
                          sizedBoxConst4: sizedBoxConst4,
                          textSizeCode: textSizeCode,
                          textSizeName: textSizeName,
                          textSizeButton: textSizeButton,
                          shopName: shop.shopName,
                          shopCode: shop.shopCode.toString(),
                          lat: shop.Lat,
                          long: shop.Long,
                          distance: (distance / 1000.0).toStringAsFixed(2).toString()
                      ),
                    ]
                );
              },
            );

          }
          if(snapshot.connectionState == ConnectionState.waiting){
            return Column(
                children:[
                  SizedBox(height: deviceHeight*0.06,),
                  CircularProgressIndicator(
                    value: controller.value,
                    semanticsLabel: 'Circular progress indicator',
                  ),
                ]
            );
          }
          else{
            return Text("Yakında Mağaza Yok");
          }
        })
    );
  }

  Widget seeAllShops(){
    return ButtonWidget(text: "Tümünü Haritada Görüntüle", heightConst: 0.06, widthConst: 0.7, size: 15, radius: 20, fontWeight: FontWeight.w600, onTaps: (){Navigator.push(context, MaterialPageRoute(builder: (context) => MapScreenNearShops(currentLat: lat, currentLong: long,)));}, borderWidht: 1, backgroundColor: secondaryColor, borderColor: secondaryColor, textColor: textColor);
  }


}


