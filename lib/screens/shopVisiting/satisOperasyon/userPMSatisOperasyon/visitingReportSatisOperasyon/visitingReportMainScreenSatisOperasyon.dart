import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:deneme/constants/constants.dart';
import 'package:deneme/widgets/textFormFieldDatePicker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../main.dart';
import '../../../../../models/report.dart';
import '../../../../../routing/landing.dart';
import '../../../../../services/reportServices.dart';
import '../../../../../styles/styleConst.dart';
import '../../../../../utils/appStateManager.dart';
import '../../../../../utils/generalFunctions.dart';
import '../../../../../utils/sendTaskMailFunctions.dart';
import '../../../../../widgets/button_widget.dart';
import '../../../../../widgets/cards/pastReportCard.dart';
import '../../../../../widgets/text_form_field.dart';

class VisitingRaportMainScreenSatisOperasyon extends StatefulWidget {

  int shop_code = 0;

  static var taskName = "";
  static var taskDeadline = "";
  static var taskDescription = "";

  VisitingRaportMainScreenSatisOperasyon({super.key,required this.shop_code});

  @override
  State<VisitingRaportMainScreenSatisOperasyon> createState() =>
      _VisitingRaportMainScreenSatisOperasyonState();
}

class _VisitingRaportMainScreenSatisOperasyonState extends State<VisitingRaportMainScreenSatisOperasyon> with TickerProviderStateMixin {

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

  Future getImage(ImageSource media, int? task_id, int shopCode, int? bs_id, int? pm_id, int? bm_id, String photoType, int? completeTask_id, String url) async {
    var img = await picker.pickImage(source: media);
    final bytes = File(img!.path).readAsBytesSync();
    photo_file = photo_file+base64Encode(bytes);
    setState(() {
      image = img;
    });
    /*await countPhoto(url);
    await createPhoto(photoCount+1, task_id, shopCode, bs_id, pm_id, bm_id, photoType, photo_file, completeTask_id, url);*/
  }

  void addPhoto(int? task_id, int shopCode, int? bs_id, int? pm_id, int? bm_id, String photoType, int? completeTask_id, String url) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Rapora ekleyeceğiniz görev için bir fotoğraf yükleyin.'),
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
    futureReport = fetchReport('${constUrl}api/Rapor/filterReport1?magaza_kodu=${widget.shop_code}&grup_no=${groupNo}');
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
              foregroundColor: appbarForeground,
              backgroundColor: appbarBackground,
              title: const Text('Ziyaret Tespiti BS Görevlendirme'),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  naviShopVisitingProcessesScreen(context, box.get('currentShopID'), box.get('currentShopName'), box.get("groupNo"));
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
                SingleChildScrollView(
                  child: (isReportCreated.value)?enterVisitingReportScreenUI():createReportButtonUI(),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [pastReportsMainScreenUI()],
                ),
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
            saveReportTaskButton(context),
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
            createReportButton(context)
          ],
        ),
      );
    });
  }

  Widget createReportButton(BuildContext context){
    return ButtonWidget(
        text: "Tespit Raporu Oluştur",
        heightConst: 0.06,
        widthConst: 0.8,
        size: 18,
        radius: 20,
        fontWeight: FontWeight.w600,
        onTaps: () async {

          var connectivityResult = await (Connectivity().checkConnectivity());

          if(connectivityResult[0] == ConnectivityResult.none){
            showAlertDialogWidget(context, 'Internet Bağlantı Hatası', 'Telefonunuzun internet bağlantısı bulunmamaktadır. Lütfen telefonunuzu internete bağlayınız.', (){Navigator.of(context).pop();});
          }

          else if(connectivityResult[0] != ConnectivityResult.none){

            showAlertDialogWithoutButtonWidget(context,"Rapor Oluşturuluyor","Rapor oluşturuluyor, lütfen bekleyiniz.");

            reportManager.createReport();
            await createReport(userID, widget.shop_code,now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString(), groupNo, "${constUrl}api/Rapor");
            //await countReport("${constUrl}api/Rapor");

            Navigator.of(context).pop(); // Close the dialog
            naviVisitingReportMainScreen(context, widget.shop_code,box.get("groupNo"));
          }
        },
        borderWidht: 1,
        backgroundColor: secondaryColor,
        borderColor: secondaryColor,
        textColor: textColor);
  }

  Widget saveReportTaskButton(BuildContext context){
    return ButtonWidget(
        text: "Görevi Rapora Ekle",
        heightConst: 0.06,
        widthConst: 0.8,
        size: 18,
        radius: 20,
        fontWeight: FontWeight.w600,
        onTaps: () async {

          var connectivityResult = await (Connectivity().checkConnectivity());

          if (taskNameController.text.isEmpty || taskDeadlineController.text.isEmpty) {
            showAlertDialogWidget(context, 'Uyarı', "Görev adı ve bitiş tarihi boş olamaz.", (){Navigator.of(context).pop();});
          }

          if(connectivityResult[0] == ConnectivityResult.none){
            showAlertDialogWidget(context, 'Internet Bağlantı Hatası', 'Telefonunuzun internet bağlantısı bulunmamaktadır. Lütfen telefonunuzu internete bağlayınız.', (){Navigator.of(context).pop();});
          }
          else if(taskNameController.text.isNotEmpty && taskDeadlineController.text.isNotEmpty && connectivityResult[0] != ConnectivityResult.none){

            showAlertDialogWithoutButtonWidget(context,"Görev Ekleniyor","Göreviniz rapora ekleniyor, lütfen bekleyiniz.");

            //await countReport("${constUrl}api/Rapor");
            await addReportTaskToDatabase(
                "${constUrl}api/TamamlanmamisGorev",
                taskNameController.text,
                taskDescriptionController.text.isEmpty ? null : taskDescriptionController.text,
                now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString(),
                taskDeadlineController.text,
                widget.shop_code,
                null,
                "Rapor",
                box.get("reportCount"),
                groupNo,
                "${constUrl}api/TamamlanmamisGorev",
                photo_file,
                null,
                userID,
                null,
                "Rapor",
            );

            await sendTask(box.get("groupNo"), "Bizz / Mağaza Tespit Raporu Görev Ataması");

            Navigator.of(context).pop(); // Close the dialog
            showAlertDialogWidget(context, 'Görev Eklendi', 'Görev başarılı bir şekilde rapora eklendi!', (){naviVisitingReportMainScreen(context, widget.shop_code,box.get("groupNo"));});
          }
        },
        borderWidht: 1,
        backgroundColor: secondaryColor,
        borderColor: secondaryColor,
        textColor: textColor);
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
          addPhoto(null, widget.shop_code, null, userID, null, "Rapor", null, '${constUrl}api/Fotograf');
        },
        borderWidht: 3,
        backgroundColor: primaryColor,
        borderColor: primaryColor,
        textColor: textColor);
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
            TextFormFieldWidget(text: "Görev Adı", borderWidht: 2, titleColor: textColor, borderColor: Colors.black, controller: taskNameController, value: VisitingRaportMainScreenSatisOperasyon.taskName, paddingValue: 5,maxLines: 1,maxLength: 50,controllerString: taskNameController.text, enabled: true,),
            SizedBox(height: deviceHeight*0.02,),
            TextFormFieldDatePicker(text: "Görev Bitiş Tarihi", borderWidht: 2, titleColor: textColor, borderColor: Colors.black, dateController: taskDeadlineController, value: VisitingRaportMainScreenSatisOperasyon.taskDeadline, paddingValue: 5,maxLines: 1,),
            SizedBox(height: deviceHeight*0.02,),
            TextFormFieldWidget(text: "Görev Detayı", borderWidht: 2, titleColor: textColor, borderColor: Colors.black, controller: taskDescriptionController, value: VisitingRaportMainScreenSatisOperasyon.taskDescription, paddingValue: 5,maxLines: 8,maxLength: 500,controllerString: taskDescriptionController.text, enabled: true,),
          ],
        ),
      ),
    );
  }

  Widget pastReportsMainScreenUI(){
    return Expanded(
        child: FutureBuilder<List<Report>>(
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
                        PastReportCard(reportName: "Tespit Raporu ${snapshot.data![index].report_id}",createDate: snapshot.data![index].createDate,onTaps: (){naviPastReportTasksScreen(context,snapshot.data![index].report_id,box.get("groupNo"));}),
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
        )
    );
  }

}


