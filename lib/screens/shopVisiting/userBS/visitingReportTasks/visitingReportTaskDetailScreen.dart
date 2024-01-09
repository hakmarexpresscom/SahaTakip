import 'dart:convert';
import 'dart:io';
import 'package:deneme/constants/constants.dart';
import 'package:deneme/widgets/cards/taskDetailCard.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../main.dart';
import '../../../../models/incompleteTask.dart';
import '../../../../routing/landing.dart';
import '../../../../services/completeTaskServices.dart';
import '../../../../services/inCompleteTaskServices.dart';
import '../../../../services/photoServices.dart';
import '../../../../widgets/button_widget.dart';

class VisitingReportTaskDetailScreen extends StatefulWidget {
  int task_id=0;
  VisitingReportTaskDetailScreen({super.key, required this.task_id});

  @override
  State<VisitingReportTaskDetailScreen> createState() =>
      _VisitingReportTaskDetailScreenState();
}

class _VisitingReportTaskDetailScreenState extends State<VisitingReportTaskDetailScreen> with TickerProviderStateMixin {

  late Future<IncompleteTask> futureIncompleteTask;

  late double deviceHeight;
  late double deviceWidth;

  DateTime now = DateTime.now();

  late AnimationController controller;

  XFile? image;

  final ImagePicker picker = ImagePicker();

  String photo_file = "";

  //we can upload image from camera or from gallery based on parameter
  Future getImage(ImageSource media, int? task_id, int shopCode, int? bs_id, int? pm_id, int? bm_id, String photoType, int? completeTask_id, String url) async {
    var img = await picker.pickImage(source: media);
    final bytes = File(img!.path).readAsBytesSync();
    photo_file = photo_file+base64Encode(bytes);
    setState(() {
      image = img;
    });
    await countPhoto(url);
    await createPhoto(photoCount+1, task_id, shopCode, bs_id, pm_id, bm_id, photoType, photo_file, completeTask_id, url);
  }

  void addPhoto(int? task_id, int shopCode, int? bs_id, int? pm_id, int? bm_id, String photoType, int? completeTask_id, String url) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Tamamladığınız görev için bir fotoğraf yükleyin.'),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery,task_id, shopCode, bs_id, pm_id, bm_id, photoType, completeTask_id, url);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.image),
                        Text('Galeriyi Aç'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    //if user click this button. user can upload image from camera
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera, task_id, shopCode, bs_id, pm_id, bm_id, photoType, completeTask_id, url);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.camera),
                        Text('Kamerayı Aç'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    futureIncompleteTask = fetchIncompleteTask2('http://172.23.21.112:7042/api/TamamlanmamisGorev/${widget.task_id}');
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

    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: Colors.indigo,
          title: const Text('Görev Detayı'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              TaskDetailCard.answerNoteController.clear();
              naviVisitingReportTaskMainScreen(context,box.get("currentShopID"));
            },
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(0, deviceHeight*0.04, 0, 0),
          child:Container(
            alignment: Alignment.center,
            child: visitingReportTaskDetailScreen(),
          ),
        ),
    );
  }

  Widget visitingReportTaskDetailScreen(){
    return Column(
        children: [FutureBuilder<IncompleteTask>(
            future: futureIncompleteTask,
            builder: (context, snapshot){
              if(snapshot.hasData){
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TaskDetailCard(
                      heightConst: 0.7,
                      taskDeadline: snapshot.data!.taskFinishDate,
                      taskDescription: snapshot.data!.taskDetail!,
                      taskName: snapshot.data!.taskTitle,
                      widthConst: 0.9,
                      taskType: snapshot.data!.taskType,
                      isCompleted: (snapshot.data!.completionInfo==1)?true:false,
                      onTaps: (){
                        createCompleteTask(
                            snapshot.data!.task_id,
                            userID,
                            now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString(),
                            (photo_file.isEmpty)?null:photoCount+1,
                            TaskDetailCard.answerNoteController.text,
                            'http://172.23.21.112:7042/api/TamamlanmisGorev'
                        );
                        if(photo_file.isNotEmpty){
                          updateCompleteTaskIDPhoto(photoCount+1, null, snapshot.data!.shopCode, userID, null, null, "RaporCevap", photo_file, snapshot.data!.task_id, 'http://172.23.21.112:7042/api/Fotograf/${photoCount+1}');
                        }
                        naviVisitingReportTaskMainScreen(context, box.get("currentShopID"));
                      },
                      onTapsShowPhoto: (){naviTaskDownloadedPhotoScreen(context, snapshot.data!.photo_id);},
                      id: snapshot.data!.task_id,
                      user_id: userID,
                      assignmentDate: snapshot.data!.taskAssigmentDate,
                      assignmentHour: null,
                      shop_code: snapshot.data!.shopCode,
                      photo_id: snapshot.data!.photo_id,
                      report_id: snapshot.data!.report_id,
                      addPhotoButton:
                      ButtonWidget(
                          text: "Cevap Fotoğrafı Ekle",
                          heightConst: 0.06,
                          widthConst: 0.8,
                          size: 18,
                          radius: 20,
                          fontWeight: FontWeight.w600,
                          onTaps: (){
                            addPhoto(null, snapshot.data!.shopCode, userID, null, null, "RaporCevap", null, 'http://172.23.21.112:7042/api/Fotograf');
                          },
                          borderWidht: 3,
                          backgroundColor: Colors.orangeAccent,
                          borderColor: Colors.orangeAccent,
                          textColor: Colors.black),
                      image: image,
                      completionDate: now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString(),
                      answer_photo_id: (photoCount==0)?null:photoCount+1,
                      group_no: snapshot.data!.group_no,
                    ),
                    //TaskDetailCard(heightConst: 0.7,taskDeadline: snapshot.data!.taskFinishDate,taskDescription: snapshot.data!.taskDetail!,taskName: snapshot.data!.taskTitle,widthConst: 0.9,isExternalTask: false,isCompleted: (snapshot.data!.completionInfo==1)?true:false)
                  ],
                );
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
                return Text("Veri yok");
              }
            }
        )]
    );
  }
}


