class InShopCloseControl{
  late int formID;
  late int magaza_kodu;
  late String magaza_ismi;
  late int? bs_id;
  late int? pm_id;
  late String kayit_tarihi;
  late int priz_cihaz;
  late int dolap_aydinlatma;
  late int kamera_kayit;
  late int mutfak_wc_temizlik;
  late int kasa_cekmece;
  late int kasa_alti_poset;
  late int kasa_etrafi_duzeni;
  late int magaza_duzeni;
  late int wc_musluk;
  late int gunluk_evrak;
  late int zemin_temizligi;
  late int ofis_depo_kapi;
  late int isitici_klima;
  late int ofis_depo_cop;
  late int kasa_alti_resmi_evrak;
  late int kasa_temizligi;
  late int kasiyer_defteri;
  late int stk_kontrolu;
  late int manav_duzeni;
  late int kasa_alti_cop;

  InShopCloseControl({
    required this.formID,
    required this.magaza_kodu,
    required this.magaza_ismi,
    required this.bs_id,
    required this.pm_id,
    required this.kayit_tarihi,
    required this.priz_cihaz,
    required this.dolap_aydinlatma,
    required this.kamera_kayit,
    required this.mutfak_wc_temizlik,
    required this.kasa_cekmece,
    required this.kasa_alti_poset,
    required this.kasa_etrafi_duzeni,
    required this.magaza_duzeni,
    required this.wc_musluk,
    required this.gunluk_evrak,
    required this.zemin_temizligi,
    required this.ofis_depo_kapi,
    required this.isitici_klima,
    required this.ofis_depo_cop,
    required this.kasa_alti_resmi_evrak,
    required this.kasa_temizligi,
    required this.kasiyer_defteri,
    required this.stk_kontrolu,
    required this.manav_duzeni,
    required this.kasa_alti_cop
  });

  factory InShopCloseControl.fromJson(Map<String, dynamic> json) {
    return InShopCloseControl(
      formID: json['form_id'],
      magaza_kodu: json['magaza_kodu'],
      magaza_ismi: json['magaza_ismi'],
      bs_id: json['bs_id'],
      pm_id: json['pm_id'],
      kayit_tarihi: json['kayit_tarihi'],
      priz_cihaz: json['priz_cihaz'],
      dolap_aydinlatma: json['dolap_aydinlatma'],
      kamera_kayit: json['kamera_kayit'],
      mutfak_wc_temizlik: json['mutfak_wc_temizlik'],
      kasa_cekmece: json['kasa_cekmece'],
      kasa_alti_poset: json['kasa_alti_poset'],
      kasa_etrafi_duzeni: json['kasa_etrafi_duzeni'],
      magaza_duzeni: json['magaza_duzeni'],
      wc_musluk: json['wc_musluk'],
      gunluk_evrak: json['gunluk_evrak'],
      zemin_temizligi: json['zemin_temizligi'],
      ofis_depo_kapi: json['ofis_depo_kapi'],
      isitici_klima: json['isitici_klima'],
      ofis_depo_cop: json['ofis_depo_cop'],
      kasa_alti_resmi_evrak: json['kasa_alti_resmi_evrak'],
      kasa_temizligi: json['kasa_temizligi'],
      kasiyer_defteri: json['kasiyer_defteri'],
      stk_kontrolu: json['stk_kontrolu'],
      manav_duzeni: json['manav_duzeni'],
      kasa_alti_cop: json['kasa_alti_cop'],
    );
  }
}

// -------------------------------------

class OutShopCloseControl{
  late int formID;
  late int magaza_kodu;
  late String magaza_ismi;
  late int? bs_id;
  late int? pm_id;
  late String kayit_tarihi;
  late int magaza_karartma;
  late int zemin_temizligi;
  late int alarm;
  late int dolap_perde;
  late int calisan_ayrilma_zamani;
  late int kapi_kepenk;
  late int son_musteri;
  late int kasa_cikisi;

  OutShopCloseControl({
    required this.formID,
    required this.magaza_kodu,
    required this.magaza_ismi,
    required this.bs_id,
    required this.pm_id,
    required this.kayit_tarihi,
    required this.magaza_karartma,
    required this.zemin_temizligi,
    required this.alarm,
    required this.dolap_perde,
    required this.calisan_ayrilma_zamani,
    required this. kapi_kepenk,
    required this. son_musteri,
    required this.kasa_cikisi
  });

  factory OutShopCloseControl.fromJson(Map<String, dynamic> json) {
    return OutShopCloseControl(
      formID: json['form_id'],
      magaza_kodu: json['magaza_kodu'],
      magaza_ismi: json['magaza_ismi'],
      bs_id: json['bs_id'],
      pm_id: json['pm_id'],
      kayit_tarihi: json['kayit_tarihi'],
      magaza_karartma: json['magaza_karartma'],
      zemin_temizligi: json['zemin_temizligi'],
      alarm: json['alarm'],
      dolap_perde: json['dolap_perde'],
      calisan_ayrilma_zamani: json['calisan_ayrilma_zamani'],
      kapi_kepenk: json['kapi_kepenk'],
      son_musteri: json['son_musteri'],
      kasa_cikisi: json['kasa_cikisi'],
    );
  }

}


