import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:deneme/styles/styleConst.dart';
import 'package:deneme/utils/forgetPasswordFunctions.dart';
import 'package:deneme/widgets/button_widget.dart';
import 'package:deneme/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import '../../../constants/constants.dart';
import '../../../routing/landing.dart';
import '../../../utils/generalFunctions.dart';

class ForgetPasswordScreen extends StatefulWidget {

  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() =>
      _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {

  final emailController = TextEditingController();

  String item = userTypeList[0];

  late double deviceHeight;
  late double deviceWidth;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;


    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) {},
        child:LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints){
            if(350<constraints.maxWidth && constraints.maxWidth<420 && deviceHeight<800){
              return SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child:Container(
                    alignment: Alignment.center,
                    child: loginMainScreenUI(0.06,0.8)
                ),
              );
            }
            else if(651<constraints.maxWidth && constraints.maxWidth<1000){
              return ((deviceHeight-deviceWidth)<150) ? SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child:Container(
                    alignment: Alignment.center,
                    child: loginMainScreenUI(0.06,0.7)
                ),
              ) : SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child:Container(
                    alignment: Alignment.center,
                    child: loginMainScreenUI(0.05,0.7)
                ),
              );
            }
            else if(deviceHeight>800 || (421<constraints.maxWidth && constraints.maxWidth<650)){
              return SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child:Container(
                    alignment: Alignment.center,
                    child: loginMainScreenUI(0.06,0.8)
                ),
              );
            }
            else{
              return Container();
            }
          },
        )
      ),
    );
  }

  Widget loginMainScreenUI(double heightConst, double widthConst){
    return Builder(builder: (BuildContext context){
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: deviceHeight*0.03,),
            logo(),
            SizedBox(height: deviceHeight*0.01,),
            title(),
            SizedBox(height: deviceHeight*0.04,),
            userTypeTitle(),
            SizedBox(height: deviceHeight*0.02,),
            userTypeDropDown(),
            SizedBox(height: deviceHeight*0.03,),
            info(),
            SizedBox(height: deviceHeight*0.03,),
            inputForm(context,heightConst, widthConst),
            SizedBox(height: deviceHeight*0.03,),
            backLoginScreenButton(heightConst, widthConst),
          ],
        ),
      );
    });
  }

  Widget inputForm(BuildContext context, double heightConst, double widthConst){
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
            TextFormField(
              maxLines: 1,
              autocorrect: false,
              onSaved: (input){
                setState((){
                  email = input!;
                });
              },
              controller: emailController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(5),
                border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2)),
                hintText: "Email",
              ),
            ),
            SizedBox(height: deviceHeight*0.03,),
            ButtonWidget(
                text: "Şifremi Yolla",
                heightConst: heightConst,
                widthConst: widthConst,
                size: 18,
                radius: 20,
                fontWeight: FontWeight.w600,
                onTaps: () async{
                  var connectivityResult = await (Connectivity().checkConnectivity());

                  if(connectivityResult[0] == ConnectivityResult.none){
                    showAlertDialogWidget(context, 'Internet Bağlantı Hatası', 'Telefonunuzun internet bağlantısı bulunmamaktadır. Lütfen telefonunuzu internete bağlayınız.', (){Navigator.of(context).pop();});
                  }
                  else if(connectivityResult[0] != ConnectivityResult.none){
                    getPassword(item,emailController.text.replaceAll(" ", "").toLowerCase(),context);
                  }
                },
                borderWidht: 1,
                backgroundColor: secondaryColor,
                borderColor: secondaryColor,
                textColor: textColor
            )
          ],
        ),
      ),
    );
  }

  Widget backLoginScreenButton(double heightConst, double widthConst){
    return ButtonWidget(
        text: "Giriş Ekranına Dön",
        heightConst: heightConst,
        widthConst: widthConst,
        size: 18,
        radius: 20,
        fontWeight: FontWeight.w600,
        onTaps: (){
          naviLoginMainScreen(context);
        },
        borderWidht: 3,
        backgroundColor: primaryColor,
        borderColor: primaryColor,
        textColor: textColor);
  }

  Widget title(){
    return TextWidget(text: "Yeni Şifre Al", size: 35, fontWeight: FontWeight.w400, color: textColor);
  }

  Widget logo(){
    return Container(
      height: deviceHeight*0.28,
      width: deviceWidth*0.56,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              image: AssetImage("assets/logo/saha_takip_logo.png"),
              fit: BoxFit.contain
          )
      ),
    );
  }

  Widget userTypeTitle(){
    return TextWidget(text: "Kullanıcı Türünüzü Seçiniz", size: 17, fontWeight: FontWeight.w400, color: Colors.black);
  }

  Widget userTypeDropDown(){
    return DropdownMenu<String>(
      initialSelection: item,
      onSelected: (String? value) {
        setState(() {
          item = value!;
        });
      },
      dropdownMenuEntries: userTypeList.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
  }

  Widget info(){
    return TextWidget(text: "Lütfen @hakmarmagazacilik.com.tr\nuzantılı mail adresinizi giriniz.", size: 15, fontWeight: FontWeight.w400, color: textColor);
  }

}



