class CompleteTask{
  late int task_id;
  late int bs_id;
  late String taskCompleteDate;
  late int? photo_id;
  late int completionInfo;

  CompleteTask({
    required this.task_id,
    required this.bs_id,
    required this.taskCompleteDate,
    required this.photo_id,
    required this.completionInfo
  });

  factory CompleteTask.fromJson(Map<String, dynamic> json) {
    return CompleteTask(
      task_id: json['gorev_id'],
      bs_id: json['bs_id'],
      taskCompleteDate: json['tamamlanma_tarihi'],
      photo_id: json['foto_id'],
      completionInfo: json['tamamlandi_bilgisi'],
    );
  }

}


