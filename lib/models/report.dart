class Report{
  late int report_id;
  late int task_id;
  late int pm_id;
  late int shopCode;

  Report({
    required this.report_id,
    required this.task_id,
    required this.pm_id,
    required this.shopCode
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      report_id: json['rapor_id'],
      task_id: json['gorev_id'],
      pm_id: json['pm_id'],
      shopCode: json['magaza_kodu'],
    );
  }

}


