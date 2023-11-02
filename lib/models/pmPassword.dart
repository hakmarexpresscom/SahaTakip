import 'dart:typed_data';

class PMPassword{
  late int pm_id;
  late String hashed_pw;

  PMPassword({
    required this.pm_id,
    required this.hashed_pw,
  });

  factory PMPassword.fromJson(Map<String, dynamic> json) {
    return PMPassword(
      pm_id: json['pm_id'],
      hashed_pw: json['hashed_pw'],
    );
  }

}