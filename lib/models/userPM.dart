class UserPM{
  late int pm_id;
  late int user_sapid;
  late String userName;
  late String userSurname;
  late String email;
  late int manager_id;
  late String userType;
  late int isManav;


  UserPM({
    required this.pm_id,
    required this.user_sapid,
    required this.userName,
    required this.userSurname,
    required this.email,
    required this.manager_id,
    required this.userType,
    required this.isManav
  });

  factory UserPM.fromJson(Map<String, dynamic> json) {
    return UserPM(
      pm_id: json['pm_id'],
      user_sapid: json['kullanici_sapid'],
      userName: json['kullanici_ismi'],
      userSurname: json['kullanici_soyismi'],
      email: json['email'],
      manager_id: json['yonetici_id'],
      userType: json['kullanici_turu'],
      isManav: json['isManav'],
    );
  }

}