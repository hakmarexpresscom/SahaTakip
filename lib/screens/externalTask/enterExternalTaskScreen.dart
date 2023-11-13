import 'package:deneme/constants/constants.dart';
import 'package:deneme/routing/bottomNavigationBar.dart';
import 'package:deneme/routing/landing.dart';
import 'package:deneme/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import '../../constants/bottomNaviBarLists.dart';
import '../../constants/pagesLists.dart';
import '../../services/externalWorkServices.dart';
import '../../widgets/textFormFieldDatePicker.dart';
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
            TextFormFieldWidget(text: "Görev Adı", borderWidht: 2, titleColor: Colors.black, borderColor: Colors.black, controller: taskNameController, value: EnterExternalTaskScreen.taskName, paddingValue: 5,maxLines: 1),
            SizedBox(height: deviceHeight*0.03,),
            TextFormFieldWidget(text: "Görev Bitiş Saati", borderWidht: 2, titleColor: Colors.black, borderColor: Colors.black, controller: taskDeadlineController, value: EnterExternalTaskScreen.taskName, paddingValue: 5,maxLines: 1),
            SizedBox(height: deviceHeight*0.03,),
            TextFormFieldWidget(text: "Görev Detayı", borderWidht: 2, titleColor: Colors.black, borderColor: Colors.black, controller: taskDescriptionController, value: EnterExternalTaskScreen.taskDescription, paddingValue: 5,maxLines: 8),
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
          await countExternalTask("http://172.23.21.112:7042/api/HariciIs", context);
          await createExternalWork(
            externalTaskCount+1,
            taskNameController.text,
            taskDescriptionController.text,
            now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString(),
            taskDeadlineController.text,
              (isBS)?userID:null,
              (isBS)?null:userID,
              now.hour.toString()+"."+now.minute.toString(),
              "http://172.23.21.112:7042/api/HariciIs"
          );
          naviExternalTasksListScreen(context);
        },
        borderWidht: 1,
        backgroundColor: Colors.lightGreen.withOpacity(0.6),
        borderColor: Colors.lightGreen.withOpacity(0.6),
        textColor: Colors.black);
  }

}


