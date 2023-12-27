class UserBS{
  late int bs_id;
  late String userName;
  late String userSurname;
  late String email;
  late int manager_id;
  late String userType;
  late int group_no;


  UserBS({
    required this.bs_id,
    required this.userName,
    required this.userSurname,
    required this.email,
    required this.manager_id,
    required this.userType,
    required this.group_no
  });

  factory UserBS.fromJson(Map<String, dynamic> json) {
    return UserBS(
      bs_id: json['bs_id'],
      userName: json['kullanici_ismi'],
      userSurname: json['kullanici_soyismi'],
      email: json['email'],
      manager_id: json['yonetici_id'],
      userType: json['kullanici_turu'],
      group_no: json['grup_no'],
    );
  }

}