import 'package:filo_fire/models/vehicle_model.dart';
import 'package:filo_fire/network/auth_operations.dart';
import 'package:filo_fire/network/fleet_network.dart';
import 'package:filo_fire/view/main_screen/tabs/car_list/get_car/car_info/AddCarView.dart';
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
              appBar: appBarHome(context),
              body: carList(snapshot),
              floatingActionButton: addCarButton(context),
            );
          } else {
            return const Text("data");
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  RefreshIndicator carList(AsyncSnapshot<List<VehicleModel>?> snapshot) {
    return RefreshIndicator(
      child: ListView.builder(
        itemCount: snapshot.data!.length,
        itemBuilder: (BuildContext context, int index) {
          return CarItem(car: snapshot.data![index]);
        },
      ),
      onRefresh: () {
        return Future(() => setState(() {
              _loadCars = FleetNetwork()
                  .getUserVehicles(AuthOperations().getCurrentUser()!.uid);
            }));
      },
    );
  }

  AppBar appBarHome(BuildContext context) {
    return AppBar(title: const Text("Araçlar"), actions: [
      IconButton(
        onPressed: () {
          Navigator.popAndPushNamed(context, "/loginView");
          AuthOperations().signOut();
        },
        icon: const Icon(Icons.logout),
      ),
    ]);
  }

  FloatingActionButton addCarButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AddCarView(),
          ),
        );
        setState(() {
          _loadCars = FleetNetwork()
              .getUserVehicles(AuthOperations().getCurrentUser()!.uid);
        });
      },
      child: const Icon(Icons.add),
    );
  }
}

class CarItem extends StatelessWidget {
  final VehicleModel car;

  const CarItem({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(car.plate),
      child: Padding(
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
      ),
    );
  }
}
