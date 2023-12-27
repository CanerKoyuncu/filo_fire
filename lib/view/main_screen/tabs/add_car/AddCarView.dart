import 'package:filo_fire/models/vehicle_model.dart';
import 'package:filo_fire/network/auth_operations.dart';
import 'package:filo_fire/network/fleet_network.dart';
import 'package:filo_fire/view/authanticate/widgets/CustomTextField.dart';
import 'package:flutter/material.dart';

class AddCarView extends StatefulWidget {
  const AddCarView({super.key});

  @override
  State<AddCarView> createState() => _AddCarViewState();
}

class _AddCarViewState extends State<AddCarView> {
  var controllerBrand = TextEditingController();
  var controllerModel = TextEditingController();
  var controllerProductionYear = TextEditingController();
  var controllerColor = TextEditingController();
  var controllerPlate = TextEditingController();
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    Future<void> _selectDate(
        BuildContext context, List<TextEditingController> controllers) async {
      DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(1900),
          lastDate: DateTime.now());
      if (picked != null && picked != selectedDate) {
        setState(() {
          controllerBrand = controllers[0];
          controllerModel = controllers[1];
          controllerProductionYear = controllers[2];
          controllerColor = controllers[3];
          controllerPlate = controllers[4];
          selectedDate = picked;
        });
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text("Araç Ekle")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomTextField(myController: controllerBrand, hintText: "Marka"),
            CustomTextField(myController: controllerModel, hintText: "Model"),
            CustomTextField(
              myController: controllerProductionYear,
              hintText: "Model Yılı",
            ),
            CustomTextField(myController: controllerColor, hintText: "Renk"),
            CustomTextField(myController: controllerPlate, hintText: "Plaka"),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("${selectedDate.toLocal()}".split(' ')[0]),
                  const SizedBox(
                    height: 20.0,
                  ),
                  ElevatedButton(
                    onPressed: () => _selectDate(context, [
                      controllerBrand,
                      controllerModel,
                      controllerProductionYear,
                      controllerColor,
                      controllerPlate
                    ]),
                    child: const Text('Select date'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          FleetNetwork().addVehicle(
            VehicleModel(
              userId: AuthOperations().getCurrentUser()!.uid,
              brand: controllerBrand.text,
              model: controllerModel.text,
              plate: controllerPlate.text,
              productionYear: controllerProductionYear.text,
              color: controllerColor.text,
            ),
          );
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
