import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import '../../constants/constants.dart';
import '../../models/photo.dart';
import '../../services/photoServices.dart';
import '../../styles/styleConst.dart';

class AnswerDownloadedPhotoScreen extends StatefulWidget {

  int complete_task_id = 0;

  AnswerDownloadedPhotoScreen({super.key, required this.complete_task_id});

  @override
  State<AnswerDownloadedPhotoScreen> createState() => _AnswerDownloadedPhotoScreenState();
}

class _AnswerDownloadedPhotoScreenState extends State<AnswerDownloadedPhotoScreen> with TickerProviderStateMixin {

  late Future<List<Photo>> futurePhoto;

  late double deviceHeight;
  late double deviceWidth;

  DateTime now = DateTime.now();

  late AnimationController controller;

  late String base64photo = "";

  @override
  void initState() {
    super.initState();
    futurePhoto = fetchPhoto('${constUrl}api/Fotograf/byTamamlanmisGorevID?tamamlanmis_gorev_id=${widget.complete_task_id}');
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
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          foregroundColor: appbarForeground,
          backgroundColor: appbarBackground,
          title: const Text('Cevap Fotoğrafı'),
        ),
        body: Container(
          alignment: Alignment.center,
          child: answerDownloadedPhotoScreenUI(),
        ),
    );
  }
  Widget answerDownloadedPhotoScreenUI(){
    return Flex(
        direction: Axis.vertical,
        children:[
      Expanded(
        child: FutureBuilder<List<Photo>>(
            future: futurePhoto,
            builder: (context, snapshot){
              if(snapshot.hasData){
                base64photo = snapshot.data![0].photo_file;
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
                return Text("Bu görev için yüklenen cevap fotoğrafı yok.");
              }
            }
        )
    )]);
  }
}
