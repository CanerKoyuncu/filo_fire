class VehicleModel {
  String? id;
  String userId;
  String brand;
  String model;
  String plate;
  String productionYear;
  String color;

  VehicleModel({
    this.id,
    required this.userId,
    required this.brand,
    required this.model,
    required this.plate,
    required this.productionYear,
    required this.color,
  });

  factory VehicleModel.fromMap(Map<String, dynamic> map, String id) {
    return VehicleModel(
      id: map["id"] ?? '',
      userId: map['userId'] ?? '',
      brand: map['brand'] ?? '',
      model: map['model'] ?? '',
      plate: map['plate'] ?? '',
      productionYear: map['productionYear'] ?? 0,
      color: map['color'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "userId": userId,
      'brand': brand,
      'model': model,
      'plate': plate,
      'productionYear': productionYear,
      'color': color,
    };
  }
}
