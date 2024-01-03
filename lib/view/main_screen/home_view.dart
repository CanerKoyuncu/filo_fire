import 'package:filo_fire/network/auth_operations.dart';
import 'package:filo_fire/view/main_screen/tabs/car_list/car_list.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  var user = AuthOperations().getCurrentUser();
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CarList(),
    );
  }
}
