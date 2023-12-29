class UserNK{
  late int nk_id;
  late String userName;
  late String userSurname;
  late String email;
  late String userType;
  late int isActive;

  UserNK({
    required this.nk_id,
    required this.userName,
    required this.userSurname,
    required this.email,
    required this.userType,
    required this.isActive
  });

  factory UserNK.fromJson(Map<String, dynamic> json) {
    return UserNK(
      nk_id: json['nk_id'],
      userName: json['kullanici_ismi'],
      userSurname: json['kullanici_soyismi'],
      email: json['email'],
      userType: json['kullanici_turu'],
      isActive: json['isActive']
    );
  }

}