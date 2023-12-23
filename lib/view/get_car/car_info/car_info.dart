import 'package:filo_fire/models/vehicle_model.dart';
import 'package:filo_fire/network/fleet_network.dart';

import 'package:flutter/material.dart';

class CarInfoView extends StatefulWidget {
  late VehicleModel vehicleModel;
  CarInfoView({super.key, required this.vehicleModel});

  @override
  State<CarInfoView> createState() => _CarInfoViewState();
}

class _CarInfoViewState extends State<CarInfoView>
    with AutomaticKeepAliveClientMixin<CarInfoView> {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FleetNetwork()
        .getmaintanceHistoryByVehicleId(widget.vehicleModel.id.toString());

    super.build(context);
    return Scaffold(
      appBar: AppBar(title: Text("Car details")),
      body: SingleChildScrollView(
          child: Column(
        children: [
          CarInfos(widget.vehicleModel),
          ListView.builder(
            itemBuilder: (context, index) {},
          )
        ],
      )),
    );
  }

  Container CarInfos(VehicleModel VehicleModel) {
    return Container(
      constraints: const BoxConstraints.expand(width: 400, height: 440),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.red),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            rowParameter("Brand", VehicleModel.brand),
            rowParameter("Model", VehicleModel.model),
            rowParameter("Production Year", VehicleModel.productionYear),
            rowParameter("Color", VehicleModel.color),
            rowParameter("Plate", VehicleModel.plate),
          ],
        ),
      ),
    );
  }

  Widget rowParameter(String name, String value) {
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          children: [
            Container(
                child: Text("$name:", style: const TextStyle(fontSize: 35))),
            const SizedBox(width: 10),
            Container(
              child: Text(
                value,
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
