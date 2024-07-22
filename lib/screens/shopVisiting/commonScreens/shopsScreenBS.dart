import 'dart:async';
import 'package:deneme/constants/constants.dart';
import 'package:deneme/routing/bottomNavigationBar.dart';
import 'package:deneme/utils/appStateManager.dart';
import 'package:deneme/widgets/cards/visitingShopCard.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../constants/bottomNaviBarLists.dart';
import '../../../constants/pagesLists.dart';
import '../../../main.dart';
import '../../../models/shop.dart';
import '../../../routing/landing.dart';
import '../../../services/shopServices.dart';
import '../../../services/visitingDurationsServices.dart';
import '../../../styles/styleConst.dart';
import '../../../utils/distanceFunctions.dart';
import '../../../utils/generalFunctions.dart';
import '../../../widgets/alert_dialog.dart';
import '../../../widgets/alert_dialog_without_button.dart';

class ShopVisitingShopsScreen extends StatefulWidget {
  const ShopVisitingShopsScreen({super.key});

  @override
  State<ShopVisitingShopsScreen> createState() =>
      _ShopVisitingShopsScreenState();
}

class _ShopVisitingShopsScreenState extends State<ShopVisitingShopsScreen> with TickerProviderStateMixin{

  late Future<List<Shop>> futureOwnShopListBS;
  late Future<List<Shop>> futurePartnerShopList;

  TextEditingController shopSearchController = TextEditingController();
  List<String> shopListOnSearch = [];

  TextEditingController partnerShopSearchController = TextEditingController();
  List<String> partnerShopListOnSearch = [];

  int _selectedIndex = 0;

  List<BottomNavigationBarItem> naviBarList = [];
  List<Widget> pageList = [];

  late double deviceHeight;
  late double deviceWidth;

  late AnimationController controller;

  final StoreVisitManager storeVisitManager = Get.put(StoreVisitManager());
  final ReportManager reportManager = Get.put(ReportManager());

  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;
  String long = "1", lat = "1";
  late StreamSubscription<Position> positionStream;

  @override
  void initState() {
    super.initState();

    createSearchBarShopList('${constUrl}api/magaza${box.get("urlShopFilter")}=${userID}',false);
    createSearchBarShopList('${constUrl}api/magaza/byBolge?bolge=${regionCode}',true);
    futureOwnShopListBS = fetchShop('${constUrl}api/magaza${box.get("urlShopFilter")}=${userID}');
    futurePartnerShopList = fetchShop('${constUrl}api/magaza/byBolge?bolge=${regionCode}');

    checkGps();
    controller = AnimationController(
      /// [AnimationController]s can be created with `vsync: this` because of
      /// [TickerProviderStateMixin].
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
    });
    controller.repeat(reverse: true);
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
        if(isStartShiftObs.value==false&&isRegionCenterVisitInProgress.value==false){
          pageList = pagesBS;
        }
        else if(isStartShiftObs.value&&isRegionCenterVisitInProgress.value==false){
          pageList = pagesBS2;
        }
        else if(isRegionCenterVisitInProgress.value){
          pageList = pagesBS3;
        }
      }
      if(user=="PM"){
        naviBarList = itemListPM;
        if(isStartShiftObs.value==false&&isRegionCenterVisitInProgress.value==false){
          pageList = pagesPM;
        }
        else if(isStartShiftObs.value&&isRegionCenterVisitInProgress.value==false){
          pageList = pagesPM2;
        }
        else if(isRegionCenterVisitInProgress.value){
          pageList = pagesPM3;
        }
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
           foregroundColor: appbarForeground,
           backgroundColor: appbarBackground,
          title: const Text('Mağaza Listesi'),
           leading: IconButton(
             icon: Icon(Icons.arrow_back),
             onPressed: () {
               naviShiftTypeScreen(context);
             },
           ),
          bottom: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white30,
            tabs: [
              Tab(text: "Kendi Mağazalarım"),
              Tab(text: "Partner Mağazalar")
            ],
          ),
        ),
         body: PopScope(
          canPop: false,
          onPopInvoked: (bool didPop) {},
          child:LayoutBuilder(
             builder: (BuildContext context, BoxConstraints constraints){
               if(350<constraints.maxWidth && constraints.maxWidth<420 && deviceHeight<800){
                 return TabBarView(
                   children: <Widget>[
                     ownShopsScreenUI(0.00, 0.015, 0.02, 20, 18, 15),
                     partnerShopsScreenUI(0.00, 0.015, 0.02, 20, 18, 15)
                   ],
                 );
               }
               else if(651<constraints.maxWidth && constraints.maxWidth<1000){
                 return TabBarView(
                   children: <Widget>[
                     ((deviceHeight-deviceWidth)<150) ? ownShopsScreenUI(0.00, 0.02, 0.02, 20, 18, 15) : ownShopsScreenUI(0.00, 0.02, 0.015, 30, 25, 20),
                     ((deviceHeight-deviceWidth)<150) ? partnerShopsScreenUI(0.00, 0.02, 0.02, 20, 18, 15) : partnerShopsScreenUI(0.00, 0.02, 0.015, 30, 25, 20),
                   ],
                 );
               }
               else if(deviceHeight>800 || (421<constraints.maxWidth && constraints.maxWidth<650)){
                 return TabBarView(
                   children: <Widget>[
                     ownShopsScreenUI(0.00, 0.01, 0.015, 20, 18, 15),
                     partnerShopsScreenUI(0.00, 0.01, 0.015, 20, 18, 15),
                   ],
                 );
               }
               else{
                 return Container();
               }
             },
           )
         ),
          bottomNavigationBar: BottomNaviBar(selectedIndex: _selectedIndex,itemList: naviBarList,pageList: pageList,)
    ));
  }

  Widget ownShopsScreenUI(double sizedBoxConst1, double sizedBoxConst2, double sizedBoxConst3, double textSizeCode, double textSizeName, double textSizeButton){
    return Flex(
        direction: Axis.vertical,
        children:[
          Column(
            children: [
              SizedBox(height: deviceHeight*0.03,),
              searchBar(),
              SizedBox(height: deviceHeight*0.03,),
            ],
          ),
          Expanded(
            child: FutureBuilder<List<Shop>>(
              future: futureOwnShopListBS,
              builder: (context, snapshot){
                if(snapshot.hasData){
                  if(shopSearchController.text.isEmpty) {
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (snapshot.data![index].isActive == 1) {
                          return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                VisitingShopCard(
                                    icon: Icons.store,
                                    sizedBoxConst1: sizedBoxConst1,
                                    sizedBoxConst2: sizedBoxConst2,
                                    sizedBoxConst3: sizedBoxConst3,
                                    textSizeCode: textSizeCode,
                                    textSizeName: textSizeName,
                                    textSizeButton: textSizeButton,
                                    shopName: snapshot.data![index].shopName,
                                    shopCode: snapshot.data![index].shopCode.toString(),
                                    lat: snapshot.data![index].Lat,
                                    long: snapshot.data![index].Long,
                                    onTaps: () async {
                                      if (getDistance(double.parse(lat), double.parse(long), double.parse(snapshot.data![index].Lat), double.parse(snapshot.data![index].Long)) <= 250.0) {

                                        showWaitingDialog(context);

                                        storeVisitManager.startStoreVisit();
                                        box.put("currentShopName", snapshot.data![index].shopName);
                                        box.put("currentShopID", snapshot.data![index].shopCode);
                                        box.put("visitingStartTime", DateTime.now());
                                        await createVisitingDurations(
                                            box.get('currentShopID'),
                                            (isBS == true) ? userID : null,
                                            (isBS == true) ? null : userID,
                                            box.get("visitingStartTime").toIso8601String(),
                                            null,
                                            box.get("shiftDate"),
                                            null,
                                            "${constUrl}api/ZiyaretSureleri"
                                        );
                                        await countVisitingDurations("${constUrl}api/ZiyaretSureleri");

                                        Navigator.of(context).pop(); // Close the dialog
                                        naviShopVisitingProcessesScreen(context, snapshot.data![index].shopCode, snapshot.data![index].shopName);
                                      }
                                      else {
                                        showShopDistanceDialog(context);
                                      }
                                    }
                                )
                              ]
                          );
                        }
                        else {
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
                      itemBuilder: (BuildContext context, int index) {
                        if (shopListOnSearch.contains(snapshot.data![index].shopCode.toString()+" "+snapshot.data![index].shopName)&&snapshot.data![index].isActive == 1) {
                          return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                VisitingShopCard(
                                    icon: Icons.store,
                                    sizedBoxConst1: sizedBoxConst1,
                                    sizedBoxConst2: sizedBoxConst2,
                                    sizedBoxConst3: sizedBoxConst3,
                                    textSizeCode: textSizeCode,
                                    textSizeName: textSizeName,
                                    textSizeButton: textSizeButton,
                                    shopName: snapshot.data![index].shopName,
                                    shopCode: snapshot.data![index].shopCode.toString(),
                                    lat: snapshot.data![index].Lat,
                                    long: snapshot.data![index].Long,
                                    onTaps: () async {
                                      if (getDistance(double.parse(lat), double.parse(long), double.parse(snapshot.data![index].Lat), double.parse(snapshot.data![index].Long)) <= 250.0) {

                                        showWaitingDialog(context);

                                        storeVisitManager.startStoreVisit();
                                        box.put("currentShopName", snapshot.data![index].shopName);
                                        box.put("currentShopID", snapshot.data![index].shopCode);
                                        box.put("visitingStartTime", DateTime.now());
                                        await createVisitingDurations(
                                            box.get('currentShopID'),
                                            (isBS == true) ? userID : null,
                                            (isBS == true) ? null : userID,
                                            box.get("visitingStartTime").toIso8601String(),
                                            null,
                                            box.get("shiftDate"),
                                            null,
                                            "${constUrl}api/ZiyaretSureleri"
                                        );
                                        await countVisitingDurations("${constUrl}api/ZiyaretSureleri");

                                        Navigator.of(context).pop(); // Close the dialog
                                        naviShopVisitingProcessesScreen(context, snapshot.data![index].shopCode, snapshot.data![index].shopName);
                                      }
                                      else {
                                        showShopDistanceDialog(context);
                                      }
                                    }
                                )
                              ]
                          );
                        }
                        else {
                          return Container();
                        }
                      },
                    );
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
          ),
        ]
    );
  }

  Widget partnerShopsScreenUI(double sizedBoxConst1, double sizedBoxConst2, double sizedBoxConst3, double textSizeCode, double textSizeName, double textSizeButton) {
    return Flex(
        direction: Axis.vertical,
        children: [
          Column(
            children: [
              SizedBox(height: deviceHeight*0.03,),
              searchBar2(),
              SizedBox(height: deviceHeight*0.03,),
            ],
          ),
          Expanded(
              child: FutureBuilder<List<Shop>>(
                  future: futurePartnerShopList,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if(partnerShopSearchController.text.isEmpty) {
                        return ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            if(snapshot.data![index].isActive==1){
                              return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    VisitingShopCard(
                                      icon: Icons.store,
                                      sizedBoxConst1: sizedBoxConst1,
                                      sizedBoxConst2: sizedBoxConst2,
                                      sizedBoxConst3: sizedBoxConst3,
                                      textSizeCode: textSizeCode,
                                      textSizeName: textSizeName,
                                      textSizeButton: textSizeButton,
                                      shopName: snapshot.data![index].shopName,
                                      shopCode: snapshot.data![index].shopCode.toString(),
                                      lat: snapshot.data![index].Lat,
                                      long: snapshot.data![index].Long,
                                      onTaps: () async{
                                        if(getDistance(double.parse(lat), double.parse(long), double.parse(snapshot.data![index].Lat), double.parse(snapshot.data![index].Long))<=250.0) {

                                          showWaitingDialog(context);

                                          storeVisitManager.startStoreVisit();
                                          box.put("currentShopName", snapshot.data![index].shopName);
                                          box.put("currentShopID", snapshot.data![index].shopCode);
                                          box.put("visitingStartTime",DateTime.now());
                                          await createVisitingDurations(
                                            box.get('currentShopID'),
                                            (isBS==true)?userID:null,
                                            (isBS==true)?null:userID,
                                            box.get("visitingStartTime").toIso8601String(),
                                            null,
                                            box.get("shiftDate"),
                                            null,
                                            "${constUrl}api/ZiyaretSureleri"
                                          );
                                          await countVisitingDurations("${constUrl}api/ZiyaretSureleri");

                                          Navigator.of(context).pop(); // Close the dialog
                                          naviShopVisitingProcessesScreen(context, snapshot.data![index].shopCode, snapshot.data![index].shopName);
                                        }
                                        else{
                                          showShopDistanceDialog(context);
                                        }
                                      }
                                    )
                                  ]
                              );
                            }
                            else{
                              return Container();
                            }
                          },
                        );
                      }
                      else if(partnerShopSearchController.text.isNotEmpty){
                        return ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            if (partnerShopListOnSearch.contains(snapshot.data![index].shopCode.toString()+" "+snapshot.data![index].shopName)&&snapshot.data![index].isActive == 1) {
                              return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    VisitingShopCard(
                                        icon: Icons.store,
                                        sizedBoxConst1: sizedBoxConst1,
                                        sizedBoxConst2: sizedBoxConst2,
                                        sizedBoxConst3: sizedBoxConst3,
                                        textSizeCode: textSizeCode,
                                        textSizeName: textSizeName,
                                        textSizeButton: textSizeButton,
                                        shopName: snapshot.data![index].shopName,
                                        shopCode: snapshot.data![index].shopCode.toString(),
                                        lat: snapshot.data![index].Lat,
                                        long: snapshot.data![index].Long,
                                        onTaps: () async {
                                          if (getDistance(double.parse(lat), double.parse(long), double.parse(snapshot.data![index].Lat), double.parse(snapshot.data![index].Long)) <= 250.0) {

                                            showWaitingDialog(context);

                                            storeVisitManager.startStoreVisit();
                                            box.put("currentShopName", snapshot.data![index].shopName);
                                            box.put("currentShopID", snapshot.data![index].shopCode);
                                            box.put("visitingStartTime", DateTime.now());
                                            await createVisitingDurations(
                                                box.get('currentShopID'),
                                                (isBS == true) ? userID : null,
                                                (isBS == true) ? null : userID,
                                                box.get("visitingStartTime").toIso8601String(),
                                                null,
                                                box.get("shiftDate"),
                                                null,
                                                "${constUrl}api/ZiyaretSureleri"
                                            );
                                            await countVisitingDurations("${constUrl}api/ZiyaretSureleri");

                                            Navigator.of(context).pop(); // Close the dialog
                                            naviShopVisitingProcessesScreen(context, snapshot.data![index].shopCode, snapshot.data![index].shopName);
                                          }
                                          else {
                                            showShopDistanceDialog(context);
                                          }
                                        }
                                    )
                                  ]
                              );
                            }
                            else {
                              return Container();
                            }
                          },
                        );
                      }
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
          ),
        ]
    );
  }

  showWaitingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return  AlertDialogWithoutButtonWidget(
          title: "Ziyaret Başlatılıyor",
          content: "Ziyaretiniz başlatılıyor, lütfen bekleyiniz.",
        );
      },
    );
  }

  showShopDistanceDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialogWidget(
            title: 'Mesafe Kontrolü',
            content: 'Ziyaret etmek istediğiniz mağazanın en az 250 metre yakınında olmanız gerekmektedir!',
            onTaps: (){
              naviShopVisitingShopsScreenPM(context);
            },
          );
        }
    );
  }

  Widget searchBar(){
    return TextField(
      controller: shopSearchController,
      onChanged: (value){
        setState ((){
          shopListOnSearch = ownShopList
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

  Widget searchBar2(){
    return TextField(
      controller: partnerShopSearchController,
      onChanged: (value){
        setState ((){
          partnerShopListOnSearch = partnerShopList
              .where((element) => element.toLowerCase().contains(value.toLowerCase()))
              .toList();
          print(partnerShopListOnSearch);
        });},
      decoration: InputDecoration(
        labelText: "Mağaza Ara",
        hintText: "Mağaza Ara",
        prefixIcon: Icon(Icons.search),
        suffixIcon: partnerShopSearchController.text.isEmpty ? null
            : InkWell(
          onTap: () {
            partnerShopListOnSearch.clear();
            partnerShopSearchController.clear();
            setState (() {
              partnerShopSearchController.text = '';
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


