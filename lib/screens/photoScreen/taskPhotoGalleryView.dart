import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import '../../styles/styleConst.dart';

class TaskPhotoGalleryView extends StatefulWidget {
  List<XFile> image_list;
  TaskPhotoGalleryView({super.key,required this.image_list});

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
      body: (widget.image_list.isEmpty)?Text("Bu görev için yüklenen fotoğraf yok."):
      PhotoViewGallery.builder(
        scrollPhysics: BouncingScrollPhysics(),
        builder: (BuildContext context, int index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: FileImage(File(widget.image_list[index].path)),
            minScale: PhotoViewComputedScale.contained * 0.8,
            maxScale: PhotoViewComputedScale.covered * 2,
          );
        },
        itemCount: widget.image_list.length,
        backgroundDecoration: BoxDecoration(
          color: textColor,
        ),
        pageController: PageController(initialPage: 0),
      ),
    );
  }
}
