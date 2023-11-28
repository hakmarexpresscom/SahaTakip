class InShopOpenControl{
  late int magaza_kodu;
  late int? bs_id;
  late int? pm_id;
  late String? kayit_tarihi;
  late int magaza_duzeni;
  late int isitici_klima;
  late int manav_duzeni;
  late int kasa_alti_poset;
  late int ofis_depo_cop;
  late int mutfak_wc_temizlik;
  late int kasa_alti_resmi_evrak;
  late int skt_kontrol;
  late int priz_cihaz;
  late int kasa_temizligi;
  late int kasa_cekmecesi;
  late int gunluk_evrak;
  late int kasa_alti_cop;
  late int zemin_temizligi;
  late int kasiyer_defteri;
  late int wc_musluk;
  late int kamera_kaydi;
  late int magaza_anahtari;
  late int kasa_etrafi_duzeni;
  late int poset;
  late int ofis_depo_kapi;

  InShopOpenControl({
    required this.magaza_kodu,
    required this.bs_id,
    required this.pm_id,
    required this.kayit_tarihi,
    required this.magaza_duzeni,
    required this.isitici_klima,
    required this.manav_duzeni,
    required this.kasa_alti_poset,
    required this.ofis_depo_cop,
    required this.mutfak_wc_temizlik,
    required this.kasa_alti_resmi_evrak,
    required this.skt_kontrol,
    required this.priz_cihaz,
    required this.kasa_temizligi,
    required this.kasa_cekmecesi,
    required this.gunluk_evrak,
    required this.kasa_alti_cop,
    required this.zemin_temizligi,
    required this.kasiyer_defteri,
    required this.wc_musluk,
    required this.kamera_kaydi,
    required this.magaza_anahtari,
    required this.kasa_etrafi_duzeni,
    required this.poset,
    required this.ofis_depo_kapi
  });

  factory InShopOpenControl.fromJson(Map<String, dynamic> json) {
    return InShopOpenControl(
      magaza_kodu: json['magaza_kodu'],
      bs_id: json['bs_id'],
      pm_id: json['pm_id'],
      kayit_tarihi: json['kayit_tarihi'],
      magaza_duzeni: json['magaza_duzeni'],
      isitici_klima: json['isitici_klima'],
      manav_duzeni: json['manav_duzeni'],
      kasa_alti_poset: json['kasa_alti_poset'],
      ofis_depo_cop: json['ofis_depo_cop'],
      mutfak_wc_temizlik: json['mutfak_wc_temizlik'],
      kasa_alti_resmi_evrak: json['kasa_alti_resmi_evrak'],
      skt_kontrol: json['skt_kontrol'],
      priz_cihaz: json['priz_cihaz'],
      kasa_temizligi: json['kasa_temizligi'],
      kasa_cekmecesi: json['kasa_cekmecesi'],
      gunluk_evrak: json['gunluk_evrak'],
      kasa_alti_cop: json['kasa_alti_cop'],
      zemin_temizligi: json['zemin_temizligi'],
      kasiyer_defteri: json['kasiyer_defteri'],
      wc_musluk: json['wc_musluk'],
      kamera_kaydi: json['kamera_kaydi'],
      magaza_anahtari: json['magaza_anahtari'],
      kasa_etrafi_duzeni: json['kasa_etrafi_duzeni'],
      poset: json['poset'],
      ofis_depo_kapi: json['ofis_depo_kapi'],
    );
  }
}

class OutShopOpenControl{
  late int magaza_kodu;
  late int? bs_id;
  late int? pm_id;
  late String? kayit_tarihi;
  late int alarm;
  late int kapi_kepenk;
  late int uygun_zaman;
  late int personel_sayisi;
  late int anahtar;

  OutShopOpenControl({
    required this.magaza_kodu,
    required this.bs_id,
    required this.pm_id,
    required this.kayit_tarihi,
    required this.alarm,
    required this.kapi_kepenk,
    required this.uygun_zaman,
    required this.personel_sayisi,
    required this.anahtar
  });

  factory OutShopOpenControl.fromJson(Map<String, dynamic> json) {
    return OutShopOpenControl(
      magaza_kodu: json['magaza_kodu'],
      bs_id: json['bs_id'],
      pm_id: json['pm_id'],
      kayit_tarihi: json['kayit_tarihi'],
      alarm: json['alarm'],
      kapi_kepenk: json['kapi_kepenk'],
      uygun_zaman: json['uygun_zaman'],
      personel_sayisi: json['presonel_sayisi'],
      anahtar: json['anahtar'],
    );
  }

}


