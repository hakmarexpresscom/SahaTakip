class Version{
  late String version;

  Version({
    required this.version,
  });

  factory Version.fromJson(Map<String, dynamic> json) {
    return Version(
      version: json['version'],
    );
  }

}