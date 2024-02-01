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

  late List<Map<String, String>> coordinates;

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
    coordinates = [{"lat":"","long":""}];
    futureShopList = fetchShop('${constUrl}api/magaza');
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
        _selectedIndex = 2;
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
        _selectedIndex = 2;
      }
      if(user=="BM" || user=="GK"){
        naviBarList = itemListBMandGK;
        pageList = pagesBMGK;
        _selectedIndex = 1;
      }
      if(user=="NK"){
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
        body: LayoutBuilder(
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
        ),
        bottomNavigationBar: BottomNaviBar(selectedIndex: _selectedIndex,itemList: naviBarList,pageList: pageList,),
    );
  }


  Widget nearShopsMainScreenUI(double sizedBoxConst1, double sizedBoxConst2, double sizedBoxConst3, double sizedBoxConst4, double textSizeCode, double textSizeName, double textSizeButton){
    return Expanded(child: FutureBuilder<List<Shop>>(
        future: futureShopList,
        builder: (context, snapshot){
          if(snapshot.hasData){
            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index){
                if(getDistance(double.parse(lat), double.parse(long), double.parse(snapshot.data![index].Lat), double.parse(snapshot.data![index].Long))<=5000.0&&snapshot.data![index].isActive==1){
                  GoogleMapMarkerList.list.add({"id":snapshot.data![index].shopCode.toString(),"lat":snapshot.data![index].Lat, "long":snapshot.data![index].Long, });
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:<Widget>[
                        NearShopCard(
                            icon: Icons.near_me,
                            sizedBoxConst1: sizedBoxConst1,
                            sizedBoxConst2: sizedBoxConst2,
                            sizedBoxConst3: sizedBoxConst3,
                            sizedBoxConst4: sizedBoxConst4,
                            textSizeCode: textSizeCode,
                            textSizeName: textSizeName,
                            textSizeButton: textSizeButton,
                            shopName: snapshot.data![index].shopName,
                            shopCode: snapshot.data![index].shopCode.toString(),
                            lat: snapshot.data![index].Lat,
                            long: snapshot.data![index].Long,
                            distance: ((getDistance(double.parse(lat), double.parse(long), double.parse(snapshot.data![index].Lat), double.parse(snapshot.data![index].Long))/1000.0)+1.0).toStringAsFixed(2).toString()
                        ),
                      ]
                  );
                }
                else{
                  return Container();
                }
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


