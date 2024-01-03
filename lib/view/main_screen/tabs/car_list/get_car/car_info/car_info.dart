import 'package:filo_fire/models/driver_model.dart';
import 'package:filo_fire/models/maintance_model.dart';
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
  late Future<DriverModel?> _driver;
  late Future<List<MaintanceModel?>?> _maintances;

  @override
  void initState() {
    _maintances = FleetNetwork()
        .getmaintanceHistoryByVehicleId(widget.carData.id.toString());
    _driver =
        FleetNetwork().getDriverWithID(widget.carData.driverID.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Araç Hakkında")),
      body: FutureBuilder(
        future: _maintances,
        builder: (context, snapshot) => Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            CarInfos(widget.carData),
            Text("Geçmiş Bakımlar",
                style: const TextStyle().copyWith(fontSize: 25)),
            Flexible(
              fit: FlexFit.tight,
              child: SizedBox(
                height: double.maxFinite,
                child: MaintancesView(
                  maintances: snapshot.data,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.car_repair),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddMaintanceView(
                carId: widget.carData.id as String,
              ),
            ),
          );
          setState(() {
            _maintances = FleetNetwork()
                .getmaintanceHistoryByVehicleId(widget.carData.id.toString());
          });
        },
      ),
    );
  }

  Widget CarInfos(VehicleModel vehicleModel) {
    return FutureBuilder(
      future: _driver,
      builder: (context, snapshot) => Card(
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
                  if (snapshot.data != null) {
                    DriverModel? driverModel = await FleetNetwork()
                        .getDriverWithID(widget.carData.driverID!);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DriverView(
                          carID: widget.carData.id.toString(),
                          driverID: widget.carData.driverID.toString(),
                        ),
                      ),
                    );
                  } else {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AddDriverView(vehicleModel: vehicleModel),
                      ),
                    );
                    setState(() async {
                      _driver = (await FleetNetwork()
                              .getDriverWithID(widget.carData.driverID!))
                          as Future<DriverModel?>;
                    });
                  }
                },
                child: Row(
                  children: [
                    const Icon(Icons.person),
                    //TODO: olması gerektiği şekilde çalışmıyor.
                    Text(snapshot.hasData == false
                        ? 'Sürücü ekleyin'
                        : snapshot.data!.firstName +
                            " " +
                            snapshot.data!.lastName),
                  ],
                ),
              )
            ],
          ),
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
