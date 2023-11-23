import 'package:flutter/material.dart';

class BottomNaviBar extends StatelessWidget{
  final int selectedIndex;
  final List<BottomNavigationBarItem> itemList;
  final List<Widget> pageList;

  const BottomNaviBar({
    Key? key,
    required this.selectedIndex,
    required this.itemList,
    required this.pageList
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return BottomNavigationBar(
      items: itemList,
      currentIndex: selectedIndex,
      selectedItemColor: Colors.indigo,
      unselectedItemColor: Colors.black,
      onTap: (index)=>{
        Navigator.push(context, MaterialPageRoute(builder: (context) => pageList[index]))
      },
    );
  }

}