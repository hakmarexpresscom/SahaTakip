import 'package:deneme/constants/constants.dart';
import 'package:deneme/routing/bottomNavigationBar.dart';
import 'package:deneme/screens/submitTask/submitTaskBSSelectionScreen.dart';
import 'package:deneme/widgets/button_widget.dart';
import 'package:deneme/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import '../../widgets/text_form_field.dart';
import '../shopVisiting/commonScreens/shopsScreen.dart';

class SubmitTaskMainScreen extends StatefulWidget {

  static var taskName = "";
  static var taskDeadline = "";
  static var taskDescription = "";

  const SubmitTaskMainScreen({super.key});

  @override
  State<SubmitTaskMainScreen> createState() =>
      _SubmitTaskMainScreenState();
}

class _SubmitTaskMainScreenState extends State<SubmitTaskMainScreen> {

  int _selectedIndex = 4;

  List<BottomNavigationBarItem> naviBarList = [];
  List<Widget> pageList = [];

  late double deviceHeight;
  late double deviceWidth;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final taskNameController = TextEditingController();
  final taskDeadlineController = TextEditingController();
  final taskDescriptionController = TextEditingController();

  late bool inPlace=false;
  late bool remote=false;

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
          backgroundColor: Colors.indigo,
          title: const Text('Görev Atama'),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child:Container(
            alignment: Alignment.center,
            child: submitTaskMainScreenUI(),
          ),
        ),
        bottomNavigationBar: BottomNaviBar(selectedIndex: _selectedIndex,itemList: naviBarList,pageList: pageList,)
    );
  }

  Widget submitTaskMainScreenUI(){
    return Builder(builder: (BuildContext context){
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: deviceHeight*0.07,),
            inputForm(),
            SizedBox(height: deviceHeight*0.03,),
            inPlaceOrRemoteTaskCheckbox(),
            SizedBox(height: deviceHeight*0.03,),
            BSSelectionButton(),
            SizedBox(height: deviceHeight*0.03,),
            submitTaskButton()
          ],
        ),
      );
    });
  }

  void navi(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context) => SubmitTaskBSSelectionScreen()));
  }

  Widget submitTaskButton(){
    return ButtonWidget(text: "Görevi Ata", heightConst: 0.06, widthConst: 0.8, size: 18, radius: 20, fontWeight: FontWeight.w600, onTaps: (){}, borderWidht: 1, backgroundColor: Colors.lightGreen.withOpacity(0.6), borderColor: Colors.lightGreen.withOpacity(0.6), textColor: Colors.black);
  }

  Widget BSSelectionButton(){
    return ButtonWidget(text: "BS Seçimi", heightConst: 0.06, widthConst: 0.8, size: 18, radius: 20, fontWeight: FontWeight.w600, onTaps: (){navi(context);}, borderWidht: 3, backgroundColor: Colors.orangeAccent, borderColor: Colors.orangeAccent, textColor: Colors.black);
  }

  Widget inputForm(){
    return Container(
      width: deviceWidth*0.8,
      child: Form(
        key: _formKey,
        onChanged: (){
          _formKey.currentState!.save();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextFormFieldWidget(text: "Görev Adı", borderWidht: 2, titleColor: Colors.black, borderColor: Colors.black, controller: taskNameController, prefixIcon: Icon(Icons.money), value: SubmitTaskMainScreen.taskName, paddingValue: 5,maxLines: 1),
            SizedBox(height: deviceHeight*0.03,),
            TextFormFieldWidget(text: "Görev Bitiş Tarihi", borderWidht: 2, titleColor: Colors.black, borderColor: Colors.black, controller: taskDeadlineController, prefixIcon: Icon(Icons.money), value: SubmitTaskMainScreen.taskDeadline, paddingValue: 5,maxLines: 1),
            SizedBox(height: deviceHeight*0.03,),
            TextFormFieldWidget(text: "Görev Detayı", borderWidht: 2, titleColor: Colors.black, borderColor: Colors.black, controller: taskDescriptionController, prefixIcon: Icon(Icons.money), value: SubmitTaskMainScreen.taskDescription, paddingValue: 5,maxLines: 8),
          ],
        ),
      ),
    );
  }

  Widget inPlaceOrRemoteTaskCheckbox(){
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextWidget(text: "Yerinde yada Uzaktan?", heightConst: 0, widhtConst: 0, size: 20, fontWeight: FontWeight.w600, color: Colors.black),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextWidget(text: "Yerinde", heightConst: 0, widhtConst: 0, size: 20, fontWeight: FontWeight.w400, color: Colors.black),
                  Checkbox(value: inPlace, onChanged: (newvalue){setState(() {inPlace=newvalue!;});})
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextWidget(text: "Uzaktan", heightConst: 0, widhtConst: 0, size: 20, fontWeight: FontWeight.w400, color: Colors.black),
                  Checkbox(value: remote, onChanged: (newvalue){setState(() {remote=newvalue!;});})
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

}


