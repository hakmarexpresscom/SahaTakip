class ShopVisitingFormPM{
  late int itemID;
  late String itemName;
  late int isActive;

  ShopVisitingFormPM({
    required this.itemID,
    required this.itemName,
    required this.isActive,
  });

  factory ShopVisitingFormPM.fromJson(Map<String, dynamic> json) {
    return ShopVisitingFormPM(
      itemID: json['itemID'],
      itemName: json['itemName'],
      isActive: json['isActive'],
    );
  }

}