class DriverModel {
  String firstName = '';
  String lastName;
  String licenseNumber;
  DateTime licenseIssueDate;
  String phoneNumber;
  String? driverID;
  // Add other driver details as needed.

  DriverModel(
      {required this.firstName,
      required this.lastName,
      required this.licenseNumber,
      required this.licenseIssueDate,
      required this.phoneNumber,
      this.driverID});

  factory DriverModel.fromJson(Object json, String id) {
    json = json as Map<String, dynamic>;
    return DriverModel(
      firstName: json['firstName'],
      lastName: json['lastName'],
      licenseNumber: json['licenseNumber'],
      licenseIssueDate: DateTime.parse(json['licenseIssueDate']),
      phoneNumber: json['phoneNumber'],
      driverID: json['driverID'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'licenseNumber': licenseNumber,
      'licenseIssueDate': licenseIssueDate.toIso8601String(),
      'phoneNumber': phoneNumber,
      'driverID': driverID,
    };
  }
}
