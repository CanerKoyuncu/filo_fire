import 'package:filo_fire/models/driver_model.dart';
import 'package:filo_fire/models/vehicle_model.dart';
import 'package:filo_fire/view/main_screen/tabs/car_list/get_car/driver_info/add_driver_view.dart';
import 'package:filo_fire/view/main_screen/tabs/car_list/get_car/driver_info/set_driver_view.dart';
import 'package:filo_fire/view/main_screen/widgets/custom_date_text.dart';
import 'package:flutter/material.dart';

class DriverView extends StatelessWidget {
  late DriverModel driverData;
  late VehicleModel vehicleModel;
  DriverView({
    super.key,
    required this.driverData,
    required this.vehicleModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              //TODO: güncelleme yapılması gerekiyor.
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SetDriverView(
                      vehicleModel: vehicleModel,
                      firstName: driverData.firstName,
                      lastName: driverData.lastName,
                      licenseNumber: driverData.licenseNumber,
                      phoneNumber: driverData.phoneNumber,
                      licenseIssueDate: driverData.licenseIssueDate,
                    ),
                  ));
            },
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: Column(
        //TODO: sayfa düzeni yapılacak.
        children: [
          Row(
            children: [
              Text("Adı: "),
              Text(driverData.firstName),
            ],
          ),
          Row(
            children: [
              const Text("Soyadı: "),
              Text(driverData.lastName),
            ],
          ),
          Row(
            children: [
              const Text("Ehliyet Numarası: "),
              Text(driverData.licenseNumber),
            ],
          ),
          Row(
            children: [
              const Text("Ehliyet geçerlilik tarihi: "),
              customDateText(driverData.licenseIssueDate),
            ],
          ),
          Row(
            children: [
              Text("Telefon Numarası: "),
              Text(driverData.phoneNumber),
            ],
          ),
        ],
      ),
    );
  }
}
