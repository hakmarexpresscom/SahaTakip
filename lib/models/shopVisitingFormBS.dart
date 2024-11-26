class ShopVisitingFormBS{
  late int itemID;
  late String itemName;
  late int isActive;

  ShopVisitingFormBS({
    required this.itemID,
    required this.itemName,
    required this.isActive,
  });

  factory ShopVisitingFormBS.fromJson(Map<String, dynamic> json) {
    return ShopVisitingFormBS(
      itemID: json['itemID'],
      itemName: json['itemName'],
      isActive: json['isActive'],
    );
  }

}


