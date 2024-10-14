class BreadGroupForm{
  late int formID;
  late int magaza_kodu;
  late String magaza_ismi;
  late int? bs_id;
  late int? pm_id;
  late String kayit_tarihi;
  late int afis;
  late int etiket;
  late int dolap_temizligi;
  late int eldiven_poset;
  late int gelis_saati;
  late int iade;
  late int sicak_ekmek;
  late int hanser_aykan;
  late int uno;
  late int kati_grup;

  BreadGroupForm({
    required this.formID,
    required this.magaza_kodu,
    required this.magaza_ismi,
    required this.bs_id,
    required this.pm_id,
    required this.kayit_tarihi,
    required this.afis,
    required this.etiket,
    required this.dolap_temizligi,
    required this.eldiven_poset,
    required this.gelis_saati,
    required this.iade,
    required this.sicak_ekmek,
    required this.hanser_aykan,
    required this.uno,
    required this.kati_grup
  });

  factory BreadGroupForm.fromJson(Map<String, dynamic> json) {
    return BreadGroupForm(
      formID: json['form_id'],
      magaza_kodu: json['magaza_kodu'],
      magaza_ismi: json['magaza_ismi'],
      bs_id: json['bs_id'],
      pm_id: json['pm_id'],
      kayit_tarihi: json['kayit_tarihi'],
      afis: json['manav_sevkiyat'],
      etiket: json['etiket'],
      dolap_temizligi: json['dolap_temizligi'],
      eldiven_poset: json['eldiven_poset'],
      gelis_saati: json['gelis_saati'],
      iade: json['iade'],
      sicak_ekmek: json['sicak_ekmek'],
      hanser_aykan: json['hanser_aykan'],
      uno: json['uno'],
      kati_grup: json['kati_grup'],
    );
  }
}

// -------------------------------------

class TatbakGroupForm{
  late int formID;
  late int magaza_kodu;
  late String magaza_ismi;
  late int? bs_id;
  late int? pm_id;
  late String kayit_tarihi;
  late int urun;
  late int blok;
  late int fifo;
  late int etiket;
  late int haftalik_urun;
  late int afis;
  late int havuz_dolabi;
  late int fire_cikisi;
  late int siparis_oneri;
  late int raf_temizligi;

  TatbakGroupForm({
    required this.formID,
    required this.magaza_kodu,
    required this.magaza_ismi,
    required this.bs_id,
    required this.pm_id,
    required this.kayit_tarihi,
    required this.urun,
    required this.blok,
    required this.fifo,
    required this.etiket,
    required this.haftalik_urun,
    required this.afis,
    required this.havuz_dolabi,
    required this.fire_cikisi,
    required this.siparis_oneri,
    required this.raf_temizligi
  });

  factory TatbakGroupForm.fromJson(Map<String, dynamic> json) {
    return TatbakGroupForm(
      formID: json['form_id'],
      magaza_kodu: json['magaza_kodu'],
      magaza_ismi: json['magaza_ismi'],
      bs_id: json['bs_id'],
      pm_id: json['pm_id'],
      kayit_tarihi: json['kayit_tarihi'],
      urun: json['urun'],
      blok: json['blok'],
      fifo: json['fifo'],
      etiket: json['etiket'],
      haftalik_urun: json['haftalik_urun'],
      afis: json['afis'],
      havuz_dolabi: json['havuz_dolabi'],
      fire_cikisi: json['fire_cikisi'],
      siparis_oneri: json['siparis_oneri'],
      raf_temizligi: json['raf_temizligi'],
    );
  }
}

// -------------------------------------

class FrozenGroupForm{
  late int formID;
  late int magaza_kodu;
  late String magaza_ismi;
  late int? bs_id;
  late int? pm_id;
  late String kayit_tarihi;
  late int dolap_duzeni;
  late int tel_takimlari;
  late int dolap_seviyeleri;
  late int siparis_oneri;
  late int etiket;
  late int bozuk_urun;
  late int dolap_derecesi;

  FrozenGroupForm({
    required this.formID,
    required this.magaza_kodu,
    required this.magaza_ismi,
    required this.bs_id,
    required this.pm_id,
    required this.kayit_tarihi,
    required this.dolap_duzeni,
    required this.tel_takimlari,
    required this.dolap_seviyeleri,
    required this.siparis_oneri,
    required this.etiket,
    required this.bozuk_urun,
    required this.dolap_derecesi,
  });

  factory FrozenGroupForm.fromJson(Map<String, dynamic> json) {
    return FrozenGroupForm(
      formID: json['form_id'],
      magaza_kodu: json['magaza_kodu'],
      magaza_ismi: json['magaza_ismi'],
      bs_id: json['bs_id'],
      pm_id: json['pm_id'],
      kayit_tarihi: json['kayit_tarihi'],
      dolap_duzeni: json['dolap_duzeni'],
      tel_takimlari: json['tel_takimlari'],
      dolap_seviyeleri: json['dolap_seviyeleri'],
      siparis_oneri: json['siparis_oneri'],
      etiket: json['etiket'],
      bozuk_urun: json['bozuk_urun'],
      dolap_derecesi: json['dolap_derecesi'],
    );
  }
}