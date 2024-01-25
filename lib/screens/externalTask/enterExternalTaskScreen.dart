import 'package:deneme/constants/constants.dart';
import 'package:deneme/routing/bottomNavigationBar.dart';
import 'package:deneme/routing/landing.dart';
import 'package:deneme/styles/styleConst.dart';
import 'package:deneme/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import '../../constants/bottomNaviBarLists.dart';
import '../../constants/pagesLists.dart';
import '../../services/externalWorkServices.dart';
import '../../widgets/text_form_field.dart';

class EnterExternalTaskScreen extends StatefulWidget {

  static var taskName = "";
  static var taskDeadline = "";
  static var taskDescription = "";

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

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final taskNameController = TextEditingController();
  final taskDeadlineController = TextEditingController();
  final taskDescriptionController = TextEditingController();

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
            SizedBox(height: deviceHeight*0.07,),
            inputForm(),
            SizedBox(height: deviceHeight*0.03,),
            saveExternalTaskButton()
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
            SizedBox(height: deviceHeight*0.03,),
            TextFormFieldWidget(text: "Görev Bitiş Saati", borderWidht: 2, titleColor: textColor, borderColor: textColor, controller: taskDeadlineController, value: EnterExternalTaskScreen.taskName, paddingValue: 5,maxLines: 1,maxLength: 5,controllerString: taskNameController.text),
            SizedBox(height: deviceHeight*0.03,),
            TextFormFieldWidget(text: "Görev Detayı", borderWidht: 2, titleColor: textColor, borderColor: textColor, controller: taskDescriptionController, value: EnterExternalTaskScreen.taskDescription, paddingValue: 5,maxLines: 8,maxLength: 300,controllerString: taskNameController.text),
          ],
        ),
      ),
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
          await countExternalTask("${constUrl}api/HariciIs", context);
          await createExternalWork(
            externalTaskCount+1,
            taskNameController.text,
            taskDescriptionController.text,
            now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString(),
            taskDeadlineController.text,
              (isBS)?userID:null,
              (isBS)?null:userID,
              now.hour.toString()+"."+now.minute.toString(),
              "${constUrl}api/HariciIs"
          );
          naviExternalTasksListScreen(context);
        },
        borderWidht: 1,
        backgroundColor: secondaryColor,
        borderColor: secondaryColor,
        textColor: textColor
    );
  }

}


