class NewVersion{
  late int id;
  late String versiyon_list;

  NewVersion({
    required this.id,
    required this.versiyon_list,
  });

  factory NewVersion.fromJson(Map<String, dynamic> json) {
    return NewVersion(
      id: json['id'],
      versiyon_list: json['versiyon_list'],
    );
  }

}