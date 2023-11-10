import 'dart:async';
import 'package:deneme/utils/forgetPasswordFunctions.dart';
import 'package:deneme/widgets/button_widget.dart';
import 'package:deneme/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import '../../../constants/constants.dart';
import '../../../routing/landing.dart';
import '../../../utils/loginFunctions.dart';

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
      body: LayoutBuilder(
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
            SizedBox(height: deviceHeight*0.08,),
            logo(),
            SizedBox(height: deviceHeight*0.03,),
            title(),
            SizedBox(height: deviceHeight*0.04,),
            TextWidget(text: "Kullanıcı Türünüzü Seçiniz", heightConst: 0, widhtConst: 0, size: 17, fontWeight: FontWeight.w400, color: Colors.black),
            SizedBox(height: deviceHeight*0.02,),
            userTypeDropDown(),
            SizedBox(height: deviceHeight*0.03,),
            inputForm(heightConst, widthConst),
            SizedBox(height: deviceHeight*0.03,),
            backLoginScreenButton(heightConst, widthConst),
          ],
        ),
      );
    });
  }

  Widget inputForm(double heightConst, double widthConst){
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
                onTaps: () {
                  findPassword(item,emailController.text,context);
                  //sendPasswordMail(emailController.text,"M1234567.");
                },
                borderWidht: 1,
                backgroundColor: Colors.lightGreen.withOpacity(0.6),
                borderColor: Colors.lightGreen.withOpacity(0.6),
                textColor: Colors.black
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
        backgroundColor: Colors.orangeAccent,
        borderColor: Colors.orangeAccent,
        textColor: Colors.black);
  }
  Widget title(){
    return TextWidget(text: "Şifremi Unuttum", heightConst: 0, widhtConst: 0, size: 35, fontWeight: FontWeight.w400, color: Colors.black);
  }
  Widget logo(){
    return Container(
      height: deviceHeight*0.25,
      width: deviceWidth*0.50,
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
        // This is called when the user selects an item.
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



