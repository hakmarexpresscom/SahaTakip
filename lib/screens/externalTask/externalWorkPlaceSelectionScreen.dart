import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../constants/bottomNaviBarLists.dart';
import '../../constants/constants.dart';
import '../../constants/pagesLists.dart';
import '../../models/center.dart';
import '../../routing/bottomNavigationBar.dart';
import '../../services/centerServices.dart';
import '../../styles/styleConst.dart';
import '../../widgets/text_form_field.dart';

class PlaceSelectionScreen extends StatefulWidget {

  const PlaceSelectionScreen({super.key});

  @override
  State<PlaceSelectionScreen> createState() => _PlaceSelectionScreenState();
}

class _PlaceSelectionScreenState extends State<PlaceSelectionScreen> with TickerProviderStateMixin {

  String selectedOption = '';

  late Future<List<RegionCenter>> futureRegionCenter;

  int _selectedIndex = 0;

  List<BottomNavigationBarItem> naviBarList = [];
  List<Widget> pageList = [];

  late double deviceHeight;
  late double deviceWidth;

  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    futureRegionCenter = fetchRegionCenter('${constUrl}api/BolgeMerkezleri');
    controller = AnimationController(
      /// [AnimationController]s can be created with `vsync: this` because of
      /// [TickerProviderStateMixin].
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
      //setState(() {});
    });
    controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose(); // AnimationController'ı temizle
    super.dispose();
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
          title: const Text('Yer Seçimi'),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RadioListTile(
                title: Text('Tepeören Bölge Merkez'),
                value: 'Tepeören Bölge Merkez',
                groupValue: workPlace,
                onChanged: (value) {
                  setState(() {
                    selectedOption = value.toString();
                    workPlace = selectedOption;
                    workPlace2 = selectedOption;
                    showOtherTextField = false;
                  });
                },
              ),
              RadioListTile(
                title: Text('Sancaktepe Bölge Merkez'),
                value: 'Sancaktepe Bölge Merkez',
                groupValue: workPlace,
                onChanged: (value) {
                  setState(() {
                    selectedOption = value.toString();
                    workPlace = selectedOption;
                    workPlace2 = selectedOption;
                    showOtherTextField = false;
                  });
                },
              ),
              RadioListTile(
                title: Text('Gebze Bölge Merkez'),
                value: 'Gebze Bölge Merkez',
                groupValue: workPlace,
                onChanged: (value) {
                  setState(() {
                    selectedOption = value.toString();
                    workPlace = selectedOption;
                    workPlace2 = selectedOption;
                    showOtherTextField = false;
                  });
                },
              ),
              RadioListTile(
                title: Text('Kurtköy Bölge Merkez'),
                value: 'Kurtköye Bölge Merkez',
                groupValue: workPlace,
                onChanged: (value) {
                  setState(() {
                    selectedOption = value.toString();
                    workPlace = selectedOption;
                    workPlace2 = selectedOption;
                    showOtherTextField = false;
                  });
                },
              ),
              RadioListTile(
                title: Text('Sakarya Bölge Merkez'),
                value: 'Sakarya Bölge Merkez',
                groupValue: workPlace,
                onChanged: (value) {
                  setState(() {
                    selectedOption = value.toString();
                    workPlace = selectedOption;
                    workPlace2 = selectedOption;
                    showOtherTextField = false;
                  });
                },
              ),
              RadioListTile(
                title: Text('Kartepe Bölge Merkez'),
                value: 'Kartepe Bölge Merkez',
                groupValue: workPlace,
                onChanged: (value) {
                  setState(() {
                    selectedOption = value.toString();
                    workPlace = selectedOption;
                    workPlace2 = selectedOption;
                    showOtherTextField = false;
                  });
                },
              ),
              RadioListTile(
                title: Text('Diğer'),
                value: 'Diğer',
                groupValue: workPlace,
                onChanged: (value) {
                  setState(() {
                    selectedOption = value.toString();
                    workPlace = selectedOption;
                    showOtherTextField = true;
                  });
                },
              ),
              if (showOtherTextField)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormFieldWidget(
                      text: "Yer İsmi Giriniz",
                      borderWidht: 2,
                      titleColor: textColor,
                      borderColor: textColor,
                      controller: workPlaceTextFieldController,
                      value: workPlace2,
                      paddingValue: 5,
                      maxLines: 1,
                      maxLength: 50,
                      controllerString: workPlaceTextFieldController.text
                  ),
                ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNaviBar(selectedIndex: _selectedIndex,itemList: naviBarList,pageList: pageList,)
    );
  }

}

