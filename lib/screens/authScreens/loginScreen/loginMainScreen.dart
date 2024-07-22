import 'package:deneme/styles/styleConst.dart';
import 'package:deneme/widgets/button_widget.dart';
import 'package:deneme/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import '../../../constants/constants.dart';
import '../../../routing/landing.dart';
import '../../../utils/loginFunctions.dart';

class LoginMainScreen extends StatefulWidget {

  const LoginMainScreen({super.key});

  @override
  State<LoginMainScreen> createState() =>
      _LoginMainScreenState();
}

class _LoginMainScreenState extends State<LoginMainScreen> {

  bool _isVisible = false;

  String item = userTypeList[0];

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  late double deviceHeight;
  late double deviceWidth;

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
            TextWidget(text: "Kullanıcı Türünüzü Seçiniz", size: 17, fontWeight: FontWeight.w400, color: textColor),
            SizedBox(height: deviceHeight*0.02,),
            userTypeDropDown(),
            SizedBox(height: deviceHeight*0.03,),
            inputForm(heightConst, widthConst),
            SizedBox(height: deviceHeight*0.03,),
            forgetPasswordButton(heightConst, widthConst),
          ],
        ),
      );
    });
  }

  Widget inputForm(double heightConst, double widthConst){
    return Container(
      width: deviceWidth*0.8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Form(
            child: TextFormField(
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
                border: OutlineInputBorder(borderSide: BorderSide(color: textColor, width: 2)),
                hintText: "Email",
              ),
            ),
          ),
          SizedBox(height: deviceHeight*0.03,),
          Form(
            child: TextFormField(
              maxLines: 1,
              autocorrect: false,
              onSaved: (input){
                setState((){
                  password = input!;
                });
              },
              controller: passwordController,
              obscureText: !_isVisible,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(5),
                border: OutlineInputBorder(borderSide: BorderSide(color: textColor, width: 2)),
                labelText: 'Şifre',
                suffixIcon: IconButton(
                  icon: Icon(_isVisible ? Icons.visibility_off : Icons.visibility),
                  onPressed: () => setState(() {
                    _isVisible = !_isVisible;
                  }),
                ),
              ),
            ),
          ),
          SizedBox(height: deviceHeight*0.03,),
          ButtonWidget(
              text: "Giriş Yap",
              heightConst: heightConst,
              widthConst: widthConst,
              size: 18,
              radius: 20,
              fontWeight: FontWeight.w600,
              onTaps: (){
                login(item, emailController.text.replaceAll(" ", "").toLowerCase(), passwordController.text, context);
              },
              borderWidht: 1,
              backgroundColor: secondaryColor,
              borderColor: secondaryColor,
              textColor: textColor
          )
        ],
      ),
    );
  }

  Widget title(){
    return TextWidget(text: "Kullanıcı Girişi", size: 35, fontWeight: FontWeight.w400, color: textColor);
  }

  Widget forgetPasswordButton(double heightConst, double widthConst){
    return ButtonWidget(
        text: "Yeni Şifre Al",
        heightConst: heightConst,
        widthConst: widthConst,
        size: 18,
        radius: 20,
        fontWeight: FontWeight.w600,
        onTaps: (){
          naviForgetPasswordScreen(context);
        },
        borderWidht: 3,
        backgroundColor: primaryColor,
        borderColor: primaryColor,
        textColor: textColor);
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

}



