class ShopVisitingFormPM{
  late int itemID;
  late String itemName;
  late int isActive;
  late int bolge;

  ShopVisitingFormPM({
    required this.itemID,
    required this.itemName,
    required this.isActive,
    required this.bolge
  });

  factory ShopVisitingFormPM.fromJson(Map<String, dynamic> json) {
    return ShopVisitingFormPM(
      itemID: json['itemID'],
      itemName: json['itemName'],
      isActive: json['isActive'],
      bolge: json['bolge']
    );
  }

}