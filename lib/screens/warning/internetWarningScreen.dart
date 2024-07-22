import 'package:deneme/styles/styleConst.dart';
import 'package:deneme/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class InternetWarningScreen extends StatefulWidget {

  const InternetWarningScreen({super.key});

  @override
  State<InternetWarningScreen> createState() =>
      _InternetWarningScreenState();
}

class _InternetWarningScreenState extends State<InternetWarningScreen> {

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
        title: const Text('Internet Uyarı Ekranı'),
      ),
      body: PopScope(
          canPop: false,
          onPopInvoked: (bool didPop) {},
          child:SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child:Container(
              alignment: Alignment.center,
              child: internetWarningScreenUI(),
            ),
          )
      ),
    );
  }

  Widget internetWarningScreenUI(){
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
        text:"Internete bağlı değilsiniz. Lütfen telefonunuzu internete bağlayınız.",
        size: 30,
        fontWeight: FontWeight.w400,
        color: textColor
    );
  }

}

