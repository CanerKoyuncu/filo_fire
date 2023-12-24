import 'package:filo_fire/models/vehicle_model.dart';
import 'package:filo_fire/network/fleet_network.dart';
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
  Widget build(BuildContext context) {
    String? carId = widget.carData.id;

    super.build(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Car details")),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          CarInfos(widget.carData),
          Text("Geçmiş Bakımlar", style: TextStyle().copyWith(fontSize: 25)),
          Flexible(
            fit: FlexFit.tight,
            child: Container(
                height: 442,
                child: MaintancesView(carId: widget.carData.id.toString())),
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
                const Flexible(
                  flex: 2,
                  child: Column(
                    children: [
                      Text("Plaka:"),
                      Text("Marka:"),
                      Text("Model:"),
                      Text("Son bakım tarihi:"),
                      Text("Renk:"),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Text(vehicleModel.plate),
                    Text(vehicleModel.brand),
                    Text(vehicleModel.model),
                    Text(vehicleModel.lastMaintanceDate ?? ""),
                    Text(vehicleModel.color),
                  ],
                ),
              ],
            ),
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
