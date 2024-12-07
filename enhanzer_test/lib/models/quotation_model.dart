class Item {
  final int id;
  final String itemName;
  final double price;

  Item({required this.id, required this.itemName, required this.price});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      itemName: json['itemName'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'itemName': itemName,
      'price': price,
    };
  }
}
