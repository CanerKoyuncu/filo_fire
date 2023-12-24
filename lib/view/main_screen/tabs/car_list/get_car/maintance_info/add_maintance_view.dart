import 'package:filo_fire/models/maintance_model.dart';
import 'package:filo_fire/models/vehicle_model.dart';
import 'package:filo_fire/network/auth_operations.dart';
import 'package:filo_fire/network/fleet_network.dart';
import 'package:filo_fire/view/authanticate/widgets/CustomTextField.dart';
import 'package:flutter/material.dart';

class AddMaintanceView extends StatefulWidget {
  late String carId;
  AddMaintanceView({super.key, required this.carId});

  @override
  State<AddMaintanceView> createState() => _AddCarViewState();
}

class _AddCarViewState extends State<AddMaintanceView> {
  var controllerDate = TextEditingController();
  var controllerType = TextEditingController();
  var controllerDescription = TextEditingController();
  var controllerCost = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Araç için bakım kaydı ekle"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //TODO: formu tamamla
            CustomTextField(
                myController: controllerDate, hintText: "Bakım Tarihi"),
            CustomTextField(
                myController: controllerType, hintText: "Bakım Tipi"),
            CustomTextField(
              myController: controllerDescription,
              hintText: "Bakım Açıklaması",
            ),
            CustomTextField(
                myController: controllerCost, hintText: "Bakım Ücreti"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          FleetNetwork().createFaultRecord(
            MaintanceModel(
              vehicleId: widget.carId,
              maintanceCost: controllerCost.text,
              maintanceDate: controllerDate.text,
              maintanceDescription: controllerDescription.text,
              maintanceType: controllerType.text,
            ),
          );
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
