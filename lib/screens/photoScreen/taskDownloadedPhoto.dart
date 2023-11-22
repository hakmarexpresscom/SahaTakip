import 'dart:convert';
import 'dart:typed_data';
import 'package:deneme/constants/constants.dart';
import 'package:deneme/routing/bottomNavigationBar.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import '../../../constants/bottomNaviBarLists.dart';
import '../../../constants/pagesLists.dart';
import '../../models/photo.dart';
import '../../services/photoServices.dart';

class TaskDownloadedPhotoScreen extends StatefulWidget {

  int? photo_id = 0;
  TaskDownloadedPhotoScreen({super.key, required this.photo_id});

  @override
  State<TaskDownloadedPhotoScreen> createState() =>
      _TaskDownloadedPhotoScreenState();
}

class _TaskDownloadedPhotoScreenState extends State<TaskDownloadedPhotoScreen> with TickerProviderStateMixin {

  late Future<Photo> futurePhoto;

  int _selectedIndex = 3;

  List<BottomNavigationBarItem> naviBarList = [];
  List<Widget> pageList = [];

  late double deviceHeight;
  late double deviceWidth;

  DateTime now = DateTime.now();

  late AnimationController controller;

  late String base64photo = "";

  @override
  void initState() {
    super.initState();
    futurePhoto = fetchPhoto2('http://172.23.21.112:7042/api/Fotograf/${widget.photo_id}');
    controller = AnimationController(
      /// [AnimationController]s can be created with `vsync: this` because of
      /// [TickerProviderStateMixin].
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
    });
    controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {

    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    void userCondition(String user){
      if(user=="BS"){
        naviBarList = itemListBS;
        pageList = pagesBS;
      }
      if(user=="PM"){
        naviBarList = itemListPM;
        pageList = pagesPM;
      }
      if(user=="BM" || user=="GK"){
        naviBarList = itemListBMandGK;
        pageList = pagesBMGK;
      }
      if(user=="NK"){
        naviBarList = itemListNK;
        pageList = pagesNK;
      }
    }

    userCondition(userType);

    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: const Text('Görev Fotoğrafı'),
        ),
        body: Container(
            alignment: Alignment.center,
            child: taskDownloadedPhotoScreenUI(),
          ),
        bottomNavigationBar: BottomNaviBar(selectedIndex: _selectedIndex,itemList: naviBarList,pageList: pageList,)
    );
  }

  Widget taskDownloadedPhotoScreenUI(){
    return Expanded(
        child: FutureBuilder<Photo>(
            future: futurePhoto,
            builder: (context, snapshot){
              if(snapshot.hasData){
                base64photo = snapshot.data!.photo_file;
                Uint8List photoBytes = base64Decode(base64photo);
                ImageProvider imageProvider = MemoryImage(photoBytes);
                return PhotoView(
                      imageProvider: imageProvider,
                      minScale: PhotoViewComputedScale.contained,
                      maxScale: PhotoViewComputedScale.covered * 2,);
              }
              if(snapshot.connectionState == ConnectionState.waiting){
                return Column(
                    children:[
                      SizedBox(height: deviceHeight*0.06,),
                      CircularProgressIndicator(
                        value: controller.value,
                        semanticsLabel: 'Circular progress indicator',
                      ),
                    ]
                );
              }
              else{
                return Text("Bu mağaza için yüklenen fotoğraf yok.");
              }
            }
        )
    );
  }
}


