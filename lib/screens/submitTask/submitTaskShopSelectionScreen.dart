import 'package:flutter/material.dart';
import '../../constants/bottomNaviBarLists.dart';
import '../../constants/pagesLists.dart';
import '../../models/shop.dart';
import '../../routing/bottomNavigationBar.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/text_widget.dart';
import 'package:deneme/constants/constants.dart';

class SubmitTaskBSSelectionScreen extends StatefulWidget {
  const SubmitTaskBSSelectionScreen({super.key});

  @override
  State<SubmitTaskBSSelectionScreen> createState() => _SubmitTaskBSSelectionScreenState();
}

class _SubmitTaskBSSelectionScreenState extends State<SubmitTaskBSSelectionScreen> with TickerProviderStateMixin {

  int _selectedIndex = 4;

  List<BottomNavigationBarItem> naviBarList = [];
  List<Widget> pageList = [];

  late double deviceHeight;
  late double deviceWidth;

  late bool bs=false;

  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    //futureShopList = fetchShop();
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
      }
      if(user=="PM"){
        naviBarList = itemListPM;
        pageList = pagesPM;
        _selectedIndex = 4;
      }
      if(user=="BM" || user=="GK"){
        naviBarList = itemListBMandGK;
        pageList = pagesBMGK;
        _selectedIndex = 2;
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
            children: <Widget>[
              SizedBox(height: deviceHeight*0.04,),
              TextWidget(text: "Mağaza Seçimi", heightConst: 0, widhtConst: 0, size: 20, fontWeight: FontWeight.w600, color: Colors.black),
              SizedBox(height: deviceHeight*0.03,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Checkbox(value: bs, onChanged: (newvalue){setState(() {bs=newvalue!;});}),
                  TextWidget(text: "Tümünü Seç", heightConst: 0, widhtConst: 0, size: 20, fontWeight: FontWeight.w400, color: Colors.black),
                ],
              ),
              submitTaskBSSelectionUI(),
              SizedBox(height: deviceHeight*0.03,),
              BSSelectionButton(),
            ]
        ),
        bottomNavigationBar: BottomNaviBar(selectedIndex: _selectedIndex,itemList: naviBarList,pageList: pageList,)
    );
  }

  Widget submitTaskBSSelectionUI(){
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
                    Checkbox(value: bs, onChanged: (newvalue){setState(() {bs=newvalue!;});}),
                    TextWidget(text: snapshot.data![index].shopName, heightConst: 0, widhtConst: 0, size: 17, fontWeight: FontWeight.w400, color: Colors.black),
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

  Widget BSSelectionButton(){
    return ButtonWidget(text: "Kaydet", heightConst: 0.06, widthConst: 0.8, size: 18, radius: 20, fontWeight: FontWeight.w600, onTaps: (){}, borderWidht: 1, backgroundColor: Colors.lightGreen.withOpacity(0.6), borderColor: Colors.lightGreen.withOpacity(0.6), textColor: Colors.black);
  }

}
