import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import '../../constants/bottomNaviBarLists.dart';
import '../../constants/constants.dart';
import '../../constants/pagesLists.dart';

class TaskPhotoGalleryView extends StatefulWidget {
  List<XFile> imageList;
  TaskPhotoGalleryView({super.key,required this.imageList});

  @override
  State<TaskPhotoGalleryView> createState() => _TaskPhotoGalleryViewState();
}

class _TaskPhotoGalleryViewState extends State<TaskPhotoGalleryView> {

  int _selectedIndex = 4;

  List<BottomNavigationBarItem> naviBarList = [];
  List<Widget> pageList = [];

  late double deviceHeight;
  late double deviceWidth;

  @override
  Widget build(BuildContext context) {

    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    void userCondition(String user){
      if(user=="BS"){
        naviBarList = itemListBS;
        if(isStoreVisitInProgress.value){
          pageList = pagesBS2;
        }
        else if(isStoreVisitInProgress.value==false){
          pageList = pagesBS;
        }
      }
      if(user=="PM"){
        naviBarList = itemListPM;
        if(isStoreVisitInProgress.value){
          pageList = pagesPM2;
        }
        else if(isStoreVisitInProgress.value==false){
          pageList = pagesPM;
        }
        _selectedIndex = 4;
      }
      if(user=="BM" || user=="GK"){
        naviBarList = itemListBMandGK;
        pageList = pagesBMGK;
        _selectedIndex = 3;
      }
      if(user=="NK"){
        naviBarList = itemListNK;
        pageList = pagesNK;
      }
    }

    userCondition(userType);

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.indigo,
        title: const Text('Görev İçin Yüklenen Fotoğraflar'),
      ),
      body: (widget.imageList.isEmpty)?Text("Bu görev için yüklenen fotoğraf yok."):
      PhotoViewGallery.builder(
        scrollPhysics: BouncingScrollPhysics(),
        builder: (BuildContext context, int index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: FileImage(File(widget.imageList[index].path)),
            minScale: PhotoViewComputedScale.contained * 0.8,
            maxScale: PhotoViewComputedScale.covered * 2,
          );
        },
        itemCount: widget.imageList.length,
        backgroundDecoration: BoxDecoration(
          color: Colors.black,
        ),
        pageController: PageController(initialPage: 0),
      ),
    );
  }
}
