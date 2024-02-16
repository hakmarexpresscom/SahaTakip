class Center{
  late int centerCode;
  late String centerName;
  late String Lat;
  late String Long;

  Center({
    required this.centerCode,
    required this.centerName,
    required this.Lat,
    required this.Long,
  });

  factory Center.fromJson(Map<String, dynamic> json) {
    return Center(
      centerCode: json['merkez_kodu'],
      centerName: json['merkez_ismi'],
      Lat: json['lat'],
      Long: json['long'],
    );
  }

}


