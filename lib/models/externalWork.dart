class ExternalWork{
  late int external_work_id;
  late int? bs_id;
  late int? pm_id;
  late String workTitle;
  late String? workDetail;
  late String workStartHour;
  late String workFinishHour;
  late String workAssignmentDate;
  late int completionInfo;
  late String workPlace;
  late String Lat;
  late String Long;

  ExternalWork({
    required this.external_work_id,
    required this.bs_id,
    required this.pm_id,
    required this.workTitle,
    required this.workDetail,
    required this.workStartHour,
    required this.workFinishHour,
    required this.workAssignmentDate,
    required this.completionInfo,
    required this.workPlace,
    required this.Lat,
    required this.Long
  });

  factory ExternalWork.fromJson(Map<String, dynamic> json) {
    return ExternalWork(
      external_work_id: json['harici_is_id'],
      bs_id: json['bs_id'],
      pm_id: json['pm_id'],
      workTitle: json['is_tanimi'],
      workDetail: json['is_detayi'],
      workStartHour: json['baslangic_saati'],
      workFinishHour: json['bitis_saati'],
      workAssignmentDate: json['is_atama_tarihi'],
      completionInfo: json['tamamlandi_bilgisi'],
      workPlace: json['is_yeri'],
      Lat: json['lat'],
      Long: json['long']
    );
  }

}


