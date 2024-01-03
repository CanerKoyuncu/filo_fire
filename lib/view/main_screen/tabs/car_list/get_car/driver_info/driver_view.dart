import 'package:filo_fire/models/driver_model.dart';
import 'package:filo_fire/network/fleet_network.dart';
import 'package:filo_fire/view/main_screen/tabs/car_list/get_car/driver_info/set_driver_view.dart';
import 'package:filo_fire/view/main_screen/widgets/custom_date_text.dart';
import 'package:flutter/material.dart';

class DriverView extends StatefulWidget {
  late String driverID;
  late String carID;

  DriverView({
    super.key,
    required this.carID,
    required this.driverID,
  });

  @override
  State<DriverView> createState() => _DriverViewState();
}

class _DriverViewState extends State<DriverView> {
  late Future<DriverModel?> _driver;

  @override
  void initState() {
    _driver = (FleetNetwork().getDriverWithID(widget.driverID.toString()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _driver,
      builder: (context, snapshot) => Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () async {
                  await FleetNetwork()
                      .deleteDriverData(widget.carID.toString());
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.delete)),
            IconButton(
              onPressed: () async {
                //TODO: güncelleme yapılması gerekiyor.
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SetDriverView(
                        driverID: widget.driverID,
                      ),
                    ));
                setState(() async {
                  print("object:${snapshot}");
                  _driver = (await FleetNetwork()
                          .getDriverWithID(widget.driverID.toString()))
                      as Future<DriverModel?>;
                });
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
                const Text("Adı: "),
                Text(snapshot.data!.firstName),
              ],
            ),
            Row(
              children: [
                const Text("Soyadı: "),
                Text(snapshot.data!.lastName),
              ],
            ),
            Row(
              children: [
                const Text("Ehliyet Numarası: "),
                Text(snapshot.data!.licenseNumber),
              ],
            ),
            Row(
              children: [
                const Text("Ehliyet geçerlilik tarihi: "),
                customDateText(snapshot.data!.licenseIssueDate),
              ],
            ),
            Row(
              children: [
                const Text("Telefon Numarası: "),
                Text(snapshot.data!.phoneNumber),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
