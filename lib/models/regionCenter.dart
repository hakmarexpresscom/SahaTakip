class RegionCenter{
  late int centerCode;
  late String centerName;
  late String Lat;
  late String Long;

  RegionCenter({
    required this.centerCode,
    required this.centerName,
    required this.Lat,
    required this.Long,
  });

  factory RegionCenter.fromJson(Map<String, dynamic> json) {
    return RegionCenter(
      centerCode: json['merkez_kodu'],
      centerName: json['merkez_ismi'],
      Lat: json['lat'],
      Long: json['long'],
    );
  }

}


