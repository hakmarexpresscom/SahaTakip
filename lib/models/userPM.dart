class UserPM{
  late int pm_id;
  late String userName;
  late String userSurname;
  late String email;
  late int manager_id;
  late String userType;
  late int group_no;
  late int isActive;
  late int? bolge;

  UserPM({
    required this.pm_id,
    required this.userName,
    required this.userSurname,
    required this.email,
    required this.manager_id,
    required this.userType,
    required this.group_no,
    required this.isActive,
    required this.bolge
  });

  factory UserPM.fromJson(Map<String, dynamic> json) {
    return UserPM(
      pm_id: json['pm_id'],
      userName: json['kullanici_ismi'],
      userSurname: json['kullanici_soyismi'],
      email: json['email'],
      manager_id: json['yonetici_id'],
      userType: json['kullanici_turu'],
      group_no: json['grup_no'],
      isActive: json['isActive'],
      bolge: json['bolge'],
    );
  }

}