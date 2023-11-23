class BSPassword{
  late int bs_id;
  late String hashed_pw;

  BSPassword({
    required this.bs_id,
    required this.hashed_pw,
  });

  factory BSPassword.fromJson(Map<String, dynamic> json) {
    return BSPassword(
      bs_id: json['bs_id'],
      hashed_pw: json['hashed_pw'],
    );
  }

}