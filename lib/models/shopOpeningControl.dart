class InShopOpenControl{
  late int formID;
  late int magaza_kodu;
  late int? bs_id;
  late int? pm_id;
  late String kayit_tarihi;
  late int gunluk_evrak;
  late int kasiyer_defteri;
  late int skt_kontrolu;
  late int kasa_alti_poset;
  late int kasa_alti_cop;
  late int ofis_depo_kapi;
  late int kasa_cekmecesi;
  late int kasa_alti_resmi_evrak;
  late int wc_musluk;
  late int kasa_temizligi;
  late int magaza_anahtari;
  late int mutfak_wc_temizlik;
  late int magaza_duzeni;
  late int ofis_depo_cop;
  late int priz_cihaz;
  late int kamera_kaydi;
  late int zemin_temizligi;
  late int kasa_etrafi_duzeni;
  late int manav_duzeni;
  late int poset;
  late int isitici_klima;

  InShopOpenControl({
    required this.formID,
    required this.magaza_kodu,
    required this.bs_id,
    required this.pm_id,
    required this.kayit_tarihi,
    required this.gunluk_evrak,
    required this.kasiyer_defteri,
    required this.skt_kontrolu,
    required this.kasa_alti_poset,
    required this.kasa_alti_cop,
    required this.ofis_depo_kapi,
    required this.kasa_cekmecesi,
    required this.kasa_alti_resmi_evrak,
    required this.wc_musluk,
    required this.kasa_temizligi,
    required this.magaza_anahtari,
    required this.mutfak_wc_temizlik,
    required this.magaza_duzeni,
    required this.ofis_depo_cop,
    required this.priz_cihaz,
    required this.kamera_kaydi,
    required this.zemin_temizligi,
    required this.kasa_etrafi_duzeni,
    required this.manav_duzeni,
    required this.poset,
    required this.isitici_klima,
  });

  factory InShopOpenControl.fromJson(Map<String, dynamic> json) {
    return InShopOpenControl(
      formID: json['form_id'],
      magaza_kodu: json['magaza_kodu'],
      bs_id: json['bs_id'],
      pm_id: json['pm_id'],
      kayit_tarihi: json['kayit_tarihi'],
      gunluk_evrak: json['gunluk_evrak'],
      kasiyer_defteri: json['kasiyer_defteri'],
      skt_kontrolu: json['skt_kontrolu'],
      kasa_alti_poset: json['kasa_alti_poset'],
      kasa_alti_cop: json['kasa_alti_cop'],
      ofis_depo_kapi: json['ofis_depo_kapi'],
      kasa_cekmecesi: json['kasa_cekmecesi'],
      kasa_alti_resmi_evrak: json['kasa_alti_resmi_evrak'],
      wc_musluk: json['wc_musluk'],
      kasa_temizligi: json['kasa_temizligi'],
      magaza_anahtari: json['magaza_anahtari'],
      mutfak_wc_temizlik: json['mutfak_wc_temizlik'],
      magaza_duzeni: json['magaza_duzeni'],
      ofis_depo_cop: json['ofis_depo_cop'],
      priz_cihaz: json['priz_cihaz'],
      kamera_kaydi: json['kamera_kaydi'],
      zemin_temizligi: json['zemin_temizligi'],
      kasa_etrafi_duzeni: json['kasa_etrafi_duzeni'],
      manav_duzeni: json['manav_duzeni'],
      poset: json['poset'],
      isitici_klima: json['isitici_klima'],
    );
  }
}

class OutShopOpenControl{
  late int formID;
  late int magaza_kodu;
  late int? bs_id;
  late int? pm_id;
  late String kayit_tarihi;
  late int alarm;
  late int personel_sayisi;
  late int uygun_zaman;
  late int kapi_kepenk;
  late int anahtar;

  OutShopOpenControl({
    required this.formID,
    required this.magaza_kodu,
    required this.bs_id,
    required this.pm_id,
    required this.kayit_tarihi,
    required this.alarm,
    required this.personel_sayisi,
    required this.uygun_zaman,
    required this.kapi_kepenk,
    required this.anahtar
  });

  factory OutShopOpenControl.fromJson(Map<String, dynamic> json) {
    return OutShopOpenControl(
      formID: json['form_id'],
      magaza_kodu: json['magaza_kodu'],
      bs_id: json['bs_id'],
      pm_id: json['pm_id'],
      kayit_tarihi: json['kayit_tarihi'],
      alarm: json['alarm'],
      personel_sayisi: json['personel_sayisi'],
      uygun_zaman: json['uygun_zaman'],
      kapi_kepenk: json['kapi_kepenk'],
      anahtar: json['anahtar'],
    );
  }

}


