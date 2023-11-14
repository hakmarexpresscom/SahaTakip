import 'package:deneme/constants/constants.dart';
import 'package:deneme/routing/bottomNavigationBar.dart';
import 'package:deneme/widgets/cards/taskDetailCard.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../constants/bottomNaviBarLists.dart';
import '../../constants/pagesLists.dart';
import '../../models/incompleteTask.dart';
import '../../routing/landing.dart';
import '../../services/inCompleteTaskServices.dart';
import '../../widgets/button_widget.dart';

class RemoteTaskDetailScreen extends StatefulWidget {

  int task_id = 0;
  RemoteTaskDetailScreen({super.key, required this.task_id});

  @override
  State<RemoteTaskDetailScreen> createState() =>
      _RemoteTaskDetailScreenState();
}

class _RemoteTaskDetailScreenState extends State<RemoteTaskDetailScreen> with TickerProviderStateMixin {

  late Future<IncompleteTask> futureIncompleteTask;

  int _selectedIndex = 3;

  List<BottomNavigationBarItem> naviBarList = [];
  List<Widget> pageList = [];

  late double deviceHeight;
  late double deviceWidth;

  DateTime now = DateTime.now();

  late AnimationController controller;

  XFile? image;

  final ImagePicker picker = ImagePicker();

  //we can upload image from camera or from gallery based on parameter
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);
    setState(() {
      image = img;
    });
  }

  void myAlert() {
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
                      getImage(ImageSource.gallery);
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
                      getImage(ImageSource.camera);
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
          backgroundColor: Colors.indigo,
          title: const Text('Görev Detayı'),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(0, deviceHeight*0.04, 0, 0),
          child:Container(
            alignment: Alignment.center,
            child: remoteTaskDetailScreenUI(),
          ),
        ),
        bottomNavigationBar: BottomNaviBar(selectedIndex: _selectedIndex,itemList: naviBarList,pageList: pageList,)
    );
  }

  Widget remoteTaskDetailScreenUI(){
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
                          onTaps: (){naviRemoteTasksMainScreen(context);},
                          onTapsShowPhoto: (){naviTaskDownloadedPhotoScreen(context, snapshot.data!.photo_id);},
                          id: snapshot.data!.task_id,
                          user_id: userID,
                          assignmentDate: now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString(),
                          assignmentHour: now.hour.toString()+"."+now.minute.toString(),
                          shop_code: snapshot.data!.shopCode,
                          photo_id: snapshot.data!.photo_id,
                          report_id: snapshot.data!.report_id,
                          addPhotoButton: ButtonWidget(text: "Fotoğraf Ekle", heightConst: 0.06, widthConst: 0.8, size: 18, radius: 20, fontWeight: FontWeight.w600, onTaps: (){myAlert();}, borderWidht: 3, backgroundColor: Colors.orangeAccent, borderColor: Colors.orangeAccent, textColor: Colors.black),
                          image: image,
                        ),
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


