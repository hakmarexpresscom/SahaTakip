class Shift{
  late int shift_id;
  late int bs_id;
  late int pm_id;
  late String shiftType;
  late String shiftDate;
  late String startTime;
  late String finishTime;
  late int shopCode;

  Shift({
    required this.shift_id,
    required this.bs_id,
    required this.pm_id,
    required this.shiftType,
    required this.shiftDate,
    required this.startTime,
    required this.finishTime,
    required this.shopCode
  });

  factory Shift.fromJson(Map<String, dynamic> json) {
    return Shift(
      shift_id: json["mesai_id"],
      bs_id: json['bs_id'],
      pm_id: json['pm_id'],
      shiftType: json['mesai_turu'],
      shiftDate: json['mesai_tarihi'],
      startTime: json['baslangic_saati'],
      finishTime: json['bitis_tarihi'],
      shopCode: json['magaza_kodu'],
    );
  }

}





