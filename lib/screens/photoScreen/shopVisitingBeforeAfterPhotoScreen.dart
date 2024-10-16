import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:deneme/constants/constants.dart';
import 'package:deneme/styles/styleConst.dart';
import 'package:deneme/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../main.dart';
import '../../routing/landing.dart';
import '../../utils/generalFunctions.dart';
import '../../utils/sendShopVsitingReportFuncstions.dart';
import '../../widgets/button_widget.dart';

class ShopVisitingBeforeAfterPhotoScreen extends StatefulWidget {

  bool isBefore = true;

  ShopVisitingBeforeAfterPhotoScreen({super.key, required this.isBefore});

  @override
  State<ShopVisitingBeforeAfterPhotoScreen> createState() =>
      _ShopVisitingBeforeAfterPhotoScreenState();
}

class _ShopVisitingBeforeAfterPhotoScreenState extends State<ShopVisitingBeforeAfterPhotoScreen> {

  late double deviceHeight;
  late double deviceWidth;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        foregroundColor: appbarForeground,
        backgroundColor: appbarBackground,
        title: (widget.isBefore == true)?Text('Ziyaret Öncesi Fotoğraf'):Text('Ziyaret Sonrası Fotoğraf'),
      ),
      body: PopScope(
          canPop: false,
          onPopInvoked: (bool didPop) {},
          child:SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child:Container(
              alignment: Alignment.center,
              child: shopVisitingBeforeAfterPhotoScreenUI(),
            ),
          )
      ),
    );
  }

  Widget shopVisitingBeforeAfterPhotoScreenUI(){
    return Builder(builder: (BuildContext context){
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: deviceHeight*0.2,),
            photoInfo(),
            SizedBox(height: deviceHeight*0.05,),
            uploadPhotoButton(context),
          ],
        ),
      );
    });
  }


  Widget photoInfo(){
    return (widget.isBefore==true)?
    TextWidget(
        text:"Mağaza ziyaretine başlamadan önce mağazanın ziyaret öncesi fotoğrafını yüklemeniz gerekmektedir.",
        size: 20,
        fontWeight: FontWeight.w400,
        color: textColor
    ):
    TextWidget(
        text:"Mağaza ziyaretini bitirmek için mağazanın ziyaret sonrası fotoğrafını yüklemeniz gerekmektedir.",
        size: 20,
        fontWeight: FontWeight.w400,
        color: textColor
    );
  }

  Widget uploadPhotoButton(BuildContext context) {
    return ButtonWidget(
      text: "Fotoğraf Yükle",
      heightConst: 0.06,
      widthConst: 0.8,
      size: 18,
      radius: 20,
      fontWeight: FontWeight.w600,
      onTaps: () async {
        var connectivityResult = await (Connectivity().checkConnectivity());

        if (connectivityResult[0] == ConnectivityResult.none) {
          showAlertDialogWidget(context, 'Internet Bağlantı Hatası',
              'Telefonunuzun internet bağlantısı bulunmamaktadır. Lütfen telefonunuzu internete bağlayınız.', () {
                Navigator.of(context).pop();
              });
        } else {
          _showPhotoSourceSelectionDialog();
        }
      },
      borderWidht: 1,
      backgroundColor: secondaryColor,
      borderColor: secondaryColor,
      textColor: textColor,
    );
  }

  void _showPhotoSourceSelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Fotoğraf Kaynağını Seç"),
          content: Text("Fotoğrafı kameradan mı yoksa galeriden mi yüklemek istersiniz?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.camera,context);
              },
              child: Text("Kamera"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.gallery,context);
              },
              child: Text("Galeri"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source, BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {

      if (widget.isBefore) {
        boxshopVisitingPhoto.put('beforePhoto', pickedFile.path);
      } else {
        boxshopVisitingPhoto.put('afterPhoto', pickedFile.path);
      }

      showAlertDialogWidget(
        context,
        'Başarılı', 'Fotoğraf başarıyla yüklendi.',
        () async{
          if(widget.isBefore==true){
            naviShopVisitingProcessesScreen(context, box.get("currentShopID"), box.get("currentShopName"), box.get("groupNo"));
          }
          else if(widget.isBefore==false){
            showAlertDialogWithoutButtonWidget(context,"Mail Gönderiliyor","Ziyaret raporu mailiniz yollanıyor lütfen bekleyiniz.");

            await sendReport(box.get("groupNo"));
            resetShopVisitingReportInfo(box.get("groupNo"));

            Navigator.of(context).pop(); // Close the dialog
            (isBS == true) ? naviShopVisitingShopsScreenBS(context) : naviShopVisitingShopsScreenPM(context);
          }
        });
    }
    else {
      showAlertDialogWidget(context, 'Hata', 'Fotoğraf seçilmedi.', () {Navigator.of(context).pop();});
    }
  }


}

