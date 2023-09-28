import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants/constants.dart';
import '../screens/shopVisiting/commonScreens/shopsScreen.dart';

void userCondition(String user, List<BottomNavigationBarItem>list){
  print("elif");
  if(user=="BS"){
    list = itemListBS;
  }
  if(user=="PM"){
    list = itemListPM;
  }
  if(user=="BM" || user=="GK"){
    list = itemListBMandGK;
  }
  if(user=="NK"){
    list = itemListNK;
  }
}


