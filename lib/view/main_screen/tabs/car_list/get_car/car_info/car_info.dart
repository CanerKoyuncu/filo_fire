import 'package:filo_fire/models/driver_model.dart';
import 'package:filo_fire/models/vehicle_model.dart';
import 'package:filo_fire/network/fleet_network.dart';
import 'package:filo_fire/view/main_screen/tabs/car_list/get_car/driver_info/add_driver_view.dart';
import 'package:filo_fire/view/main_screen/tabs/car_list/get_car/driver_info/driver_view.dart';
import 'package:filo_fire/view/main_screen/tabs/car_list/get_car/maintance_info/add_maintance_view.dart';
import 'package:filo_fire/view/main_screen/tabs/car_list/get_car/maintance_info/maintances_of_car.dart';

import 'package:flutter/material.dart';

class CarInfoView extends StatefulWidget {
  late VehicleModel carData;
  CarInfoView({super.key, required this.carData});

  @override
  State<CarInfoView> createState() => _CarInfoViewState();
}

class _CarInfoViewState extends State<CarInfoView>
    with AutomaticKeepAliveClientMixin<CarInfoView> {
  @override
  bool get wantKeepAlive => true;

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Car details")),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          CarInfos(widget.carData),
          Text("Geçmiş Bakımlar",
              style: const TextStyle().copyWith(fontSize: 25)),
          Flexible(
            fit: FlexFit.tight,
            child: Container(
              height: 442,
              child: MaintancesView(
                carId: widget.carData.id.toString(),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.car_repair),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddMaintanceView(
                carId: widget.carData.id as String,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget CarInfos(VehicleModel vehicleModel) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Flexible(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Plaka:", style: TextStyle(fontSize: 25)),
                        Text("Marka:", style: TextStyle(fontSize: 25)),
                        Text("Model:", style: TextStyle(fontSize: 25)),
                        Text("Son bakım tarihi:",
                            style: TextStyle(fontSize: 25)),
                        Text("Renk:", style: TextStyle(fontSize: 25)),
                      ],
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(vehicleModel.plate,
                        style: const TextStyle(fontSize: 25)),
                    Text(vehicleModel.brand,
                        style: const TextStyle(fontSize: 25)),
                    Text(vehicleModel.model,
                        style: const TextStyle(fontSize: 25)),
                    Text(vehicleModel.lastMaintanceDate ?? "",
                        style: const TextStyle(fontSize: 25)),
                    Text(vehicleModel.color,
                        style: const TextStyle(fontSize: 25)),
                  ],
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () async {
                if (widget.carData.driverFirstName != null) {
                  DriverModel? driverModel = await FleetNetwork()
                      .getDriverWithID(widget.carData.driverID!);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DriverView(driverData: driverModel!),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AddDriverView(vehicleModel: vehicleModel),
                    ),
                  );
                }
              },
              child: Row(
                children: [
                  const Icon(Icons.person),
                  Text(widget.carData.driverFirstName ?? ''),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget rowParameter(String name, String value) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        children: [
          Text("$name:", style: const TextStyle(fontSize: 35)),
          const SizedBox(width: 10),
          Text(
            value,
            style: const TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
