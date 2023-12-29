class UserBM{
  late int bm_id;
  late String userName;
  late String userSurname;
  late String email;
  late int manager_id;
  late String userType;
  late int regionCode;
  late int isActive;


  UserBM({
    required this.bm_id,
    required this.userName,
    required this.userSurname,
    required this.email,
    required this.manager_id,
    required this.userType,
    required this.regionCode,
    required this.isActive
  });

  factory UserBM.fromJson(Map<String, dynamic> json) {
    return UserBM(
      bm_id: json['bm_id'],
      userName: json['kullanici_ismi'],
      userSurname: json['kullanici_soyismi'],
      email: json['email'],
      manager_id: json['yonetici_id'],
      userType: json['kullanici_turu'],
      regionCode: json['bolge_kodu'],
      isActive: json['isActive']
    );
  }

}


