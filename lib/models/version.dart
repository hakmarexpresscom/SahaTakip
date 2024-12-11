class Version{
  late int id;
  late String version_list;

  Version({
    required this.id,
    required this.version_list,
  });

  factory Version.fromJson(Map<String, dynamic> json) {
    return Version(
      id: json['id'],
      version_list: json['versiyon_list'],
    );
  }

}