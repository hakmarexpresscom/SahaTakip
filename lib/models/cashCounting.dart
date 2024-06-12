class CashCounting{
  late int shopCode;
  late int shopName;
  late int? bs_id;
  late int? pm_id;
  late String kayit_tarihi;
  late String kagit_para_sayimi;
  late String madeni_para_sayimi;
  late String poslar_toplami;
  late String masraflar_tediyeler;
  late String celik_kasa_mevcudu;
  late String kasa_defter_mevcudu;
  late String fark;

  CashCounting({
    required this.shopCode,
    required this.shopName,
    required this.bs_id,
    required this.pm_id,
    required this.kayit_tarihi,
    required this.kagit_para_sayimi,
    required this.madeni_para_sayimi,
    required this.poslar_toplami,
    required this.masraflar_tediyeler,
    required this.celik_kasa_mevcudu,
    required this.kasa_defter_mevcudu,
    required this.fark
  });

  factory CashCounting.fromJson(Map<String, dynamic> json) {
    return CashCounting(
      shopCode: json['magaza_kodu'],
      shopName: json['magaza_ismi'],
      bs_id: json['bs_id'],
      pm_id: json['pm_id'],
      kayit_tarihi: json['kayit_tarihi'],
      kagit_para_sayimi: json['kagit_para_sayimi'],
      madeni_para_sayimi: json['madeni_para_sayimi'],
      poslar_toplami: json['poslar_toplami'],
      masraflar_tediyeler: json['masraflar_tediyeler'],
      celik_kasa_mevcudu: json['celik_kasa_mevcudu'],
      kasa_defter_mevcudu: json['kasa_defter_mevcudu'],
      fark: json['fark']
    );
  }

}


