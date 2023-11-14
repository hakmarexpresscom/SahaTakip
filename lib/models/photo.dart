class Photo{
  late int photo_id;
  late int task_id;
  late int shopCode;
  late int? bs_id;
  late int? pm_id;
  late int? bm_id;
  late String photoType;
  late String photo_file;

  Photo({
    required this.photo_id,
    required this.task_id,
    required this.shopCode,
    required this.bs_id,
    required this.pm_id,
    required this.bm_id,
    required this.photoType,
    required this.photo_file
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      photo_id: json['foto_id'],
      task_id: json['gorev_id'],
      shopCode: json['magaza_kodu'],
      bs_id: json['bs_id'],
      pm_id: json['pm_id'],
      bm_id: json['bm_id'],
      photoType: json['foto_turu'],
      photo_file: json['foto_file']
    );
  }

}


