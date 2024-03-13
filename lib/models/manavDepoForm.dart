class ManavDepoForm{
  late int formID;
  late int magaza_kodu;
  late int? bs_id;
  late int? pm_id;
  late String kayit_tarihi;
  late int manav_sevkiyat;
  late int bozuk_urun;
  late int sb_cikislari;
  late int sivas_birlik;
  late int ana_kalem_urunleri;
  late int siparis_sevk;
  late int depo_stok;
  late int kalan_urun;
  late int kasa_alani;
  late int depo_calisanlari;

  ManavDepoForm({
    required this.formID,
    required this.magaza_kodu,
    required this.bs_id,
    required this.pm_id,
    required this.kayit_tarihi,
    required this.manav_sevkiyat,
    required this.bozuk_urun,
    required this.sb_cikislari,
    required this.sivas_birlik,
    required this.ana_kalem_urunleri,
    required this.siparis_sevk,
    required this.depo_stok,
    required this.kalan_urun,
    required this.kasa_alani,
    required this.depo_calisanlari
  });

  factory ManavDepoForm.fromJson(Map<String, dynamic> json) {
    return ManavDepoForm(
      formID: json['form_id'],
      magaza_kodu: json['magaza_kodu'],
      bs_id: json['bs_id'],
      pm_id: json['pm_id'],
      kayit_tarihi: json['kayit_tarihi'],
      manav_sevkiyat: json['manav_sevkiyat'],
      bozuk_urun: json['bozuk_urun'],
      sb_cikislari: json['sb_cikislari'],
      sivas_birlik: json['sivas_birlik'],
      ana_kalem_urunleri: json['ana_kalem_urunleri'],
      siparis_sevk: json['siparis_sevk'],
      depo_stok: json['depo_stok'],
      kalan_urun: json['kalan_urun'],
      kasa_alani: json['kasa_alani'],
      depo_calisanlari: json['depo_calisanlari'],
    );
  }
}