import 'dart:convert';
import 'dart:io';

import 'package:deneme/constants/constants.dart';
import 'package:deneme/routing/bottomNavigationBar.dart';
import 'package:deneme/widgets/cards/taskDetailCard.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../constants/bottomNaviBarLists.dart';
import '../../../../constants/pagesLists.dart';
import '../../../../models/incompleteTask.dart';
import '../../../../routing/landing.dart';
import '../../../../services/completeTaskServices.dart';
import '../../../../services/inCompleteTaskServices.dart';
import '../../../../services/photoServices.dart';
import '../../../../widgets/button_widget.dart';

class InPlaceTaskDetailScreen extends StatefulWidget {

  int task_id = 0;
  InPlaceTaskDetailScreen({super.key, required this.task_id});

  @override
  State<InPlaceTaskDetailScreen> createState() =>
      _InPlaceTaskDetailScreenState();
}

class _InPlaceTaskDetailScreenState extends State<InPlaceTaskDetailScreen> with TickerProviderStateMixin  {

  late Future<IncompleteTask> futureIncompleteTask;

  int _selectedIndex = 0;

  List<BottomNavigationBarItem> naviBarList = [];
  List<Widget> pageList = [];

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
          foregroundColor: Colors.white,
          backgroundColor: Colors.indigo,
          title: const Text('Görev Detayı'),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(0, deviceHeight*0.04, 0, 0),
          child:Container(
            alignment: Alignment.center,
            child: inPlaceTaskDetailScreenUI(),
          ),
        ),
        bottomNavigationBar: BottomNaviBar(selectedIndex: _selectedIndex,itemList: naviBarList,pageList: pageList,)
    );
  }

  Widget inPlaceTaskDetailScreenUI(){
    return Expanded(
        child: FutureBuilder<IncompleteTask>(
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
                            'http://172.23.21.112:7042/api/TamamlanmisGorev'
                        );
                        updateCompleteTaskIDPhoto(photoCount+1, null, snapshot.data!.shopCode, userID, null, null, "YerindeCevap", photo_file, snapshot.data!.task_id, 'http://172.23.21.112:7042/api/Fotograf/${photoCount+1}');
                        naviRemoteTasksMainScreen(context);
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
                          text: "Fotoğraf Ekle",
                          heightConst: 0.06,
                          widthConst: 0.8,
                          size: 18,
                          radius: 20,
                          fontWeight: FontWeight.w600,
                          onTaps: (){
                            addPhoto(null, snapshot.data!.shopCode, userID, null, null, "YerindeCevap", null, 'http://172.23.21.112:7042/api/Fotograf');
                          },
                          borderWidht: 3,
                          backgroundColor: Colors.orangeAccent,
                          borderColor: Colors.orangeAccent,
                          textColor: Colors.black),
                      image: image,
                      completionDate: now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString(),
                      answer_photo_id: (photoCount==0)?null:photoCount+1,
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
        )
    );
  }
}


