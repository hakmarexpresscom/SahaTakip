import 'package:flutter/material.dart';
import '../../routing/bottomNavigationBar.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/text_widget.dart';
import 'package:deneme/constants/constants.dart';

class SubmitTaskBSSelectionScreen extends StatefulWidget {
  const SubmitTaskBSSelectionScreen({super.key});

  @override
  State<SubmitTaskBSSelectionScreen> createState() => _SubmitTaskBSSelectionScreenState();
}

class _SubmitTaskBSSelectionScreenState extends State<SubmitTaskBSSelectionScreen> {

  int _selectedIndex = 4;

  List<BottomNavigationBarItem> naviBarList = [];
  List<Widget> pageList = [];

  late double deviceHeight;
  late double deviceWidth;

  late bool bs=false;

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
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child:Container(
            alignment: Alignment.center,
            child: submitTaskBSSelectionUI(),
          ),
        ),
        bottomNavigationBar: BottomNaviBar(selectedIndex: _selectedIndex,itemList: naviBarList,pageList: pageList,)
    );
  }

  Widget submitTaskBSSelectionUI(){
    return Builder(builder: (BuildContext context){
      return Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: deviceHeight*0.07,),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Checkbox(value: bs, onChanged: (newvalue){setState(() {bs=newvalue!;});}),
                TextWidget(text: "Mağaza 1", heightConst: 0, widhtConst: 0, size: 20, fontWeight: FontWeight.w400, color: Colors.black),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Checkbox(value: bs, onChanged: (newvalue){setState(() {bs=newvalue!;});}),
                TextWidget(text: "Mağaza 1", heightConst: 0, widhtConst: 0, size: 20, fontWeight: FontWeight.w400, color: Colors.black),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Checkbox(value: bs, onChanged: (newvalue){setState(() {bs=newvalue!;});}),
                TextWidget(text: "Mağaza 1", heightConst: 0, widhtConst: 0, size: 20, fontWeight: FontWeight.w400, color: Colors.black),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Checkbox(value: bs, onChanged: (newvalue){setState(() {bs=newvalue!;});}),
                TextWidget(text: "Mağaza 1", heightConst: 0, widhtConst: 0, size: 20, fontWeight: FontWeight.w400, color: Colors.black),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Checkbox(value: bs, onChanged: (newvalue){setState(() {bs=newvalue!;});}),
                TextWidget(text: "Mağaza 1", heightConst: 0, widhtConst: 0, size: 20, fontWeight: FontWeight.w400, color: Colors.black),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Checkbox(value: bs, onChanged: (newvalue){setState(() {bs=newvalue!;});}),
                TextWidget(text: "Mağaza 1", heightConst: 0, widhtConst: 0, size: 20, fontWeight: FontWeight.w400, color: Colors.black),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Checkbox(value: bs, onChanged: (newvalue){setState(() {bs=newvalue!;});}),
                TextWidget(text: "Mağaza 1", heightConst: 0, widhtConst: 0, size: 20, fontWeight: FontWeight.w400, color: Colors.black),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Checkbox(value: bs, onChanged: (newvalue){setState(() {bs=newvalue!;});}),
                TextWidget(text: "Mağaza 1", heightConst: 0, widhtConst: 0, size: 20, fontWeight: FontWeight.w400, color: Colors.black),
              ],
            ),
            SizedBox(height: deviceHeight*0.03,),
            BSSelectionButton()
          ],
        ),
      );
    });
}

  Widget BSSelectionButton(){
    return ButtonWidget(text: "Kaydet", heightConst: 0.06, widthConst: 0.8, size: 18, radius: 20, fontWeight: FontWeight.w600, onTaps: (){}, borderWidht: 1, backgroundColor: Colors.lightGreen.withOpacity(0.6), borderColor: Colors.lightGreen.withOpacity(0.6), textColor: Colors.black);
  }

}
