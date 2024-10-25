class TedarikZinciriForm{
  late int formID;
  late int magaza_kodu;
  late String magaza_ismi;
  late int? bs_id;
  late int? pm_id;
  late String kayit_tarihi;
  late String fazla_urun;
  late int toplatma;
  late int fire_alani;
  late int planogram;
  late int g_spot;
  late int sarkuteri;
  late int dolap_stogu;
  late int etiket;
  late int skt_fiyat;
  late int teshir_stant;
  late int musteri_talebi;

  TedarikZinciriForm({
    required this.formID,
    required this.magaza_kodu,
    required this.magaza_ismi,
    required this.bs_id,
    required this.pm_id,
    required this.kayit_tarihi,
    required this.fazla_urun,
    required this.toplatma,
    required this.fire_alani,
    required this.planogram,
    required this.g_spot,
    required this.sarkuteri,
    required this.dolap_stogu,
    required this.etiket,
    required this.skt_fiyat,
    required this.teshir_stant,
    required this.musteri_talebi
  });

  factory TedarikZinciriForm.fromJson(Map<String, dynamic> json) {
    return TedarikZinciriForm(
      formID: json['form_id'],
      magaza_kodu: json['magaza_kodu'],
      magaza_ismi: json['magaza_ismi'],
      bs_id: json['bs_id'],
      pm_id: json['pm_id'],
      kayit_tarihi: json['kayit_tarihi'],
      fazla_urun: json['fazla_urun'],
      toplatma: json['toplatma'],
      fire_alani: json['fire_alani'],
      planogram: json['planogram'],
      g_spot: json['g_spot'],
      sarkuteri: json['sarkuteri'],
      dolap_stogu: json['dolap_stogu'],
      etiket: json['etiket'],
      skt_fiyat: json['skt_fiyat'],
      teshir_stant: json['teshir_stant'],
      musteri_talebi: json['musteri_talebi'],
    );
  }
}