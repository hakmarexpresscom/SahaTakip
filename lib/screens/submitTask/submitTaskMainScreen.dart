import 'package:deneme/constants/constants.dart';
import 'package:deneme/routing/bottomNavigationBar.dart';
import 'package:deneme/styles/styleConst.dart';
import 'package:deneme/utils/generalFunctions.dart';
import 'package:deneme/widgets/alert_dialog.dart';
import 'package:deneme/widgets/button_widget.dart';
import 'package:deneme/widgets/textFormFieldDatePicker.dart';
import 'package:deneme/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import '../../constants/bottomNaviBarLists.dart';
import '../../constants/pagesLists.dart';
import '../../routing/landing.dart';
import '../../widgets/text_form_field.dart';


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

  bool _isSubmitting = false; // Variable to track whether the task is being submitted

  int _selectedIndex = 4;

  List<BottomNavigationBarItem> naviBarList = [];
  List<Widget> pageList = [];

  late double deviceHeight;
  late double deviceWidth;

  DateTime now = DateTime.now();

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
        _selectedIndex = 4;
      }
      if(user=="BM" || user=="GK"){
        naviBarList = itemListBMandGK;
        pageList = pagesBMGK;
        _selectedIndex = 3;
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

  Widget submitTaskMainScreenUI() {
    return Builder(builder: (BuildContext context) {
      return Container(
        child: (_isSubmitting)?
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
            TextWidget(text: "Görev atanıyor lütfen bekleyiniz.", size: 20, fontWeight: FontWeight.w400, color: textColor),
            SizedBox(height: deviceHeight * 0.03,),
            CircularProgressIndicator()
          ]
        ):
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: deviceHeight * 0.02,),
            inputForm(),
            SizedBox(height: deviceHeight * 0.03,),
            inPlaceOrRemoteTaskCheckbox(),
            SizedBox(height: deviceHeight * 0.03,),
            showAddedPhotoButton(),
            SizedBox(height: deviceHeight * 0.03,),
            shopSelectionButton(),
            SizedBox(height: deviceHeight * 0.03,),
            // Show a loading spinner while _isSubmitting is true
            submitTaskButton(),
            SizedBox(height: deviceHeight * 0.03,),
          ],
        ),
      );
    });
  }


  Widget submitTaskButton() {
    return ButtonWidget(
      text: "Görevi Ata",
      heightConst: 0.06,
      widthConst: 0.8,
      size: 18,
      radius: 20,
      fontWeight: FontWeight.w600,
      onTaps: () async {
        // Set _isSubmitting to true when the button is pressed
        setState(() {
          _isSubmitting = true;
        });

        try {

          if (taskNameController.text.isEmpty || taskDeadlineController.text.isEmpty) {
            // Show an alert dialog if either taskName or taskDeadline is empty
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Uyarı"),
                  content: Text("Görev adı ve bitiş tarihi boş olamaz."),
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
            return; // Exit the function if either field is empty
          }

          // Wait for the completion of addIncompleteTaskToDatabase
          await addIncompleteTaskToDatabase(
            "${constUrl}api/TamamlanmamisGorev",
            taskNameController.text,
            taskDescriptionController.text.isEmpty ? null : taskDescriptionController.text,
            now.day.toString() + "-" + now.month.toString() + "-" + now.year.toString(),
            taskDeadlineController.text,
            null,
            (inPlace == true) ? "Yerinde" : "Uzaktan",
            null,
            groupNo,
            "${constUrl}api/TamamlanmamisGorev",
            "${constUrl}api/Fotograf",
            (isBS) ? userID : null,
            (isBS == false && isBSorPM == true) ? userID : null,
            (isBSorPM == false) ? userID : null,
            (inPlace == true) ? "Yerinde" : "Uzaktan",
            "${constUrl}api/Fotograf",
          );

          // Show the success dialog when the task is successfully submitted
          Future.delayed(Duration.zero, () {
            showTaskSubmittedDialog(context);
          });
        } finally {
          // Set _isSubmitting to false after addIncompleteTaskToDatabase is completed
          setState(() {
            _isSubmitting = false;
          });
        }
      },
      borderWidht: 1,
      backgroundColor: secondaryColor,
      borderColor: secondaryColor,
      textColor: textColor,
    );
  }


  Widget shopSelectionButton(){
    return ButtonWidget(text: "Mağaza Seçimi", heightConst: 0.06, widthConst: 0.8, size: 18, radius: 20, fontWeight: FontWeight.w600, onTaps: (){naviSubmitTaskShopPhotoSelectionScreen(context);}, borderWidht: 3, backgroundColor: primaryColor, borderColor: primaryColor, textColor: textColor);
  }

  Widget showAddedPhotoButton(){
    return ButtonWidget(text: "Eklenen Fotoğrafları Gör", heightConst: 0.06, widthConst: 0.8, size: 18, radius: 20, fontWeight: FontWeight.w600, onTaps: (){naviTaskPhotoGalleryView(context, taskPhotos);}, borderWidht: 3, backgroundColor: primaryColor, borderColor: primaryColor, textColor: textColor);
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
            TextFormFieldWidget(text: "Görev Adı", borderWidht: 2, titleColor: textColor, borderColor: Colors.black, controller: taskNameController, value: SubmitTaskMainScreen.taskName, paddingValue: 5,maxLines: 1,maxLength: 50,controllerString: taskNameController.text),
            SizedBox(height: deviceHeight*0.03,),
            TextFormFieldDatePicker(text: "Görev Bitiş Tarihi", borderWidht: 2, titleColor: textColor, borderColor: Colors.black, dateController: taskDeadlineController, value: SubmitTaskMainScreen.taskDeadline, paddingValue: 5,maxLines: 1),
            SizedBox(height: deviceHeight*0.03,),
            TextFormFieldWidget(text: "Görev Detayı", borderWidht: 2, titleColor: textColor, borderColor: Colors.black, controller: taskDescriptionController, value: SubmitTaskMainScreen.taskDescription, paddingValue: 5,maxLines: 8,maxLength: 250,controllerString: taskDescriptionController.text),
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
          TextWidget(text: "Yerinde yada Uzaktan?", size: 20, fontWeight: FontWeight.w600, color: textColor),
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
                  TextWidget(text: "Yerinde", size: 20, fontWeight: FontWeight.w400, color: textColor),
                  Checkbox(value: inPlace, onChanged: (newvalue){setState(() {inPlace=newvalue!;remote=!newvalue;});})
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextWidget(text: "Uzaktan", size: 20, fontWeight: FontWeight.w400, color: textColor),
                  Checkbox(value: remote, onChanged: (newvalue){setState(() {remote=newvalue!;inPlace=!newvalue;});})
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  showTaskSubmittedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialogWidget(
          title: 'Görev Atandı',
          content: 'Görev başarıyla atandı!',
          onTaps: (){
            createShopTaskPhotoMap();
            resetTaskPhotos();
            naviSubmitTaskMainScreen(context);
          },
        );
      },
    );
  }

}
