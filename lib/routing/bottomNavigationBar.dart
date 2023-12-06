import 'package:flutter/material.dart';

class BottomNaviBar extends StatefulWidget {
  final int selectedIndex;
  final List<BottomNavigationBarItem> itemList;
  final List<Widget> pageList;

  BottomNaviBar({
    Key? key,
    required this.selectedIndex,
    required this.itemList,
    required this.pageList
  }) : super(key: key);

  @override
  State<BottomNaviBar> createState() => _BottomNaviBarState();
}

class _BottomNaviBarState extends State<BottomNaviBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: widget.itemList,
      currentIndex: widget.selectedIndex,
      selectedItemColor: Colors.indigo,
      unselectedItemColor: Colors.black,
      onTap: (index)=>{
        Navigator.push(context, MaterialPageRoute(builder: (context) => widget.pageList[index]))
      },
    );
  }
}
