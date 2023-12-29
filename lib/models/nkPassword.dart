class NKPassword{
  late int nk_id;
  late String hashed_pw;

  NKPassword({
    required this.nk_id,
    required this.hashed_pw,
  });

  factory NKPassword.fromJson(Map<String, dynamic> json) {
    return NKPassword(
      nk_id: json['nk_id'],
      hashed_pw: json['hashed_pw'],
    );
  }

}