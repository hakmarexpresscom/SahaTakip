class Shift{
  late int userID;
  late int userSAPID;
  late String shiftType;
  late DateTime Date;
  late DateTime startHour;
  late DateTime finishHour;
  late int shopCode;

  Shift({
    required this.userID,
    required this.userSAPID,
    required this.shiftType,
    required this.Date,
    required this.startHour,
    required this.finishHour,
    required this.shopCode
  });

  factory Shift.fromJson(Map<String, dynamic> json) {
    return Shift(
      userID: json['Kullanici_ID'],
      userSAPID: json['Kullanici_SAPID'],
      shiftType: json['Mesai_Turu'],
      Date: json['Tarih'],
      startHour: json['Baslangic_Saati'],
      finishHour: json['Bitis_Saati'],
      shopCode: json['Magaza_Kodu'],
    );
  }

}


