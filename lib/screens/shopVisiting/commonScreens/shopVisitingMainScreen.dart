import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../constants/bottomNaviBarLists.dart';
import '../../../constants/constants.dart';
import '../../../constants/pagesLists.dart';
import '../../../routing/bottomNavigationBar.dart';
import '../../../routing/landing.dart';
import '../../../utils/appStateManager.dart';
import '../../../widgets/button_widget.dart';

class ShopVisitingMainScreen extends StatefulWidget {
  const ShopVisitingMainScreen({super.key});

  @override
  State<ShopVisitingMainScreen> createState() => _ShopVisitingMainScreenState();
}

class _ShopVisitingMainScreenState extends State<ShopVisitingMainScreen> {

  int _selectedIndex = 0;

  List<BottomNavigationBarItem> naviBarList = [];
  List<Widget> pageList = [];

  late double deviceHeight;
  late double deviceWidth;

  DateTime now = DateTime.now();

  final ShopVisitWorkManager shopVisitWorkManager = Get.put(ShopVisitWorkManager());

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

    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          foregroundColor: Colors.white,
          backgroundColor: Colors.indigo,
          title: const Text('Mağaza Ziyareti'),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child:Container(
            alignment: Alignment.center,
            child: shopVisitingMainScreenUI(),
          ),
        ),
        bottomNavigationBar: BottomNaviBar(selectedIndex: _selectedIndex,itemList: naviBarList,pageList: pageList,)
    );
  }

  Widget shopVisitingMainScreenUI(){
    return Builder(builder: (BuildContext context){
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: deviceHeight*0.08,),
            myShopsButton(),
            SizedBox(height: deviceHeight*0.03,),
            stopExternalTaskButton()
          ],
        ),
      );
    });
  }


  Widget myShopsButton(){
    return ButtonWidget(
        text: "Mağazalarımı Göster",
        heightConst: 0.06,
        widthConst: 0.8,
        size: 18,
        radius: 20,
        fontWeight: FontWeight.w600,
        onTaps: (){
          (isBS) ? naviShopVisitingShopsScreen(context):naviShopVisitingShopsScreenPM(context);
        },
        borderWidht: 1,
        backgroundColor: Colors.lightGreen.withOpacity(0.6),
        borderColor: Colors.lightGreen.withOpacity(0.6),
        textColor: Colors.black);
  }
  Widget stopExternalTaskButton(){
    return ButtonWidget(
        text: "Mesaiyi Bitir",
        heightConst: 0.06,
        widthConst: 0.8,
        size: 18,
        radius: 20,
        fontWeight: FontWeight.w600,
        onTaps: (){
          shopVisitWorkManager.endShopVisitWork();
          naviStartWorkMainScreen(context);
        },
        borderWidht: 1,
        backgroundColor: Colors.red.withOpacity(0.6),
        borderColor: Colors.red.withOpacity(0.6),
        textColor: Colors.black);
  }

}
