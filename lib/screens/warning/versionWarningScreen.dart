import 'package:deneme/styles/styleConst.dart';
import 'package:deneme/widgets/text_widget.dart';
import 'package:flutter/material.dart';

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
            SizedBox(height: deviceHeight*0.25,),
            versionInfo(),
          ],
        ),
      );
    });
  }


  Widget versionInfo(){
    return TextWidget(
        text:"Uygulama güncel değil, lütfen uygulamanızı güncelleyin.",
        size: 30,
        fontWeight: FontWeight.w400,
        color: textColor
    );
  }

}

