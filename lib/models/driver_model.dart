class DriverModel {
  String firstName;
  String lastName;
  String licenseNumber;
  DateTime licenseIssueDate;
  String phoneNumber;
  // Add other driver details as needed.

  DriverModel({
    required this.firstName,
    required this.lastName,
    required this.licenseNumber,
    required this.licenseIssueDate,
    required this.phoneNumber,
  });

  factory DriverModel.fromJson(Map<String, dynamic> json) {
    return DriverModel(
      firstName: json['firstName'],
      lastName: json['lastName'],
      licenseNumber: json['licenseNumber'],
      licenseIssueDate: DateTime.parse(json['licenseIssueDate']),
      phoneNumber: json['phoneNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'licenseNumber': licenseNumber,
      'licenseIssueDate': licenseIssueDate.toIso8601String(),
      'phoneNumber': phoneNumber,
    };
  }
}
