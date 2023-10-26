import 'dart:async';
import 'package:deneme/widgets/button_widget.dart';
import 'package:deneme/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import '../../../constants/constants.dart';
import '../../../utils/loginFunctions.dart';
import '../../../widgets/text_form_field.dart';


class LoginMainScreen extends StatefulWidget {

  const LoginMainScreen({super.key});

  @override
  State<LoginMainScreen> createState() =>
      _LoginMainScreenState();
}

class _LoginMainScreenState extends State<LoginMainScreen> {

  String item = userTypeList[0];

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  late double deviceHeight;
  late double deviceWidth;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;


    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child:Container(
            alignment: Alignment.center,
            child: loginMainScreenUI(),
          ),
        ),
    );
  }

  Widget loginMainScreenUI(){
    return Builder(builder: (BuildContext context){
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: deviceHeight*0.08,),
            logo(),
            SizedBox(height: deviceHeight*0.03,),
            title(),
            SizedBox(height: deviceHeight*0.04,),
            TextWidget(text: "Kullanıcı Tipinizi Seçiniz", heightConst: 0, widhtConst: 0, size: 17, fontWeight: FontWeight.w400, color: Colors.black),
            SizedBox(height: deviceHeight*0.02,),
            userTypeDropDown(),
            SizedBox(height: deviceHeight*0.03,),
            inputForm(),
            SizedBox(height: deviceHeight*0.03,),
            loginButton(),
            SizedBox(height: deviceHeight*0.03,),
            forgetPasswordButton(),
          ],
        ),
      );
    });
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
            TextFormFieldWidget(text: "Email", borderWidht: 2, titleColor: Colors.black, borderColor: Colors.black, controller: emailController, value: email, paddingValue: 5,maxLines: 1),
            SizedBox(height: deviceHeight*0.03,),
            TextFormFieldWidget(text: "Şifre", borderWidht: 2, titleColor: Colors.black, borderColor: Colors.black, controller: passwordController, value: password, paddingValue: 5,maxLines: 1),
          ],
        ),
      ),
    );
  }

  Widget title(){
    return TextWidget(text: "Kullanıcı Girişi", heightConst: 0, widhtConst: 0, size: 35, fontWeight: FontWeight.w400, color: Colors.black);
  }
  Widget loginButton(){
    return ButtonWidget(text: "Giriş Yap", heightConst: 0.06, widthConst: 0.8, size: 18, radius: 20, fontWeight: FontWeight.w600, onTaps: (){checkEmail(item, emailController.text, context);}, borderWidht: 1, backgroundColor: Colors.lightGreen.withOpacity(0.6), borderColor: Colors.lightGreen.withOpacity(0.6), textColor: Colors.black);
  }
  Widget forgetPasswordButton(){
    return ButtonWidget(text: "Şifremi Unuttum", heightConst: 0.06, widthConst: 0.8, size: 18, radius: 20, fontWeight: FontWeight.w600, onTaps: (){}, borderWidht: 3, backgroundColor: Colors.orangeAccent, borderColor: Colors.orangeAccent, textColor: Colors.black);
  }
  Widget logo(){
    return Container(
      height: deviceHeight*0.25,
      width: deviceWidth*0.5,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: AssetImage("assets/logo/saha_takip_logo.png"),
          fit: BoxFit.cover
        )
      ),
    );
  }
  Widget userTypeDropDown(){
    return DropdownMenu<String>(
      initialSelection: item,
      onSelected: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          item = value!;
          print(item);
        });
      },
      dropdownMenuEntries: userTypeList.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
  }
}


