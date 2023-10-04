class Shop{
  late int shop_code;
  late String shop_name;
  late int BS_SAPID;
  late int PM_SAPID;
  late int BM_SAPID;
  late int LAT;
  late int LONG;

  Shop({required this.shop_code,required this.shop_name, required this.BS_SAPID, required this.PM_SAPID, required this.BM_SAPID, required this.LAT, required this.LONG});

  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      shop_code: json['kod'],
      shop_name: json['isim'],
      BS_SAPID: json['bs_sapid'],
      PM_SAPID: json['pm_sapid'],
      BM_SAPID: json['bm_sapid'],
      LAT: json['lat'],
      LONG: json['long'],
    );
  }

}


