import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import '../../constants/bottomNaviBarLists.dart';
import '../../constants/constants.dart';
import '../../constants/pagesLists.dart';
import '../../styles/styleConst.dart';

class TaskPhotoGalleryView extends StatefulWidget {
  List<XFile> imageList;
  TaskPhotoGalleryView({super.key,required this.imageList});

  @override
  State<TaskPhotoGalleryView> createState() => _TaskPhotoGalleryViewState();
}

class _TaskPhotoGalleryViewState extends State<TaskPhotoGalleryView> {

  late double deviceHeight;
  late double deviceWidth;

  @override
  Widget build(BuildContext context) {

    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        foregroundColor: appbarForeground,
        backgroundColor: appbarBackground,
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
          color: textColor,
        ),
        pageController: PageController(initialPage: 0),
      ),
    );
  }
}
