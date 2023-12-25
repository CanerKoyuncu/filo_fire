import 'package:filo_fire/models/driver_model.dart';
import 'package:filo_fire/models/vehicle_model.dart';
import 'package:filo_fire/network/fleet_network.dart';
import 'package:filo_fire/view/authanticate/widgets/CustomTextField.dart';
import 'package:flutter/material.dart';

class AddDriverView extends StatefulWidget {
  late VehicleModel vehicleModel;
  AddDriverView({super.key, required this.vehicleModel});

  @override
  State<AddDriverView> createState() => _AddDriverViewState();
}

class _AddDriverViewState extends State<AddDriverView> {
  var contollerDriverFirstName = TextEditingController();
  var controllerDriverLastName = TextEditingController();
  var controllerDriverLicenseNumber = TextEditingController();
  var controllerLicenseIssueDate = TextEditingController();
  var controllerPhoneNumber = TextEditingController();
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sürücü ekle"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomTextField(
                myController: contollerDriverFirstName,
                hintText: "Sürücünün adı"),
            CustomTextField(
                myController: controllerDriverLastName,
                hintText: "Sürücünün soyadı"),
            CustomTextField(
              myController: controllerDriverLicenseNumber,
              hintText: "Sürücünün ehliyet numarası",
            ),
            CustomTextField(
                myController: controllerLicenseIssueDate,
                hintText: "Sürücünün lisans bitiş tarihi"),
            CustomTextField(
                myController: controllerPhoneNumber,
                hintText: "Sürücünün telefon numarası"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String driverID = await FleetNetwork().addDriver(DriverModel(
              firstName: contollerDriverFirstName.text,
              lastName: controllerDriverLastName.text,
              licenseNumber: controllerDriverLicenseNumber.text,
              licenseIssueDate: selectedDate,
              phoneNumber: controllerPhoneNumber.text));

          FleetNetwork()
              .updateCarDriver(widget.vehicleModel.id.toString(), driverID);
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
