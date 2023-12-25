import 'package:filo_fire/models/vehicle_model.dart';
import 'package:filo_fire/network/auth_operations.dart';
import 'package:filo_fire/network/fleet_network.dart';
import 'package:filo_fire/view/main_screen/tabs/car_list/get_car/car_info/car_info.dart';
import 'package:flutter/material.dart';

class CarList extends StatefulWidget {
  const CarList({super.key});

  @override
  State<CarList> createState() => _CarListState();
}

class _CarListState extends State<CarList>
    with AutomaticKeepAliveClientMixin<CarList> {
  @override
  bool get wantKeepAlive => true;

  late Future<List<VehicleModel>?> _loadCars;

  @override
  void initState() {
    _loadCars =
        FleetNetwork().getUserVehicles(AuthOperations().getCurrentUser()!.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder(
      future: _loadCars,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return Scaffold(
              body: RefreshIndicator(
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CarItem(car: snapshot.data![index]);
                  },
                ),
                onRefresh: () {
                  return Future(() => setState(() {
                        _loadCars = FleetNetwork().getUserVehicles(
                            AuthOperations().getCurrentUser()!.uid);
                      }));
                },
              ),
            );
          } else {
            return Text("data");
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class CarItem extends StatelessWidget {
  late VehicleModel car;

  CarItem({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CarInfoView(carData: car),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: 50,
          width: double.maxFinite,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: Colors.orange.shade200),
            borderRadius: BorderRadius.circular(10),
            color: Colors.orange.shade600,
          ),
          child: Center(
            child: Text(
              car.plate,
              style: const TextStyle(
                fontSize: 30,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
