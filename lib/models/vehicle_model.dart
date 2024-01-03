import 'dart:core';

class VehicleModel {
  String? id;
  String userId;
  String brand;
  String model;
  String plate;
  String productionYear;
  String? lastMaintanceDate;
  String color;
  String? driverFirstName;
  String? driverID;

  VehicleModel({
    this.id,
    required this.userId,
    required this.brand,
    required this.model,
    required this.plate,
    required this.productionYear,
    this.lastMaintanceDate,
    required this.color,
    this.driverFirstName,
    this.driverID,
  });

  String? get getCarId => id == null ? id : "";

  factory VehicleModel.fromMap(Object map, String id) {
    map = map as Map<String, dynamic>;
    return VehicleModel(
      id: map["id"] ?? '',
      userId: map['userId'] ?? '',
      brand: map['brand'] ?? '',
      model: map['model'] ?? '',
      plate: map['plate'] ?? '',
      productionYear: map['productionYear'] ?? 0,
      lastMaintanceDate: map['lastMaintanceDate'] ?? "",
      color: map['color'] ?? '',
      driverFirstName: map['driverFirstName'] ?? '',
      driverID: map['driverID'] ?? '',
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
      'lastMaintanceDate': lastMaintanceDate,
      'color': color,
      'driverFirstName': driverFirstName,
      'driverID': driverID,
    };
  }
}
