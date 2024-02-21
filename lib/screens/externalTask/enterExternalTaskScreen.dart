import 'dart:async';

import 'package:deneme/constants/constants.dart';
import 'package:deneme/routing/bottomNavigationBar.dart';
import 'package:deneme/routing/landing.dart';
import 'package:deneme/styles/styleConst.dart';
import 'package:deneme/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../../constants/bottomNaviBarLists.dart';
import '../../constants/pagesLists.dart';
import '../../services/externalWorkServices.dart';
import '../../widgets/text_form_field.dart';

class EnterExternalTaskScreen extends StatefulWidget {

  static var taskName = "";
  static var starthour = "";
  static var finishHour = "";
  static var taskDescription = "";
  static var date = "";

  const EnterExternalTaskScreen({super.key});

  @override
  State<EnterExternalTaskScreen> createState() =>
      _EnterExternalTaskScreenState();
}

class _EnterExternalTaskScreenState extends State<EnterExternalTaskScreen> {

  int _selectedIndex = 0;

  List<BottomNavigationBarItem> naviBarList = [];
  List<Widget> pageList = [];

  late double deviceHeight;
  late double deviceWidth;

  DateTime now = DateTime.now();

  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;
  String long = "1", lat = "1";
  late StreamSubscription<Position> positionStream;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final taskNameController = TextEditingController();
  final startHourController = TextEditingController();
  final finishHourController = TextEditingController();
  final taskDescriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    checkGps();
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
          foregroundColor: appbarForeground,
          backgroundColor: appbarBackground,
          title: const Text('Harici İş Girişi'),
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
            SizedBox(height: deviceHeight*0.04,),
            inputForm(),
            SizedBox(height: deviceHeight*0.03,),
            selectWorkPlaceButton(),
            SizedBox(height: deviceHeight*0.03,),
            saveExternalTaskButton(),
          ],
        ),
      );
    });
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
            TextFormFieldWidget(text: "Görev Adı", borderWidht: 2, titleColor: textColor, borderColor: textColor, controller: taskNameController, value: EnterExternalTaskScreen.taskName, paddingValue: 5,maxLines: 1,maxLength: 50,controllerString: taskNameController.text),
            SizedBox(height: deviceHeight*0.02,),
            TextField(
              enabled: false,
              controller: TextEditingController(
                  text: now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString()),
              decoration: InputDecoration(
                labelText: 'Tarih',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: deviceHeight*0.02,),
            TextFormFieldWidget(text: "Görev Başlangıç Saati (Örn: 13:30)", borderWidht: 2, titleColor: textColor, borderColor: textColor, controller: startHourController, value: EnterExternalTaskScreen.starthour, paddingValue: 5,maxLines: 1,maxLength: 5,controllerString: startHourController.text),
            SizedBox(height: deviceHeight*0.02,),
            TextFormFieldWidget(text: "Görev Bitiş Saati (Örn: 13:30)", borderWidht: 2, titleColor: textColor, borderColor: textColor, controller: finishHourController, value: EnterExternalTaskScreen.finishHour, paddingValue: 5,maxLines: 1,maxLength: 5,controllerString: startHourController.text),
            SizedBox(height: deviceHeight*0.02,),
            TextFormFieldWidget(text: "Görev Detayı", borderWidht: 2, titleColor: textColor, borderColor: textColor, controller: taskDescriptionController, value: EnterExternalTaskScreen.taskDescription, paddingValue: 5,maxLines: 5,maxLength: 250,controllerString: taskDescriptionController.text),
          ],
        ),
      ),
    );
  }

  Widget selectWorkPlaceButton(){
    return ButtonWidget(
        text: "Yer Seç",
        heightConst: 0.06,
        widthConst: 0.8,
        size: 18,
        radius: 20,
        fontWeight: FontWeight.w600,
        onTaps: (){
          naviPlaceSelectionScreen(context);
        },
        borderWidht: 1,
        backgroundColor: primaryColor,
        borderColor: primaryColor,
        textColor: textColor
    );
  }

  Widget saveExternalTaskButton(){
    return ButtonWidget(
        text: "Harici İşi Kaydet",
        heightConst: 0.06,
        widthConst: 0.8,
        size: 18,
        radius: 20,
        fontWeight: FontWeight.w600,
        onTaps: () async {
          await createExternalWork(
            (isBS)?userID:null,
            (isBS)?null:userID,
            taskNameController.text,
            taskDescriptionController.text.isEmpty ? null : taskDescriptionController.text,
            startHourController.text,
            finishHourController.text,
            now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString(),
            0,
            (showOtherTextField)?workPlaceTextFieldController.text:workPlace2,
            lat,
            long,
            "${constUrl}api/HariciIs"
          );
          setState(() {
            workPlace = "";
            workPlace2="";
            workPlaceTextFieldController.text = "";
            showOtherTextField = false;
          });
          naviExternalTasksListScreen(context);
        },
        borderWidht: 1,
        backgroundColor: secondaryColor,
        borderColor: secondaryColor,
        textColor: textColor
    );
  }

}


