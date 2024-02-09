class VisitingDurations{
  late int shopCode;
  late int? bs_id;
  late int? pm_id;
  late String startTime;
  late String finishTime;
  late String date;
  late String workDuration;

  VisitingDurations({
    required this.shopCode,
    required this.bs_id,
    required this.pm_id,
    required this.startTime,
    required this.finishTime,
    required this.date,
    required this.workDuration
  });

  factory VisitingDurations.fromJson(Map<String, dynamic> json) {
    return VisitingDurations(
      shopCode: json["magaza_kodu"],
      bs_id: json['bs_id'],
      pm_id: json['pm_id'],
      startTime: json['baslangic_saati'],
      finishTime: json['bitis_saati'],
      date: json['tarih'],
      workDuration: json['calisma_suresi']
    );
  }

}





