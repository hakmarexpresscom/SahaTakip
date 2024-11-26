class ShopVisitingFormAnswers{
  late int formID;
  late int? bs_id;
  late int? pm_id;
  late int shopCode;
  late String kayit_tarihi;
  late String formAnswers;

  ShopVisitingFormAnswers({
    required this.formID,
    required this.bs_id,
    required this.pm_id,
    required this.shopCode,
    required this.kayit_tarihi,
    required this.formAnswers
  });

  factory ShopVisitingFormAnswers.fromJson(Map<String, dynamic> json) {
    return ShopVisitingFormAnswers(
      formID: json['form_id'],
      bs_id: json['bs_id'],
      pm_id: json['pm_id'],
      shopCode: json['magaza_kodu'],
      kayit_tarihi: json['kayit_tarihi'],
      formAnswers: json['cevaplar'],
    );
  }

}


