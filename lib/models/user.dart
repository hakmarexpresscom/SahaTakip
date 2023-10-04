import 'package:deneme/models/task.dart';

class User{
  late int userID;
  late int SAPID;
  late String Email;
  late String Name;
  late String Surname;
  late int managerSAPID;
  late String userType;
  late List<Task> myTasks;

  User({
    required this.userID,
    required this.SAPID,
    required this.Email,
    required this.Name,
    required this.Surname,
    required this.managerSAPID,
    required this.userType,
    required this.myTasks
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userID: json['Kullanici_ID'],
      SAPID: json['Kullanici_SAPID'],
      Email: json['Email'],
      Name: json['Isim'],
      Surname: json['Soyisim'],
      managerSAPID: json['Yonetici_SAPID'],
      userType: json['Kullanici_Turu'],
      myTasks: json['Gorevler']
    );
  }

}


