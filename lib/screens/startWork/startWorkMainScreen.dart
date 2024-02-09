import 'package:deneme/constants/constants.dart';
import 'package:deneme/routing/bottomNavigationBar.dart';
import 'package:deneme/services/shiftServices.dart';
import 'package:deneme/styles/styleConst.dart';
import 'package:deneme/widgets/button_widget.dart';
import 'package:deneme/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../constants/bottomNaviBarLists.dart';
import '../../constants/pagesLists.dart';
import '../../main.dart';
import '../../models/shift.dart';
import '../../routing/landing.dart';
import '../../utils/appStateManager.dart';
import '../../utils/generalFunctions.dart';
import '../../widgets/alert_dialog.dart';

class StartWorkMainScreen extends StatefulWidget {

  const StartWorkMainScreen({super.key});

  @override
  State<StartWorkMainScreen> createState() =>
      _StartWorkMainScreenState();
}

class _StartWorkMainScreenState extends State<StartWorkMainScreen> {

  late Future<List<Shift>> futureShift;

  String item = shiftType[0];

  int _selectedIndex = 0;

  List<BottomNavigationBarItem> naviBarList = [];
  List<Widget> pageList = [];

  late double deviceHeight;
  late double deviceWidth;

  DateTime now = DateTime.now();

  final ShopVisitWorkManager shopVisitWorkManager = Get.put(ShopVisitWorkManager());
  final ExternalTaskWorkManager externalTaskWorkManager = Get.put(ExternalTaskWorkManager());

  @override
  void initState() {
    super.initState();
    futureShift = fetchShift('${constUrl}api/Mesai/${urlShiftFilter}=${userID}&mesai_tarihi='+now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString());
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
        _selectedIndex = 0;
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
        _selectedIndex = 0;
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
        foregroundColor: appbarForeground,
        backgroundColor: appbarBackground,
        title: const Text('Mesaiye Başla'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(0, deviceHeight*0.09, 0, 0),
        child:Container(
          alignment: Alignment.center,
          child: startWorkMainScreenUI(),
        ),
      ),
      bottomNavigationBar: BottomNaviBar(selectedIndex: _selectedIndex,itemList: naviBarList,pageList: pageList,)
    );
  }

  Widget startWorkMainScreenUI(){
    return Builder(builder: (BuildContext context){
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: deviceHeight*0.04,),
            workDurationInfo(),
            SizedBox(height: deviceHeight*0.09,),
            shiftTypeInfo(),
            SizedBox(height: deviceHeight*0.03,),
            shiftTypeDropDown(),
            SizedBox(height: deviceHeight*0.07,),
            startWorkButton(),
          ],
        ),
      );
    });
  }


  Widget workDurationInfo(){
    return FutureBuilder<List<Shift>>(
        future: futureShift,
        builder: (context, snapshot){
          if(snapshot.hasData){
            return TextWidget(text:"En son kaydettiğiniz mesai süreniz:\n"+calculateElapsedTime(DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day,box.get("startHour"),box.get("startMinute"),box.get("startSecond"),0,0),DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day,box.get("finishHour"),box.get("finishMinute"),box.get("finishSecond"),0,0)), size: 25, fontWeight: FontWeight.w400, color: textColor);
          }
          else{
            return TextWidget(text:"En sonki çalışma süreniz:\n0 saat 0 dakika 0 saniye\nBugün hiç mesai başlatmadınız.", size: 25, fontWeight: FontWeight.w400, color: textColor);
          }
        }
    );
  }

  Widget shiftTypeInfo(){
    return TextWidget(text: "Mesai Türünüzü Seçiniz", size: 20, fontWeight: FontWeight.w400, color: textColor);
  }

  Widget startWorkButton(){
    return ButtonWidget(
        text: "Mesaiye Başla",
        heightConst: 0.06,
        widthConst: 0.8,
        size: 18,
        radius: 20,
        fontWeight:
        FontWeight.w600,
        onTaps: () {
          DateTime startTime = DateTime(now.year, now.month, now.day, 8, 30);
          DateTime endTime = DateTime(now.year, now.month, now.day, 18, 30);

          bool isWithinTimeRange = now.isAfter(startTime) && now.isBefore(endTime);

          if(item=="Mağaza Ziyareti"&& isWithinTimeRange){
            shopVisitWorkManager.startShopVisitWork();
            setState(() {
              box.put("startHour",0);
              box.put("startMinute",0);
              box.put("startSecond",0);
              box.put("shiftDate","");
              box.put("startHour",DateTime.now().hour);
              box.put("startMinute",DateTime.now().minute);
              box.put("startSecond",DateTime.now().second);
              box.put("shiftDate",now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString());
            });
            naviShopVisitingMainScreen(context);
          }
          else if(item=="Harici İş" && isWithinTimeRange){
            externalTaskWorkManager.startExternalTaskWork();
            setState(() {
              box.put("startHour",0);
              box.put("startMinute",0);
              box.put("startSecond",0);
              box.put("shiftDate","");
              box.put("startHour",DateTime.now().hour);
              box.put("startMinute",DateTime.now().minute);
              box.put("startSecond",DateTime.now().second);
              box.put("shiftDate",now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString());
            });
            naviExternalTaskMainScreen(context);
          }
          else if(isWithinTimeRange==false){
            showShiftTimeDialog(context);
          }
        },
        borderWidht: 1,
        backgroundColor: secondaryColor,
        borderColor: secondaryColor,
        textColor: textColor
    );
  }

  Widget shiftTypeDropDown(){
    return DropdownMenu<String>(
      initialSelection: item,
      onSelected: (String? value) {
        setState(() {
          item = value!;
        });
      },
      dropdownMenuEntries: shiftType.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
  }

  showShiftTimeDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialogWidget(
            title: 'Mesai Saati Kontrolü',
            content: '08.30-18.30 saatleri arasında mesai başlatabilirsiniz!',
            onTaps: (){
              naviStartWorkMainScreen(context);
            },
          );
        }
    );
  }
}

