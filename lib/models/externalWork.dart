class ExternalWork{
  late int external_work_id;
  late String workTitle;
  late String? workDetail;
  late String workAssignmentDate;
  late String workFinishDate;
  late int? bs_id;
  late int? pm_id;
  late int completionInfo;

  ExternalWork({
    required this.external_work_id,
    required this.workTitle,
    required this.workDetail,
    required this.workAssignmentDate,
    required this. workFinishDate,
    required this.bs_id,
    required this.pm_id,
    required this.completionInfo
  });

  factory ExternalWork.fromJson(Map<String, dynamic> json) {
    return ExternalWork(
      external_work_id: json['harici_is_id'],
      workTitle: json['is_tanimi'],
      workDetail: json['is_detayi'],
      workAssignmentDate: json['is_atama_tarihi'],
      workFinishDate: json['is_bitis_tarihi'],
      bs_id: json['bs_id'],
      pm_id: json['pm_id'],
      completionInfo: json['tamamlandi_bilgisi'],
    );
  }

}


