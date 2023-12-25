import 'package:filo_fire/models/driver_model.dart';
import 'package:flutter/material.dart';

class DriverView extends StatelessWidget {
  late DriverModel driverData;
  DriverView({
    super.key,
    required this.driverData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Text(""),
    );
  }
}
