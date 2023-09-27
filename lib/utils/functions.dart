import 'package:flutter/cupertino.dart';
import '../constants/constants.dart';

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
