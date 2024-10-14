class Shop{
  late int shopCode;
  late String shopName;
  late int regionCode;
  late int bs_id;
  late int pm_id;
  late int bm_id;
  late String Lat;
  late String Long;
  late int bs_manav_id;
  late int pm_manav_id;
  late int bm_manav_id;
  late int isActive;
  late int bs_unkar_id;
  late int pm_unkar_id;

  Shop({
    required this.shopCode,
    required this.shopName,
    required this.regionCode,
    required this.bs_id,
    required this.pm_id,
    required this.bm_id,
    required this.Lat,
    required this.Long,
    required this.bs_manav_id,
    required this.pm_manav_id,
    required this.bm_manav_id,
    required this.isActive,
    required this.bs_unkar_id,
    required this.pm_unkar_id
  });

  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      shopCode: json['magaza_kodu'],
      shopName: json['magaza_ismi'],
      regionCode: json['bolge_kodu'],
      bs_id: json['bs_id'],
      pm_id: json['pm_id'],
      bm_id: json['bm_id'],
      Lat: json['lat'],
      Long: json['long'],
      bs_manav_id: json['bs_manav_id'],
      pm_manav_id: json['pm_manav_id'],
      bm_manav_id: json['bm_manav_id'],
      isActive: json['isActive'],
      bs_unkar_id: json['bs_unkar_id'],
      pm_unkar_id: json['pm_unkar_id'],
    );
  }

}


