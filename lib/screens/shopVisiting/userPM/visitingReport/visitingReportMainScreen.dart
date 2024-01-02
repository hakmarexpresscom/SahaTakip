import 'dart:convert';
import 'dart:io';

import 'package:deneme/constants/constants.dart';
import 'package:deneme/routing/bottomNavigationBar.dart';
import 'package:deneme/utils/sendTaskMailFuncstions.dart';
import 'package:deneme/widgets/textFormFieldDatePicker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../../constants/bottomNaviBarLists.dart';
import '../../../../constants/pagesLists.dart';
import '../../../../main.dart';
import '../../../../models/report.dart';
import '../../../../routing/landing.dart';
import '../../../../services/inCompleteTaskServices.dart';
import '../../../../services/photoServices.dart';
import '../../../../services/reportServices.dart';
import '../../../../utils/appStateManager.dart';
import '../../../../utils/generalFunctions.dart';
import '../../../../widgets/alert_dialog.dart';
import '../../../../widgets/button_widget.dart';
import '../../../../widgets/cards/pastReportCard.dart';
import '../../../../widgets/text_form_field.dart';

class VisitingRaportMainScreen extends StatefulWidget {

  int shop_code = 0;

  static var taskName = "";
  static var taskDeadline = "";
  static var taskDescription = "";

  VisitingRaportMainScreen({super.key,required this.shop_code});

  @override
  State<VisitingRaportMainScreen> createState() =>
      _VisitingRaportMainScreenState();
}

class _VisitingRaportMainScreenState extends State<VisitingRaportMainScreen> with TickerProviderStateMixin {

  late Future<List<Report>> futureReport;

  late double deviceHeight;
  late double deviceWidth;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final taskNameController = TextEditingController();
  final taskDeadlineController = TextEditingController();
  final taskDescriptionController = TextEditingController();

  DateTime now = DateTime.now();

  late AnimationController controller;

  final ReportManager reportManager = Get.put(ReportManager());

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
    futureReport = fetchReport('http://172.23.21.112:7042/api/Rapor/filterReport1?magaza_kodu=${widget.shop_code}&grup_no=${groupNo}');
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
    controller.dispose(); // AnimationController'ı temizle
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    return DefaultTabController(
        initialIndex: 0,
        length: 2,
        child:Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              foregroundColor: Colors.white,
              backgroundColor: Colors.indigo,
              title: const Text('Mağaza Ziyaret Raporu'),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  naviShopVisitingProcessesScreen(context, box.get('currentShopID'), box.get('currentShopName'));
                },
              ),
              bottom: TabBar(
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white30,
                tabs: [
                  Tab(text: "Rapor Girişi"),
                  Tab(text: "Geçmiş Raporlar")
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                SingleChildScrollView(child:(isReportCreated.value)?enterVisitingReportScreenUI():createReportButtonUI(),),
                pastReportsMainScreenUI(),
              ],
            ),
        ));
  }

  Widget enterVisitingReportScreenUI(){
    return Builder(builder: (BuildContext context){
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: deviceHeight*0.05,),
            inputForm(),
            SizedBox(height: deviceHeight*0.03,),
            image != null ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(
                  File(image!.path),
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                ),
              ),
            ) : Text("Fotoğraf Bilgisi Yok", style: TextStyle(fontSize: 17),),
            SizedBox(height: deviceHeight*0.03,),
            addPhotoButton(),
            SizedBox(height: deviceHeight*0.03,),
            saveExternalTaskButton(),
          ],
        ),
      );
    });
  }

  Widget createReportButtonUI(){
    return Builder(builder: (BuildContext context){
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: deviceHeight*0.15,),
            createReportButton()
          ],
        ),
      );
    });
  }

  Widget createReportButton(){
    return ButtonWidget(
        text: "Rapor Oluştur",
        heightConst: 0.06,
        widthConst: 0.8,
        size: 18,
        radius: 20,
        fontWeight: FontWeight.w600,
        onTaps: () async {
          reportManager.createReport();
          await countReport("http://172.23.21.112:7042/api/Rapor");
          await createReport(reportCount+1, userID, widget.shop_code,now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString(), groupNo, "http://172.23.21.112:7042/api/Rapor");
          naviVisitingReportMainScreen(context, widget.shop_code);
          },
        borderWidht: 1,
        backgroundColor: Colors.lightGreen.withOpacity(0.6),
        borderColor: Colors.lightGreen.withOpacity(0.6),
        textColor: Colors.black);
  }

  Widget saveExternalTaskButton(){
    return ButtonWidget(
        text: "Görevi Rapora Ekle",
        heightConst: 0.06,
        widthConst: 0.8,
        size: 18,
        radius: 20,
        fontWeight: FontWeight.w600,
        onTaps: () async {
          await countReport("http://172.23.21.112:7042/api/Rapor");
          await countIncompleteTask("http://172.23.21.112:7042/api/TamamlanmamisGorev");
          await addReportTaskToDatabase(
              "http://172.23.21.112:7042/api/TamamlanmamisGorev",
              taskNameController.text,
              taskDescriptionController.text,
              now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString(),
              taskDeadlineController.text,
              widget.shop_code,
              photoCount+1,
              "Rapor",
              reportCount,
              groupNo,
              "http://172.23.21.112:7042/api/TamamlanmamisGorev",
              photo_file,
              null,
              userID,
              null,
              "Rapor",
              "http://172.23.21.112:7042/api/Fotograf/${photoCount+1}"
          );
          //sendTaskMail(email, "Tarafınıza ${widget.shop_code} koduna sahip mağaza ile alakalı yeni bir görev atanmıştır. Görev türü 'Ziyaret Raporu''dur. Saha Takip uygulaması üzerinden yeni görevinizin detaylarını inceleyebilirsiniz.");
          showReportTaskSubmitDialog(context);
        },
        borderWidht: 1,
        backgroundColor: Colors.lightGreen.withOpacity(0.6),
        borderColor: Colors.lightGreen.withOpacity(0.6),
        textColor: Colors.black);
  }

  Widget addPhotoButton(){
    return ButtonWidget(
        text: "Fotoğraf Ekle",
        heightConst: 0.06,
        widthConst: 0.8,
        size: 18,
        radius: 20,
        fontWeight: FontWeight.w600,
        onTaps: (){
          addPhoto(null, widget.shop_code, null, userID, null, "Rapor", null, 'http://172.23.21.112:7042/api/Fotograf');
          },
        borderWidht: 3,
        backgroundColor: Colors.orangeAccent,
        borderColor: Colors.orangeAccent,
        textColor: Colors.black);
  }

  Widget inputForm(){
    return Container(
      width: deviceWidth*0.8,
      child: Form(
        key: _formKey,
        onChanged: (){
          _formKey.currentState!.save();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextFormFieldWidget(text: "Görev Adı", borderWidht: 2, titleColor: Colors.black, borderColor: Colors.black, controller: taskNameController, value: VisitingRaportMainScreen.taskName, paddingValue: 5,maxLines: 1),
            SizedBox(height: deviceHeight*0.03,),
            TextFormFieldDatePicker(text: "Görev Bitiş Tarihi", borderWidht: 2, titleColor: Colors.black, borderColor: Colors.black, dateController: taskDeadlineController, value: VisitingRaportMainScreen.taskDeadline, paddingValue: 5,maxLines: 1),
            SizedBox(height: deviceHeight*0.03,),
            TextFormFieldWidget(text: "Görev Detayı", borderWidht: 2, titleColor: Colors.black, borderColor: Colors.black, controller: taskDescriptionController, value: VisitingRaportMainScreen.taskDescription, paddingValue: 5,maxLines: 8),
          ],
        ),
      ),
    );
  }

  Widget pastReportsMainScreenUI(){
    return Column(
        children: [FutureBuilder<List<Report>>(
            future: futureReport,
            builder: (context, snapshot){
              if(snapshot.hasData){
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index){
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: deviceHeight*0.01,),
                        PastReportCard(heightConst: 0.22, widthConst: 0.95, reportName: "Rapor ${snapshot.data![index].report_id}",createDate: snapshot.data![index].createDate,onTaps: (){naviPastReportTasksScreen(context,snapshot.data![index].report_id);}),
                      ],
                    );
                  },
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

  showReportTaskSubmitDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialogWidget(
            title: 'Görev Eklendi',
            content: 'Görev başarılı bir şekilde raproa eklendi!',
            onTaps: (){
              naviVisitingReportMainScreen(context, widget.shop_code);
            },
          );
        }
    );
  }

}


