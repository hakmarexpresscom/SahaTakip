import 'package:deneme/models/user.dart';

class Task{
  late int taskID;
  late String taskName;
  late String taskDescription;
  late DateTime taskDeadline;
  late String taskType;
  late bool isCompleted;
  late List<User> BSList;

  Task({
    required this.taskID,
    required this.taskName,
    required this.taskDescription,
    required this.taskDeadline,
    required this.taskType,
    required this.isCompleted,
    required this.BSList,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
        taskID: json['Gorev_ID'],
        taskName: json['Gorev_Adi'],
        taskDescription: json['Gorev_Tanimi'],
        taskDeadline: json['Bitis_Tarihi'],
        taskType: json['Gorev_Turu'],
        isCompleted: json['Tamamlandi_Bilgisi'],
        BSList: json['Bolge_Sorumlusu_Listesi'],
    );
  }

}


