import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:deneme/constants/constants.dart';
import 'package:deneme/routing/bottomNavigationBar.dart';
import 'package:deneme/routing/landing.dart';
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
import '../../main.dart';
import '../../services/visitingDurationsServices.dart';

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
      if(user=="BS" && box.get("groupNo") == 3){
        naviBarList = itemListTZ;
        if(isStartShiftObs.value==false&&isRegionCenterVisitInProgress.value==false){
          pageList = pagesTZ;
        }
        else if(isStartShiftObs.value&&isRegionCenterVisitInProgress.value==false){
          pageList = pagesTZ2;
        }
        _selectedIndex = 3;
      }
      else if(user=="BS"){
        naviBarList = itemListBS;
        if(isStartShiftObs.value==false&&isRegionCenterVisitInProgress.value==false){
          pageList = pagesBS;
        }
        else if(isStartShiftObs.value&&isRegionCenterVisitInProgress.value==false){
          pageList = pagesBS2;
        }
        _selectedIndex = 4;
      }
      else if(user=="PM"){
        naviBarList = itemListPM;
        if(isStartShiftObs.value==false&&isRegionCenterVisitInProgress.value==false){
          pageList = pagesPM;
        }
        else if(isStartShiftObs.value&&isRegionCenterVisitInProgress.value==false){
          pageList = pagesPM2;
        }
        _selectedIndex = 5;
      }
      else if(user=="BM" || user=="GK"){
        naviBarList = itemListBMandGK;
        pageList = pagesBMGK;
        _selectedIndex = 4;
      }
      else if(user=="NK"){
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
            (isBS == true && groupNo == 0)?SizedBox(height: deviceHeight*0.03,):SizedBox(height: deviceHeight*0.00,),
            (isBS == true && groupNo == 0)?getReportButton1(context):SizedBox(height: deviceHeight*0.00,),
            (isBS == true && groupNo == 0)?SizedBox(height: deviceHeight*0.03,):SizedBox(height: deviceHeight*0.00,),
            (isBS == true && groupNo == 0)?getReportButton2(context):SizedBox(height: deviceHeight*0.00,),
            (isBS == true && groupNo == 0)?SizedBox(height: deviceHeight*0.03,):SizedBox(height: deviceHeight*0.00,),
            (isBS == true && groupNo == 0)?getReportButton3(context):SizedBox(height: deviceHeight*0.00,),
            (isBS == true && groupNo == 0)?SizedBox(height: deviceHeight*0.03,):SizedBox(height: deviceHeight*0.00,),
            (isBS == true && groupNo == 0)?getReportButton4(context):SizedBox(height: deviceHeight*0.00,),
            (isBS == true && groupNo == 0)?SizedBox(height: deviceHeight*0.03,):SizedBox(height: deviceHeight*0.00,),
            (isBS == true && groupNo == 0)?getReportButton5(context):SizedBox(height: deviceHeight*0.00,),
            (isBS == true)?SizedBox(height: deviceHeight*0.03,):SizedBox(height: deviceHeight*0.00,),
            (isBS == true)?getReportButton6(context):SizedBox(height: deviceHeight*0.00,),
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

  Widget getReportButton1(BuildContext context){
    return ButtonWidget(
        text: "Mağaza İçi Açılış Formu Raporu",
        heightConst: 0.06,
        widthConst: 0.8,
        size: 18,
        radius: 20,
        fontWeight: FontWeight.w600,
        onTaps: () async{

          var connectivityResult = await (Connectivity().checkConnectivity());

          if(connectivityResult[0] == ConnectivityResult.none){
            showAlertDialogWidget(context, 'Internet Bağlantı Hatası', 'Telefonunuzun internet bağlantısı bulunmamaktadır. Lütfen telefonunuzu internete bağlayınız.', (){Navigator.of(context).pop();});
          }

          else if(connectivityResult[0] != ConnectivityResult.none) {

            showAlertDialogWithoutButtonWidget(context, "Rapor İndiriliyor", "Raporunuz indiriliyor, lütfen bekleyiniz.");

            try {

              await downloadInShopOpenControlReport("${constUrl}api/AcilisKontroluMagazaIci/excelReport?${urlTaskShops}");

              Navigator.of(context).pop(); // Close the dialog
              showAlertDialogWidget(context, 'Rapor İndirildi!', 'Raporunuz telefonunuzun dosyalarım uygulamasındaki indirilenler bölümüne indirilmiştir.', () {naviOtherMainScreen(context);});

            } catch (error) {

              Navigator.of(context).pop(); // Close the dialog
              showAlertDialogWidget(context, 'Hata!', 'Rapor indirilemedi: $error', () {naviOtherMainScreen(context);});

            }
          }
        },
        borderWidht: 1,
        backgroundColor: secondaryColor,
        borderColor: secondaryColor,
        textColor: textColor
    );
  }

  Widget getReportButton2(BuildContext context){
    return ButtonWidget(
        text: "Mağaza Dışı Açılış Formu Raporu",
        heightConst: 0.06,
        widthConst: 0.8,
        size: 18,
        radius: 20,
        fontWeight: FontWeight.w600,
        onTaps: () async{
          var connectivityResult = await (Connectivity().checkConnectivity());

          if(connectivityResult[0] == ConnectivityResult.none){
            showAlertDialogWidget(context, 'Internet Bağlantı Hatası', 'Telefonunuzun internet bağlantısı bulunmamaktadır. Lütfen telefonunuzu internete bağlayınız.', (){Navigator.of(context).pop();});
          }

          else if(connectivityResult[0] != ConnectivityResult.none) {

            showAlertDialogWithoutButtonWidget(context, "Rapor İndiriliyor", "Raporunuz indiriliyor, lütfen bekleyiniz.");

            try {

              await downloadOutShopOpenControlReport("${constUrl}api/AcilisKontroluMagazaDisi/excelReport?${urlTaskShops}");

              Navigator.of(context).pop(); // Close the dialog
              showAlertDialogWidget(context, 'Rapor İndirildi!', 'Raporunuz telefonunuzun dosyalarım uygulamasındaki indirilenler bölümüne indirilmiştir.', () {naviOtherMainScreen(context);});

            } catch (error) {

              Navigator.of(context).pop(); // Close the dialog
              showAlertDialogWidget(context, 'Hata!', 'Rapor indirilemedi: $error', () {naviOtherMainScreen(context);});

            }
          }
        },
        borderWidht: 1,
        backgroundColor: secondaryColor,
        borderColor: secondaryColor,
        textColor: textColor
    );
  }

  Widget getReportButton3(BuildContext context){
    return ButtonWidget(
        text: "Mağaza İçi Kapanış Formu Raporu",
        heightConst: 0.06,
        widthConst: 0.8,
        size: 18,
        radius: 20,
        fontWeight: FontWeight.w600,
        onTaps: () async{
          var connectivityResult = await (Connectivity().checkConnectivity());

          if(connectivityResult[0] == ConnectivityResult.none){
            showAlertDialogWidget(context, 'Internet Bağlantı Hatası', 'Telefonunuzun internet bağlantısı bulunmamaktadır. Lütfen telefonunuzu internete bağlayınız.', (){Navigator.of(context).pop();});
          }

          else if(connectivityResult[0] != ConnectivityResult.none) {

            showAlertDialogWithoutButtonWidget(context, "Rapor İndiriliyor", "Raporunuz indiriliyor, lütfen bekleyiniz.");

            try {

              await downloadInShopCloseControlReport("${constUrl}api/KapanisKontroluMagazaIci/excelReport?${urlTaskShops}");

              Navigator.of(context).pop(); // Close the dialog
              showAlertDialogWidget(context, 'Rapor İndirildi!', 'Raporunuz telefonunuzun dosyalarım uygulamasındaki indirilenler bölümüne indirilmiştir.', () {naviOtherMainScreen(context);});

            } catch (error) {

              Navigator.of(context).pop(); // Close the dialog
              showAlertDialogWidget(context, 'Hata!', 'Rapor indirilemedi: $error', () {naviOtherMainScreen(context);});

            }
          }
        },
        borderWidht: 1,
        backgroundColor: secondaryColor,
        borderColor: secondaryColor,
        textColor: textColor
    );
  }

  Widget getReportButton4(BuildContext context){
    return ButtonWidget(
        text: "Mağaza Dışı Kapanış Formu Raporu",
        heightConst: 0.06,
        widthConst: 0.8,
        size: 18,
        radius: 20,
        fontWeight: FontWeight.w600,
        onTaps: () async{
          var connectivityResult = await (Connectivity().checkConnectivity());

          if(connectivityResult[0] == ConnectivityResult.none){
            showAlertDialogWidget(context, 'Internet Bağlantı Hatası', 'Telefonunuzun internet bağlantısı bulunmamaktadır. Lütfen telefonunuzu internete bağlayınız.', (){Navigator.of(context).pop();});
          }

          else if(connectivityResult[0] != ConnectivityResult.none) {

            showAlertDialogWithoutButtonWidget(context, "Rapor İndiriliyor", "Raporunuz indiriliyor, lütfen bekleyiniz.");

            try {

              await downloadOutShopCloseControlReport("${constUrl}api/KapanisKontroluMagazaDisi/excelReport?${urlTaskShops}");

              Navigator.of(context).pop(); // Close the dialog
              showAlertDialogWidget(context, 'Rapor İndirildi!', 'Raporunuz telefonunuzun dosyalarım uygulamasındaki indirilenler bölümüne indirilmiştir.', () {naviOtherMainScreen(context);});

            } catch (error) {

              Navigator.of(context).pop(); // Close the dialog
              showAlertDialogWidget(context, 'Hata!', 'Rapor indirilemedi: $error', () {naviOtherMainScreen(context);});

            }
          }
        },
        borderWidht: 1,
        backgroundColor: secondaryColor,
        borderColor: secondaryColor,
        textColor: textColor
    );
  }

  Widget getReportButton5(BuildContext context){
    return ButtonWidget(
        text: "Çelik Kasa Sayımı Formu Raporu",
        heightConst: 0.06,
        widthConst: 0.8,
        size: 18,
        radius: 20,
        fontWeight: FontWeight.w600,
        onTaps: () async{
          var connectivityResult = await (Connectivity().checkConnectivity());

          if(connectivityResult[0] == ConnectivityResult.none){
            showAlertDialogWidget(context, 'Internet Bağlantı Hatası', 'Telefonunuzun internet bağlantısı bulunmamaktadır. Lütfen telefonunuzu internete bağlayınız.', (){Navigator.of(context).pop();});
          }

          else if(connectivityResult[0] != ConnectivityResult.none) {

            showAlertDialogWithoutButtonWidget(context, "Rapor İndiriliyor", "Raporunuz indiriliyor, lütfen bekleyiniz.");

            try {

              await downloadCashCountingReport("${constUrl}api/CelikKasaSayimi/excelReport?${urlTaskShops}");

              Navigator.of(context).pop(); // Close the dialog
              showAlertDialogWidget(context, 'Rapor İndirildi!', 'Raporunuz telefonunuzun dosyalarım uygulamasındaki indirilenler bölümüne indirilmiştir.', () {naviOtherMainScreen(context);});

            } catch (error) {

              Navigator.of(context).pop(); // Close the dialog
              showAlertDialogWidget(context, 'Hata!', 'Rapor indirilemedi: $error', () {naviOtherMainScreen(context);});

            }
          }
        },
        borderWidht: 1,
        backgroundColor: secondaryColor,
        borderColor: secondaryColor,
        textColor: textColor
    );
  }


  Widget getReportButton6(BuildContext context){
    return ButtonWidget(
        text: "Mesai Raporu",
        heightConst: 0.06,
        widthConst: 0.8,
        size: 18,
        radius: 20,
        fontWeight: FontWeight.w600,
        onTaps: () async{
          var connectivityResult = await (Connectivity().checkConnectivity());

          if(connectivityResult[0] == ConnectivityResult.none){
            showAlertDialogWidget(context, 'Internet Bağlantı Hatası', 'Telefonunuzun internet bağlantısı bulunmamaktadır. Lütfen telefonunuzu internete bağlayınız.', (){Navigator.of(context).pop();});
          }

          else if(connectivityResult[0] != ConnectivityResult.none) {
            showAlertDialogWithoutButtonWidget(context, "Rapor İndiriliyor", "Raporunuz indiriliyor, lütfen bekleyiniz.");

            try {

              await downloadVisitingReport("${constUrl}api/ZiyaretSureleri/excelReport?${urlTaskShops}&bs_id=${userID}");

              Navigator.of(context).pop(); // Close the dialog
              showAlertDialogWidget(context, 'Rapor İndirildi!', 'Raporunuz telefonunuzun dosyalarım uygulamasındaki indirilenler bölümüne indirilmiştir.', () {naviOtherMainScreen(context);});

            } catch (error) {

              Navigator.of(context).pop(); // Close the dialog
              showAlertDialogWidget(context, 'Hata!', 'Rapor indirilemedi: $error', () {naviOtherMainScreen(context);});

            }
          }
        },
        borderWidht: 1,
        backgroundColor: secondaryColor,
        borderColor: secondaryColor,
        textColor: textColor
    );
  }
}


