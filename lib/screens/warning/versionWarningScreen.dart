import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:deneme/styles/styleConst.dart';
import 'package:deneme/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import '../../utils/generalFunctions.dart';
import '../../widgets/button_widget.dart';

class VersionWarningScreen extends StatefulWidget {

  const VersionWarningScreen({super.key});

  @override
  State<VersionWarningScreen> createState() =>
      _VersionWarningScreenState();
}

class _VersionWarningScreenState extends State<VersionWarningScreen> {

  late double deviceHeight;
  late double deviceWidth;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          foregroundColor: appbarForeground,
          backgroundColor: appbarBackground,
          title: const Text('Versiyon Uyarı Ekranı'),
        ),
        body: PopScope(
            canPop: false,
            onPopInvoked: (bool didPop) {},
            child:SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child:Container(
                alignment: Alignment.center,
                child: versionWarningScreenUI(),
              ),
            )
        ),
    );
  }

  Widget versionWarningScreenUI(){
    return Builder(builder: (BuildContext context){
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: deviceHeight*0.2,),
            versionInfo(),
            SizedBox(height: deviceHeight*0.05,),
            updateAppButton(),
          ],
        ),
      );
    });
  }


  Widget versionInfo(){
    return TextWidget(
        text:"Uygulama güncel değil, lütfen aşağıdaki butona basarak uygulamamızın güncelleme sayfasına gidiniz ve uygulamanızı güncelleyiniz.",
        size: 20,
        fontWeight: FontWeight.w400,
        color: textColor
    );
  }

  Widget updateAppButton(){
    return ButtonWidget(
        text: "Uygulamayı Güncelle",
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
            openUpdatePage();
          }
        },
        borderWidht: 1,
        backgroundColor: secondaryColor,
        borderColor: secondaryColor,
        textColor: textColor
    );
  }

}

