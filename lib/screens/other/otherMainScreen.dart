import 'package:deneme/constants/constants.dart';
import 'package:deneme/routing/bottomNavigationBar.dart';
import 'package:deneme/services/cashCountingServices.dart';
import 'package:deneme/services/shopClosingControlServices.dart';
import 'package:deneme/services/shopOpeningControlServices.dart';
import 'package:deneme/styles/styleConst.dart';
import 'package:deneme/utils/generalFunctions.dart';
import 'package:deneme/utils/logoutFunctions.dart';
import 'package:deneme/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import '../../constants/bottomNaviBarLists.dart';
import '../../constants/pagesLists.dart';

class OtherMainScreen extends StatefulWidget {
  const OtherMainScreen({super.key});

  @override
  State<OtherMainScreen> createState() =>
      _OtherMainScreenState();
}

class _OtherMainScreenState extends State<OtherMainScreen> {

  int _selectedIndex = 4;

  List<BottomNavigationBarItem> naviBarList = [];
  List<Widget> pageList = [];

  late double deviceHeight;
  late double deviceWidth;

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
        _selectedIndex = 4;
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
        _selectedIndex = 5;
      }
      if(user=="BM" || user=="GK"){
        naviBarList = itemListBMandGK;
        pageList = pagesBMGK;
        _selectedIndex = 4;
      }
      if(user=="NK"){
        naviBarList = itemListNK;
        pageList = pagesNK;
        _selectedIndex = 2;
      }
    }

    userCondition(userType);

    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          foregroundColor: appbarForeground,
          backgroundColor: appbarBackground,
          title: const Text('Diğer'),
        ),
        body: PopScope(
          canPop: false,
          onPopInvoked: (bool didPop) {},
          child:SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(0, deviceWidth*0.1, 0, 0),
            child:Container(
              alignment: Alignment.center,
              child: otherMainScreenUI(),
            ),
          )
        ),
        bottomNavigationBar: BottomNaviBar(selectedIndex: _selectedIndex,itemList: naviBarList,pageList: pageList,)
    );
  }

  Widget otherMainScreenUI(){
    return Builder(builder: (BuildContext context){
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            (isBS == true)?SizedBox(height: deviceHeight*0.03,):SizedBox(height: deviceHeight*0.00,),
            (isBS == true)?getReportButton1():SizedBox(height: deviceHeight*0.00,),
            (isBS == true)?SizedBox(height: deviceHeight*0.03,):SizedBox(height: deviceHeight*0.00,),
            (isBS == true)?getReportButton2():SizedBox(height: deviceHeight*0.00,),
            (isBS == true)?SizedBox(height: deviceHeight*0.03,):SizedBox(height: deviceHeight*0.00,),
            (isBS == true)?getReportButton3():SizedBox(height: deviceHeight*0.00,),
            (isBS == true)?SizedBox(height: deviceHeight*0.03,):SizedBox(height: deviceHeight*0.00,),
            (isBS == true)?getReportButton4():SizedBox(height: deviceHeight*0.00,),
            (isBS == true)?SizedBox(height: deviceHeight*0.03,):SizedBox(height: deviceHeight*0.00,),
            (isBS == true)?getReportButton5():SizedBox(height: deviceHeight*0.00,),
            (isBS == true)?SizedBox(height: deviceHeight*0.03,):SizedBox(height: deviceHeight*0.00,),
            (isBS == true)?getReportButton6():SizedBox(height: deviceHeight*0.00,),
            SizedBox(height: deviceHeight*0.03,),
            logoutButton()
          ],
        ),
      );
    });
  }



  Widget logoutButton(){
    return ButtonWidget(text: "Çıkış yap", heightConst: 0.06, widthConst: 0.8, size: 18, radius: 20, fontWeight: FontWeight.w600, onTaps: (){logout(context);}, borderWidht: 1, backgroundColor: redColor, borderColor: redColor, textColor: textColor);
  }

  Widget getReportButton1(){
    return ButtonWidget(
        text: "Mağaza İçi Açılış Formu Raporu",
        heightConst: 0.06,
        widthConst: 0.8,
        size: 18,
        radius: 20,
        fontWeight: FontWeight.w600,
        onTaps: (){
          downloadInShopOpenControlReport("${constUrl}api/AcilisKontroluMagazaIci/excelReport?${urlShopFilter}");
        },
        borderWidht: 1,
        backgroundColor: secondaryColor,
        borderColor: secondaryColor,
        textColor: textColor
    );
  }

  Widget getReportButton2(){
    return ButtonWidget(
        text: "Mağaza Dışı Açılış Formu Raporu",
        heightConst: 0.06,
        widthConst: 0.8,
        size: 18,
        radius: 20,
        fontWeight: FontWeight.w600,
        onTaps: (){
          downloadOutShopOpenControlReport("${constUrl}api/AcilisKontroluMagazaDisi/excelReport?${urlShopFilter}");
        },
        borderWidht: 1,
        backgroundColor: secondaryColor,
        borderColor: secondaryColor,
        textColor: textColor
    );
  }

  Widget getReportButton3(){
    return ButtonWidget(
        text: "Mağaza İçi Kapanış Formu Raporu",
        heightConst: 0.06,
        widthConst: 0.8,
        size: 18,
        radius: 20,
        fontWeight: FontWeight.w600,
        onTaps: (){
          downloadInShopCloseControlReport("${constUrl}api/KapanisKontroluMagazaIci/excelReport?${urlShopFilter}");
        },
        borderWidht: 1,
        backgroundColor: secondaryColor,
        borderColor: secondaryColor,
        textColor: textColor
    );
  }

  Widget getReportButton4(){
    return ButtonWidget(
        text: "Mağaza Dışı Kapanış Formu Raporu",
        heightConst: 0.06,
        widthConst: 0.8,
        size: 18,
        radius: 20,
        fontWeight: FontWeight.w600,
        onTaps: (){
          downloadOutShopCloseControlReport("${constUrl}api/KapanisKontroluMagazaDisi/excelReport?${urlShopFilter}");
        },
        borderWidht: 1,
        backgroundColor: secondaryColor,
        borderColor: secondaryColor,
        textColor: textColor
    );
  }

  Widget getReportButton5(){
    return ButtonWidget(
        text: "Çelik Kasa Sayımı Formu Raporu",
        heightConst: 0.06,
        widthConst: 0.8,
        size: 18,
        radius: 20,
        fontWeight: FontWeight.w600,
        onTaps: (){
          downloadCashCountingReport("${constUrl}api/CelikKasaSayimi/excelReport?${urlShopFilter}");
        },
        borderWidht: 1,
        backgroundColor: secondaryColor,
        borderColor: secondaryColor,
        textColor: textColor
    );
  }

  Widget getReportButton6(){
    return ButtonWidget(
        text: "Mesai Raporu",
        heightConst: 0.06,
        widthConst: 0.8,
        size: 18,
        radius: 20,
        fontWeight: FontWeight.w600,
        onTaps: (){
          showAlertDialogWidget(context, "Uyarı!", "Şu an bu rapor aktif değildir. Bir sonraki güncellemede aktif hale gelecektir.", (){Navigator.of(context).pop();});
        },
        borderWidht: 1,
        backgroundColor: secondaryColor,
        borderColor: secondaryColor,
        textColor: textColor
    );
  }
}


