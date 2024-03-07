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
import '../../widgets/alert_dialog.dart';
import '../../widgets/text_form_field.dart';
import 'package:intl/intl.dart';

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

  bool _isSubmitting = false;

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

  TimeOfDay _startTime = TimeOfDay(hour: 0,minute: 0);
  TimeOfDay _finishTime = TimeOfDay(hour: 0,minute: 0);

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _startTime,
    );
    if (picked != null && picked != _startTime) {
      setState(() {
        _startTime = picked;
      });
    }
  }

  Future<void> _selectTime2(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _finishTime,
    );
    if (picked != null && picked != _finishTime) {
      setState(() {
        _finishTime = picked;
      });
    }
  }

  String formatTimeOfDay(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    final dateTime = DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    final formatter = DateFormat('HH:mm:ss');
    print(formatter.format(dateTime));
    return formatter.format(dateTime);
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

    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          foregroundColor: appbarForeground,
          backgroundColor: appbarBackground,
          title: const Text('Harici İş Girişi'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              naviExternalTaskMainScreen(context);
            },
          ),
        ),
        body: PopScope(
          canPop: false,
          onPopInvoked: (bool didPop) {},
          child:SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child:Container(
              alignment: Alignment.center,
              child: submitTaskMainScreenUI(),
            ),
          )
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
            TextField(
              readOnly: true,
              controller: TextEditingController(
                text: '${_startTime.hour}:${_startTime.minute}',
              ),
              onTap: () {
                _selectTime(context);
              },
              decoration: InputDecoration(
                labelText: 'Başlangıç Saati',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: deviceHeight*0.02,),
            TextField(
              readOnly: true,
              controller: TextEditingController(
                text: '${_finishTime.hour}:${_finishTime.minute}',
              ),
              onTap: () {
                _selectTime2(context);
              },
              decoration: InputDecoration(
                labelText: 'Bitiş Saati',
                border: OutlineInputBorder(),
              ),
            ),
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

          setState(() {
            _isSubmitting = true;
          });

          try {

            if (taskNameController.text.isEmpty || _startTime.toString().isEmpty || _finishTime.toString().isEmpty || (workPlace2.isEmpty && workPlaceTextFieldController.text.isEmpty)) {
              // Show an alert dialog if either taskName or taskDeadline is empty
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Uyarı"),
                    content: Text("Görev adı, görev başlangıç saati, görev bitiş saati ve görev yeri boş olamaz."),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Tamam"),
                      ),
                    ],
                  );
                },
              );
              return;
            }
            await createExternalWork(
              (isBS)?userID:null,
              (isBS)?null:userID,
              taskNameController.text,
              taskDescriptionController.text.isEmpty ? null : taskDescriptionController.text,
              formatTimeOfDay(_startTime),
              formatTimeOfDay(_startTime),
              now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString(),
              0,
              (showOtherTextField)?workPlaceTextFieldController.text:workPlace2,
              lat,
              long,
              "${constUrl}api/HariciIs"
            );
            Future.delayed(Duration.zero, () {
              showWorkSubmittedDialog(context);
            });
          } finally {
            setState(() {
              _isSubmitting = false;
            });
          }
          setState(() {
            workPlace = "";
            workPlace2="";
            workPlaceTextFieldController.text = "";
            showOtherTextField = false;
          });
        },
        borderWidht: 1,
        backgroundColor: secondaryColor,
        borderColor: secondaryColor,
        textColor: textColor
    );
  }

  showWorkSubmittedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialogWidget(
          title: 'Görev Atandı',
          content: 'Görev başarıyla atandı!',
          onTaps: (){
            naviExternalTasksListScreen(context);
          },
        );
      },
    );
  }

}


