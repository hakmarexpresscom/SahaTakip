import 'dart:typed_data';

class BMPassword{
  late int bm_id;
  late String hashed_pw;

  BMPassword({
    required this.bm_id,
    required this.hashed_pw,
  });

  factory BMPassword.fromJson(Map<String, dynamic> json) {
    return BMPassword(
      bm_id: json['bm_id'],
      hashed_pw: json['hashed_pw'],
    );
  }

}