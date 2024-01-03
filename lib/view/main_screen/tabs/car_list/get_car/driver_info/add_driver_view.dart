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
          controllerPhoneNumber = controllers[3];
          selectedDate = picked;
        });
      }
    }

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
                myController: controllerPhoneNumber,
                hintText: "Sürücünün telefon numarası"),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
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
          Navigator.pop(context);
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
