import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:deneme/constants/constants.dart';
import 'package:deneme/styles/styleConst.dart';
import 'package:deneme/widgets/cards/taskDetailCard.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../main.dart';
import '../../../../../models/incompleteTask.dart';
import '../../../../../routing/landing.dart';
import '../../../../../services/completeTaskServices.dart';
import '../../../../../services/inCompleteTaskServices.dart';
import '../../../../../services/photoServices.dart';
import '../../../../../utils/generalFunctions.dart';
import '../../../../../widgets/button_widget.dart';

class InPlaceTaskDetailScreenSatisOperasyon extends StatefulWidget {

  int task_id = 0;
  InPlaceTaskDetailScreenSatisOperasyon({super.key, required this.task_id});

  @override
  State<InPlaceTaskDetailScreenSatisOperasyon> createState() =>
      _InPlaceTaskDetailScreenSatisOperasyonState();
}

class _InPlaceTaskDetailScreenSatisOperasyonState extends State<InPlaceTaskDetailScreenSatisOperasyon> with TickerProviderStateMixin  {

  late Future<IncompleteTask> futureIncompleteTask;

  late double deviceHeight;
  late double deviceWidth;

  DateTime now = DateTime.now();

  late AnimationController controller;

  XFile? image;

  final ImagePicker picker = ImagePicker();

  String photo_file = "";

  Future getImage(ImageSource media, int? task_id, int shopCode, int? bs_id, int? pm_id, int? bm_id, String photoType, int? completeTask_id, String url) async {
    var img = await picker.pickImage(source: media);
    final bytes = File(img!.path).readAsBytesSync();
    photo_file = photo_file+base64Encode(bytes);
    setState(() {
      image = img;
    });
    var connectivityResult = await (Connectivity().checkConnectivity());

    if(connectivityResult[0] == ConnectivityResult.none){
      showAlertDialogWidget(context, 'Internet Bağlantı Hatası', 'Telefonunuzun internet bağlantısı bulunmamaktadır. Lütfen telefonunuzu internete bağlayınız.', (){Navigator.of(context).pop();});
    }

    else if(connectivityResult[0] != ConnectivityResult.none) {
      showAlertDialogWithoutButtonWidget(context,"Fotoğraf Ekleniyor","Cevap fotoğrafınız ekleniyor lütfen bekleyiniz.");

      await createPhoto(task_id, shopCode, bs_id, pm_id, bm_id, photoType, photo_file, completeTask_id, url);
      await countPhoto(url);

      Navigator.of(context).pop(); // Close the dialog
    }
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
    futureIncompleteTask = fetchIncompleteTask2('${constUrl}api/TamamlanmamisGorev/${widget.task_id}');
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
          foregroundColor: appbarForeground,
          backgroundColor: appbarBackground,
          title: const Text('Görev Detayı'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              TaskDetailCard.answerNoteController.clear();
              naviInPlaceTaskMainScreen(context,box.get("currentShopID"),box.get("groupNo"));
            },
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(0, deviceHeight*0.04, 0, 0),
          child:Container(
            alignment: Alignment.center,
            child: inPlaceTaskDetailScreenUI(),
          ),
        ),
    );
  }

  Widget inPlaceTaskDetailScreenUI(){
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
                      taskName: snapshot.data!.taskTitle,
                      taskDescription: snapshot.data!.taskDetail,
                      taskDeadline: snapshot.data!.taskFinishDate,
                      taskType: snapshot.data!.taskType,
                      onTaps: () async{

                        var connectivityResult = await (Connectivity().checkConnectivity());

                        if(connectivityResult[0] == ConnectivityResult.none){
                          showAlertDialogWidget(context, 'Internet Bağlantı Hatası', 'Telefonunuzun internet bağlantısı bulunmamaktadır. Lütfen telefonunuzu internete bağlayınız.', (){Navigator.of(context).pop();});
                        }

                        else if(connectivityResult[0] != ConnectivityResult.none) {

                          showAlertDialogWithoutButtonWidget(context, "Görev Tamamlanıyor", "Göreviniz tamamlanıyor ve cevaplarınız kaydoluyor lütfen bekleyiniz.");

                          updateCompletionInfoIncompleteTask(
                              snapshot.data!.task_id,
                              snapshot.data!.taskTitle,
                              snapshot.data!.taskDetail,
                              snapshot.data!.taskAssigmentDate,
                              snapshot.data!.taskFinishDate,
                              snapshot.data!.shopCode,
                              snapshot.data!.shopName,
                              snapshot.data!.photo_id,
                              snapshot.data!.taskType,
                              snapshot.data!.report_id,
                              1,
                              snapshot.data!.group_no,
                              snapshot.data!.bsName,
                              '${constUrl}api/TamamlanmamisGorev/${snapshot.data!.task_id}'
                          );

                          createCompleteTask(
                              snapshot.data!.task_id,
                              userID,
                              now.day.toString() + "-" + now.month.toString() + "-" + now.year.toString(),
                              (photo_file.isEmpty) ? null : box.get("photoCount"),
                              TaskDetailCard.answerNoteController.text,
                              '${constUrl}api/TamamlanmisGorev'
                          );

                          if (photo_file.isNotEmpty) {
                            updateCompleteTaskIDPhoto(
                                box.get("photoCount"),
                                null,
                                snapshot.data!.shopCode,
                                userID,
                                null,
                                null,
                                "YerindeCevap",
                                photo_file,
                                snapshot.data!.task_id,
                                '${constUrl}api/Fotograf/${box.get("photoCount")}'
                            );
                          }

                          Navigator.of(context).pop(); // Close the dialog
                          showAlertDialogWidget(context, 'Görev Tamamlandı', 'Göreviniz başarıyla tamamlandı!', (){naviInPlaceTaskMainScreen(context, box.get("currentShopID"),box.get("groupNo"));});
                        }

                      },
                      onTapsShowPhoto: (){naviTaskDownloadedPhotoScreen(context, snapshot.data!.photo_id);},
                      addPhotoButton:
                      ButtonWidget(
                          text: "Cevap Fotoğrafı Ekle",
                          heightConst: 0.06,
                          widthConst: 0.8,
                          size: 18,
                          radius: 20,
                          fontWeight: FontWeight.w600,
                          onTaps: (){
                            addPhoto(null, snapshot.data!.shopCode, userID, null, null, "YerindeCevap", null, '${constUrl}api/Fotograf');
                          },
                          borderWidht: 3,
                          backgroundColor: primaryColor,
                          borderColor: primaryColor,
                          textColor: textColor),
                      image: image,
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


