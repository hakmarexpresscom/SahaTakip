class ManavShopForm{
  late int formID;
  late int magaza_kodu;
  late int? bs_id;
  late int? pm_id;
  late String kayit_tarihi;
  late int manav_duzeni;
  late int manav_fifo;
  late int dizilim;
  late int aktif_urun;
  late int halk_gunu;
  late int afis;
  late int kunye;
  late int fiyat_degisikligi;
  late int magaza_etiket;
  late int cikma_bolumu;
  late int kuruyemis_standi;
  late int kasa_terazileri;
  late int manav_baskulu;
  late int manav_stogu;
  late int manav_kasa;
  late int kasa_alani_duzeni;
  late int dogru_siparis;
  late int hatali_kodu;
  late int cekleme;
  late int personel_giris_cikis;
  late int fire_cikisi;
  late int ciro;
  late int personel_duzen_temizlik;

  ManavShopForm({
    required this.formID,
    required this.magaza_kodu,
    required this.bs_id,
    required this.pm_id,
    required this.kayit_tarihi,
    required this.manav_duzeni,
    required this.manav_fifo,
    required this.dizilim,
    required this.aktif_urun,
    required this.halk_gunu,
    required this.afis,
    required this.kunye,
    required this.fiyat_degisikligi,
    required this.magaza_etiket,
    required this.cikma_bolumu,
    required this.kuruyemis_standi,
    required this.kasa_terazileri,
    required this.manav_baskulu,
    required this.manav_stogu,
    required this.manav_kasa,
    required this.kasa_alani_duzeni,
    required this.dogru_siparis,
    required this.hatali_kodu,
    required this.cekleme,
    required this.personel_giris_cikis,
    required this.fire_cikisi,
    required this.ciro,
    required this.personel_duzen_temizlik
  });

  factory ManavShopForm.fromJson(Map<String, dynamic> json) {
    return ManavShopForm(
      formID: json['form_id'],
      magaza_kodu: json['magaza_kodu'],
      bs_id: json['bs_id'],
      pm_id: json['pm_id'],
      kayit_tarihi: json['kayit_tarihi'],
      manav_duzeni: json['manav_duzeni'],
      manav_fifo: json['manav_fifo'],
      dizilim: json['dizilim'],
      aktif_urun: json['aktif_urun'],
      halk_gunu: json['halk_gunu'],
      afis: json['afis'],
      kunye: json['kunye'],
      fiyat_degisikligi: json['fiyat_degisikligi'],
      magaza_etiket: json['magaza_etiket'],
      cikma_bolumu: json['cikma_bolumu'],
      kuruyemis_standi: json['kuruyemis_standi'],
      kasa_terazileri: json['kasa_terazileri'],
      manav_baskulu: json['manav_baskulu'],
      manav_stogu: json['manav_stogu'],
      manav_kasa: json['manav_kasa'],
      kasa_alani_duzeni: json['kasa_alani_duzeni'],
      dogru_siparis: json['dogru_siparis'],
      hatali_kodu: json['hatali_kodu'],
      cekleme: json['cekleme'],
      personel_giris_cikis: json['personel_giris_cikis'],
      fire_cikisi: json['fire_cikisi'],
      ciro: json['ciro'],
      personel_duzen_temizlik: json['personel_duzen_temizlik'],
    );
  }
}