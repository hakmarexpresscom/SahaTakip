class IncompleteTask{
  late int task_id;
  late String taskTitle;
  late String taskDetail;
  late DateTime taskAssigmentDate;
  late DateTime taskFinishDate;
  late int shopCode;
  late int photo_id;
  late String taskType;
  late int bs_id;
  late int report_id;
  late int completionInfo;

  IncompleteTask({
    required this.task_id,
    required this.taskTitle,
    required this.taskDetail,
    required this.taskAssigmentDate,
    required this.taskFinishDate,
    required this.shopCode,
    required this.photo_id,
    required this.taskType,
    required this.bs_id,
    required this.report_id,
    required this.completionInfo
  });

  factory IncompleteTask.fromJson(Map<String, dynamic> json) {
    return IncompleteTask(
      task_id: json['gorev_id'],
      taskTitle: json['gorev_tanimi'],
      taskDetail: json['gorev_detayi'],
      taskAssigmentDate: json['gorev_atama_tarihi'],
      taskFinishDate: json['gorev_btis_tarihi'],
      shopCode: json['magaza_kodu'],
      photo_id: json['foto_id'],
      taskType: json['gorev_turu'],
      bs_id: json['bs_id'],
      report_id: json['rapor_id'],
      completionInfo: json['tamamlandi_bilgisi'],
    );
  }

}


