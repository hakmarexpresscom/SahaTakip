import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:deneme/constants/constants.dart';
import 'package:deneme/routing/bottomNavigationBar.dart';
import 'package:deneme/styles/styleConst.dart';
import 'package:deneme/utils/generalFunctions.dart';
import 'package:deneme/widgets/button_widget.dart';
import 'package:deneme/widgets/textFormFieldDatePicker.dart';
import 'package:deneme/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import '../../constants/bottomNaviBarLists.dart';
import '../../constants/pagesLists.dart';
import '../../main.dart';
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
        if(isStartShiftObs.value==false&&isRegionCenterVisitInProgress.value==false){
          pageList = pagesBS;
        }
        else if(isStartShiftObs.value&&isRegionCenterVisitInProgress.value==false){
          pageList = pagesBS2;
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

  Widget submitTaskMainScreenUI() {
    return Builder(builder: (BuildContext context) {
      return Container(
        child: Column(
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
            submitTaskButton(context),
            SizedBox(height: deviceHeight * 0.03,),
          ],
        ),
      );
    });
  }


  Widget submitTaskButton(BuildContext context) {
    return ButtonWidget(
      text: "Görevi Ata",
      heightConst: 0.06,
      widthConst: 0.8,
      size: 18,
      radius: 20,
      fontWeight: FontWeight.w600,
      onTaps: () async {

        print(inPlace);
        print(remote);

        var connectivityResult = await (Connectivity().checkConnectivity());
        List<dynamic> firstIndexValues = boxShopTaskPhoto.values.map((value) => value[1]).toList();

        if (taskNameController.text.isEmpty || taskDeadlineController.text.isEmpty) {
          showAlertDialogWidget(context, 'Uyarı', "Görev adı ve bitiş tarihi boş olamaz. Lütfen görev adınız yazınız ve görev bitiş tarihi seçiniz.", (){Navigator.of(context).pop();});
        }

        if (!firstIndexValues.contains(true)) {
          showAlertDialogWidget(context, 'Uyarı', "Mağaza seçmediniz. Lüfen mağaza seçimi butonunu kullanarak mağaza seçiniz.", (){Navigator.of(context).pop();});
        }

        if (inPlace == false && remote == false) {
          showAlertDialogWidget(context, 'Uyarı', "Görev türünü seçmediniz. Lüfen Yerinde ya da Uzaktan kutucuklarından birini işaretleyiniz.", (){Navigator.of(context).pop();});
        }

        if(connectivityResult[0] == ConnectivityResult.none){
          showAlertDialogWidget(context, 'Internet Bağlantı Hatası', 'Telefonunuzun internet bağlantısı bulunmamaktadır. Lütfen telefonunuzu internete bağlayınız.', (){Navigator.of(context).pop();});
        }

        else if(taskNameController.text.isNotEmpty && taskDeadlineController.text.isNotEmpty && firstIndexValues.contains(true) && (inPlace == true || remote == true) && connectivityResult[0] != ConnectivityResult.none){

          showAlertDialogWithoutButtonWidget(context,"Görev Atanıyor","Göreviniz atanıyor, lütfen bekleyiniz.");

          await addIncompleteTaskToDatabase(
            "${constUrl}api/TamamlanmamisGorev",
            taskNameController.text,
            taskDescriptionController.text.isEmpty ? null : taskDescriptionController.text,
            now.day.toString() + "-" + now.month.toString() + "-" + now.year.toString(),
            taskDeadlineController.text,
            null,
            (inPlace == true && remote == false) ? "Yerinde" : "Uzaktan",
            null,
            groupNo,
            "${constUrl}api/TamamlanmamisGorev",
            "${constUrl}api/Fotograf",
            (isBS) ? userID : null,
            (isBS == false && isBSorPM == true) ? userID : null,
            (isBSorPM == false) ? userID : null,
            (inPlace == true && remote == false) ? "Yerinde" : "Uzaktan",
            "${constUrl}api/Fotograf",
          );

          Navigator.of(context).pop(); // Close the dialog
          showAlertDialogWidget(context, 'Görev Atandı', 'Görev başarıyla atandı!', (){createShopTaskPhotoMap(groupNo);resetTaskPhotos();naviSubmitTaskMainScreen(context);});
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
            TextFormFieldWidget(text: "Görev Adı", borderWidht: 2, titleColor: textColor, borderColor: Colors.black, controller: taskNameController, value: SubmitTaskMainScreen.taskName, paddingValue: 5,maxLines: 1,maxLength: 50,controllerString: taskNameController.text, enabled: true,),
            SizedBox(height: deviceHeight*0.02,),
            TextFormFieldDatePicker(text: "Görev Bitiş Tarihi", borderWidht: 2, titleColor: textColor, borderColor: Colors.black, dateController: taskDeadlineController, value: SubmitTaskMainScreen.taskDeadline, paddingValue: 5,maxLines: 1),
            SizedBox(height: deviceHeight*0.02,),
            TextFormFieldWidget(text: "Görev Detayı", borderWidht: 2, titleColor: textColor, borderColor: Colors.black, controller: taskDescriptionController, value: SubmitTaskMainScreen.taskDescription, paddingValue: 5,maxLines: 8,maxLength: 500,controllerString: taskDescriptionController.text, enabled: true,),
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

}
