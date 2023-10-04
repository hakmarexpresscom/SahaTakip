class Shop{
  late int shop_code;
  late String shop_name;
  late int BS_SAPID;
  late int PM_SAPID;
  late int BM_SAPID;
  late int Lat;
  late int Long;

  Shop({required this.shop_code,required this.shop_name, required this.BS_SAPID, required this.PM_SAPID, required this.BM_SAPID, required this.Lat, required this.Long});

  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      shop_code: json['Magaza_Kodu'],
      shop_name: json['Magaza_Ismi'],
      BS_SAPID: json['BS_SAPID'],
      PM_SAPID: json['PM_SAPID'],
      BM_SAPID: json['BM_SAPID'],
      Lat: json['Lat'],
      Long: json['Long'],
    );
  }

}


