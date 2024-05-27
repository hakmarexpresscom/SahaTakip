import 'dart:convert';
import 'dart:io';
import 'package:deneme/routing/landing.dart';
import 'package:deneme/styles/styleConst.dart';
import 'package:deneme/widgets/cards/shopPhotoCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../constants/bottomNaviBarLists.dart';
import '../../constants/constants.dart';
import '../../constants/pagesLists.dart';
import '../../main.dart';
import '../../models/shop.dart';
import '../../routing/bottomNavigationBar.dart';
import '../../services/shopServices.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/text_widget.dart';

class SubmitTaskShopPhotoSelectionScreen extends StatefulWidget {
  const SubmitTaskShopPhotoSelectionScreen({super.key});

  @override
  State<SubmitTaskShopPhotoSelectionScreen> createState() => _SubmitTaskShopPhotoSelectionScreenState();
}

class _SubmitTaskShopPhotoSelectionScreenState extends State<SubmitTaskShopPhotoSelectionScreen> with TickerProviderStateMixin {

  late Future<List<Shop>> futureShopList;

  int bs = 0;

  int _selectedIndex = 4;

  List<BottomNavigationBarItem> naviBarList = [];
  List<Widget> pageList = [];

  late double deviceHeight;
  late double deviceWidth;

  late AnimationController controller;

  XFile? image;

  final ImagePicker picker = ImagePicker();

  String photo_file = "";

  Future getImage(ImageSource media, int shopCode) async {
    var img = await picker.pickImage(source: media);
    final bytes = File(img!.path).readAsBytesSync();
    photo_file = photo_file+base64Encode(bytes);
    setState(() {
      boxShopTaskPhoto.get(shopCode.toString())[0] = boxShopTaskPhoto.get(shopCode.toString())[0]+photo_file;
    });
    taskPhotos.add(img);
  }

  void addPhoto(int shopCode) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Atanacak görev için bir fotoğraf yükleyin.'),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery, shopCode);
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
                      getImage(ImageSource.camera, shopCode);
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
    futureShopList = fetchShop('${constUrl}api/magaza${urlShopFilter}=${userID}');
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

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    void userCondition(String user){
      if(user=="BS"){
        naviBarList = itemListBS;
        if(isStartShiftObs.value==false&&isRegionCenterVisitInProgress.value==false){
          pageList = pagesBS;
        }
        else if(isStartShiftObs.value&&isRegionCenterVisitInProgress.value==false){
          pageList = pagesBS2;
        }
        else if(isRegionCenterVisitInProgress.value){
          pageList = pagesBS3;
        }
      }
      if(user=="PM"){
        naviBarList = itemListPM;
        if(isStartShiftObs.value==false&&isRegionCenterVisitInProgress.value==false){
          pageList = pagesPM;
        }
        else if(isStartShiftObs.value&&isRegionCenterVisitInProgress.value==false){
          pageList = pagesPM2;
        }
        else if(isRegionCenterVisitInProgress.value){
          pageList = pagesPM3;
        }
        _selectedIndex = 4;
      }
      if(user=="BM" || user=="GK"){
        naviBarList = itemListBMandGK;
        pageList = pagesBMGK;
        _selectedIndex = 3;
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
        foregroundColor: appbarForeground,
        backgroundColor: appbarBackground,
        title: const Text('Görev Atama Mağaza Seçimi'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: deviceHeight*0.02,),
          taskTypeInfo(),
          SizedBox(height: deviceHeight*0.02,),
          Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: BorderSide(
                      color: Colors.indigo,
                      width: 1.5
                  )
              ),
              child: CupertinoButton(
                padding: EdgeInsets.fromLTRB(3, 0, 3, 0),
                onPressed: () => _showDialog(
                  CupertinoPicker(
                    magnification: 1.22,
                    squeeze: 1.2,
                    useMagnifier: true,
                    itemExtent: kItemExtent,
                    scrollController: FixedExtentScrollController(
                      initialItem: bs,
                    ),
                    onSelectedItemChanged: (int selectedItem) {
                      setState(() {
                        bs = selectedItem;
                        if(bs==0){
                          futureShopList = fetchShop('${constUrl}api/magaza${urlShopFilter}=${userID}');
                        }
                        else{
                          futureShopList = (groupNo==0)?fetchShop('${constUrl}api/magaza/byBsId?bs_id=${box.get("bsIDs")[bs]}'):fetchShop('${constUrl}api/magaza/byBsManavId?bs_manav_id=${box.get("bsIDs")[bs-1]}');
                        }
                      });
                    },
                    children:
                    List<Widget>.generate(box.get("bsNames").length, (int index) {
                      return Center(child: Text(box.get("bsNames")[index].toString()));
                    }),
                  ),
                ),
                child: Text(
                  (bs==0)?box.get("bsNames")[bs]:"Bölge Sorumlusu: "+box.get("bsNames")[bs],
                  style: const TextStyle(
                    fontSize: 17,
                  ),
                ),
              )
          ),


          SizedBox(height: deviceHeight*0.02,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Checkbox(
                  value: allSelected[bs],
                  onChanged: (newvalue){
                    setState(() {
                      allSelected[bs] = newvalue!;
                      var list = boxShopTaskPhoto.keys.toList();
                      for(int i=0; i<list.length;i++){
                        if(box.get("bsIDs")[bs]==boxShopTaskPhoto.get(list[i])[2] && boxShopTaskPhoto.get(list[i])[2]!=newvalue){
                          boxShopTaskPhoto.get(list[i])[1]=newvalue;
                        }
                      }
                    });
                  }
              ),
              TextWidget(text: "Tümünü Seç", size: 20, fontWeight: FontWeight.w600, color: textColor),
            ],
          ),
          SizedBox(height: deviceHeight*0.02,),
          submitTaskShopPhotoSelectionScreen(),
          SizedBox(height: deviceHeight*0.02,),
          shopPhotoSelectionButton(),
          SizedBox(height: deviceHeight*0.02,),
        ],
      ),
        bottomNavigationBar: BottomNaviBar(selectedIndex: _selectedIndex,itemList: naviBarList,pageList: pageList,)
    );
  }

  Widget submitTaskShopPhotoSelectionScreen(){
    return Expanded(child: FutureBuilder<List<Shop>>(
        future: futureShopList,
        builder: (context, snapshot){
          if(snapshot.hasData){
            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index){
                if(snapshot.data![index].isActive==1){
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ShopPhotoCard(
                        heightConst: 0.27,
                        widthConst: 0.80,
                        sizedBoxConst1: 0.00,
                        sizedBoxConst2: 0.01,
                        sizedBoxConst3: 0.03,
                        sizedBoxConst4: 0.01,
                        shopName: snapshot.data![index].shopName,
                        shopCode: snapshot.data![index].shopCode,
                        icon: Icons.store,
                        textSizeCode: 20,
                        textSizeButton: 15,
                        textSizeName: 18,
                        onAddPhotoTaps: (){
                          setState(() {
                            photo_file = "";
                          });
                          addPhoto(snapshot.data![index].shopCode);
                          },
                        onShowPhotoTaps: (){
                          naviTaskPhotoScreen(context, boxShopTaskPhoto.get(snapshot.data![index].shopCode.toString())[0]);
                        },
                      ),
                    ],
                  );
                }
                else{
                  return Container();
                }
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
        })
    );
  }

  Widget shopPhotoSelectionButton(){
    return ButtonWidget(text: "Kaydet", heightConst: 0.06, widthConst: 0.8, size: 18, radius: 20, fontWeight: FontWeight.w600, onTaps: (){Navigator.pop(context);}, borderWidht: 1, backgroundColor: secondaryColor, borderColor: secondaryColor, textColor: textColor);
  }

  Widget taskTypeInfo(){
    return TextWidget(text: "Görev atarken mağazalarınızı aşağıdaki buton\nyardımıyla bölge sorumlularının mağazalarına göre filtreleyebilirsiniz.", size: 16, fontWeight: FontWeight.w400, color: textColor);
  }

}


