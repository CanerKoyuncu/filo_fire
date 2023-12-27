import 'package:filo_fire/network/auth_operations.dart';
import 'package:filo_fire/view/main_screen/tabs/add_car/AddCarView.dart';
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
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, "/loginView");
          },
          icon: const Icon(Icons.logout),
        ),
      ]),
      body: const CarList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddCarView(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
