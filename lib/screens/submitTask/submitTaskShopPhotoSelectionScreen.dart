import 'package:deneme/widgets/cards/shopPhotoCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../constants/bottomNaviBarLists.dart';
import '../../constants/constants.dart';
import '../../constants/pagesLists.dart';
import '../../models/shop.dart';
import '../../services/shopServices.dart';
import '../../widgets/button_widget.dart';

class SubmitTaskShopPhotoSelectionScreen extends StatefulWidget {
  const SubmitTaskShopPhotoSelectionScreen({super.key});

  @override
  State<SubmitTaskShopPhotoSelectionScreen> createState() => _SubmitTaskShopPhotoSelectionScreenState();
}

class _SubmitTaskShopPhotoSelectionScreenState extends State<SubmitTaskShopPhotoSelectionScreen> with TickerProviderStateMixin {

  late Future<List<Shop>> futureShopList;

  int _selectedIndex = 4;

  List<BottomNavigationBarItem> naviBarList = [];
  List<Widget> pageList = [];

  late double deviceHeight;
  late double deviceWidth;

  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    futureShopList = fetchShop('http://172.23.21.112:7042/api/magaza${urlShopFilter}=${userID}');
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
        pageList = pagesBS;
      }
      if(user=="PM"){
        naviBarList = itemListPM;
        pageList = pagesPM;
        _selectedIndex = 4;
      }
      if(user=="BM" || user=="GK"){
        naviBarList = itemListBMandGK;
        pageList = pagesBMGK;
        _selectedIndex = 3;
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
        title: const Text('Görev Atama Mağaza Seçimi'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: deviceHeight*0.02,),
          submitTaskShopPhotoSelectionScreen(),
          SizedBox(height: deviceHeight*0.02,),
          shopPhotoSelectionButton(),
          SizedBox(height: deviceHeight*0.02,),
        ],
      )
    );
  }

  Widget submitTaskShopPhotoSelectionScreen(){
    return Expanded(child: FutureBuilder<List<Shop>>(
        future: futureShopList,
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
                  children: [
                    ShopPhotoCard(heightConst: 0.27, widthConst: 0.80, sizedBoxConst1: 0.00, sizedBoxConst2: 0.01, sizedBoxConst3: 0.03, sizedBoxConst4: 0.01, shopName: snapshot.data![index].shopName, shopCode: snapshot.data![index].shopCode, icon: Icons.store, textSizeCode: 20, textSizeButton: 15, textSizeName: 18, onTaps: (){}, value: false)
                  ],
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
            return Text("Veri yok");
          }
        })
    );
  }

  Widget shopPhotoSelectionButton(){
    return ButtonWidget(text: "Kaydet", heightConst: 0.06, widthConst: 0.8, size: 18, radius: 20, fontWeight: FontWeight.w600, onTaps: (){Navigator.pop(context);}, borderWidht: 1, backgroundColor: Colors.lightGreen.withOpacity(0.6), borderColor: Colors.lightGreen.withOpacity(0.6), textColor: Colors.black);
  }

}
