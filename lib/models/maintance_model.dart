class MaintanceModel {
  String? maintanceId;
  String vehicleId;
  String? maintanceType;
  DateTime? maintanceDate;
  String? maintanceDescription;
  double? maintanceCost;

  MaintanceModel({
    this.maintanceId,
    required this.vehicleId,
    this.maintanceType,
    this.maintanceDate,
    this.maintanceDescription,
    this.maintanceCost,
  });

  factory MaintanceModel.fromMap(Map<String, dynamic> map, String maintanceId) {
    return MaintanceModel(
      maintanceId: maintanceId,
      vehicleId: map['vehicleId'] ?? '',
      maintanceType: map['maintanceType'],
      maintanceDate:
          map['maintanceDate'] != null ? (map['maintanceDate']).toDate() : null,
      maintanceDescription: map['maintanceDescription'],
      maintanceCost: map['maintanceCost']?.toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'vehicleId': vehicleId,
      'maintanceType': maintanceType,
      'maintanceDate': maintanceDate,
      'maintanceDescription': maintanceDescription,
      'maintanceCost': maintanceCost,
    };
  }
}
