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

  int _selectedIndex = 0; //bu değişken submitTaskMinScreen scriptiyle aynı olacak

  late double deviceHeight;
  late double deviceWidth;

  late bool bs=false;

  @override
  Widget build(BuildContext context) {

    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: const Text('Görev Atama BS Seçimi'),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child:Container(
            alignment: Alignment.center,
            child: submitTaskBSSelectionUI(),
          ),
        ),
        bottomNavigationBar: BottomNaviBar(selectedIndex: _selectedIndex,itemList: itemListBS,pageList: pages,)
    );
  }

  Widget submitTaskBSSelectionUI(){
    return Builder(builder: (BuildContext context){
      return Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: deviceHeight*0.07,),
            TextWidget(text: "BS Seçimi", heightConst: 0, widhtConst: 0, size: 20, fontWeight: FontWeight.w600, color: Colors.black),
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
                TextWidget(text: "Bölge Sorumlusu 1", heightConst: 0, widhtConst: 0, size: 20, fontWeight: FontWeight.w400, color: Colors.black),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Checkbox(value: bs, onChanged: (newvalue){setState(() {bs=newvalue!;});}),
                TextWidget(text: "Bölge Sorumlusu 1", heightConst: 0, widhtConst: 0, size: 20, fontWeight: FontWeight.w400, color: Colors.black),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Checkbox(value: bs, onChanged: (newvalue){setState(() {bs=newvalue!;});}),
                TextWidget(text: "Bölge Sorumlusu 1", heightConst: 0, widhtConst: 0, size: 20, fontWeight: FontWeight.w400, color: Colors.black),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Checkbox(value: bs, onChanged: (newvalue){setState(() {bs=newvalue!;});}),
                TextWidget(text: "Bölge Sorumlusu 1", heightConst: 0, widhtConst: 0, size: 20, fontWeight: FontWeight.w400, color: Colors.black),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Checkbox(value: bs, onChanged: (newvalue){setState(() {bs=newvalue!;});}),
                TextWidget(text: "Bölge Sorumlusu 1", heightConst: 0, widhtConst: 0, size: 20, fontWeight: FontWeight.w400, color: Colors.black),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Checkbox(value: bs, onChanged: (newvalue){setState(() {bs=newvalue!;});}),
                TextWidget(text: "Bölge Sorumlusu 1", heightConst: 0, widhtConst: 0, size: 20, fontWeight: FontWeight.w400, color: Colors.black),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Checkbox(value: bs, onChanged: (newvalue){setState(() {bs=newvalue!;});}),
                TextWidget(text: "Bölge Sorumlusu 1", heightConst: 0, widhtConst: 0, size: 20, fontWeight: FontWeight.w400, color: Colors.black),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Checkbox(value: bs, onChanged: (newvalue){setState(() {bs=newvalue!;});}),
                TextWidget(text: "Bölge Sorumlusu 1", heightConst: 0, widhtConst: 0, size: 20, fontWeight: FontWeight.w400, color: Colors.black),
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
