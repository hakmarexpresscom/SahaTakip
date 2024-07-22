class IncompleteTask{
  late int task_id;
  late String taskTitle;
  late String? taskDetail;
  late String taskAssigmentDate;
  late String taskFinishDate;
  late int shopCode;
  late String shopName;
  late int? photo_id;
  late String taskType;
  late int? report_id;
  late int completionInfo;
  late int group_no;
  late String bsName;

  IncompleteTask({
    required this.task_id,
    required this.taskTitle,
    required this.taskDetail,
    required this.taskAssigmentDate,
    required this.taskFinishDate,
    required this.shopCode,
    required this.shopName,
    required this.photo_id,
    required this.taskType,
    required this.report_id,
    required this.completionInfo,
    required this.group_no,
    required this.bsName
  });

  factory IncompleteTask.fromJson(Map<String, dynamic> json) {
    return IncompleteTask(
      task_id: json['gorev_id'],
      taskTitle: json['gorev_tanimi'],
      taskDetail: json['gorev_detayi'],
      taskAssigmentDate: json['gorev_atama_tarihi'],
      taskFinishDate: json['gorev_bitis_tarihi'],
      shopCode: json['magaza_kodu'],
      shopName: json['magaza_ismi'],
      photo_id: json['foto_id'],
      taskType: json['gorev_turu'],
      report_id: json['rapor_id'],
      completionInfo: json['tamamlandi_bilgisi'],
      group_no: json['grup_no'],
      bsName: json['bs_ismi']
    );
  }

}


