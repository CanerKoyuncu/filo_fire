import 'package:filo_fire/models/driver_model.dart';
import 'package:filo_fire/models/vehicle_model.dart';
import 'package:filo_fire/network/fleet_network.dart';
import 'package:filo_fire/view/authanticate/widgets/CustomTextField.dart';
import 'package:flutter/material.dart';

class SetDriverView extends StatefulWidget {
  late VehicleModel vehicleModel;

  String? firstName;
  String? lastName;
  String? licenseNumber;
  String? phoneNumber;
  DateTime? licenseIssueDate;
  SetDriverView({
    super.key,
    required this.vehicleModel,
    this.firstName,
    this.lastName,
    this.licenseNumber,
    this.phoneNumber,
    this.licenseIssueDate,
  });

  @override
  State<SetDriverView> createState() => _SetDriverViewState();
}

class _SetDriverViewState extends State<SetDriverView> {
  var contollerDriverFirstName = TextEditingController();
  var controllerDriverLastName = TextEditingController();
  var controllerDriverLicenseNumber = TextEditingController();
  var controllerLicenseIssueDate = TextEditingController();
  var controllerPhoneNumber = TextEditingController();
  DateTime selectedDate = DateTime.now();
  @override
  void initState() {
    //TODO: Güncelleme yapmak için uygun hale getirmemiz gerek.
    if (widget.firstName != null) {
      contollerDriverFirstName.text = widget.firstName.toString();
    }
    if (widget.lastName != null) {
      controllerDriverLastName.text = widget.lastName.toString();
    }
    if (widget.licenseNumber != null) {
      controllerDriverLicenseNumber.text = widget.licenseNumber.toString();
    }
    if (widget.phoneNumber != null) {
      controllerPhoneNumber.text = widget.phoneNumber.toString();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _selectDate(
        BuildContext context, List<TextEditingController> controllers) async {
      DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime.now().toLocal(),
          lastDate: DateTime(2050));
      if (picked != null && picked != selectedDate) {
        setState(() {
          contollerDriverFirstName = controllers[0];
          controllerDriverLastName = controllers[1];
          controllerDriverLicenseNumber = controllers[2];
          controllerPhoneNumber = controllers[4];
          selectedDate = picked;
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sürücü ekle"),
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
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Text("Ehliyet geçerlilik tarihi:"),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  ElevatedButton(
                    onPressed: () => _selectDate(context, [
                      contollerDriverFirstName,
                      controllerDriverLastName,
                      controllerDriverLicenseNumber,
                      controllerPhoneNumber
                    ]),
                    child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.date_range),
                          Text("${selectedDate.toLocal()}".split(' ')[0]),
                        ]),
                  ),
                ],
              ),
            ),
            CustomTextField(
                myController: controllerPhoneNumber,
                hintText: "Sürücünün telefon numarası"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          print("DATA DRİVER: " +
              DriverModel(
                firstName: contollerDriverFirstName.text,
                lastName: controllerDriverLastName.text,
                licenseNumber: controllerDriverLicenseNumber.text,
                licenseIssueDate: selectedDate,
                phoneNumber: controllerPhoneNumber.text,
              ).toJson().toString());
          await FleetNetwork().updateDriverData(
              widget.vehicleModel.driverID!,
              DriverModel(
                firstName: contollerDriverFirstName.text,
                lastName: controllerDriverLastName.text,
                licenseNumber: controllerDriverLicenseNumber.text,
                licenseIssueDate: selectedDate,
                phoneNumber: controllerPhoneNumber.text,
              ));

          Navigator.pop(context);
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
