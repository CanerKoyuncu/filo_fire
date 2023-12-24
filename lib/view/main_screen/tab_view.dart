import 'package:filo_fire/network/auth_operations.dart';
import 'package:filo_fire/view/main_screen/tabs/add_car/AddCarView.dart';
import 'package:filo_fire/view/main_screen/tabs/car_list/get_car/maintance_info/add_maintance_view.dart';
import 'package:filo_fire/view/main_screen/tabs/car_list/car_list.dart';
import 'package:flutter/material.dart';

class CustomTabView extends StatefulWidget {
  const CustomTabView({super.key});

  @override
  State<CustomTabView> createState() => _CustomTabViewState();
}

class _CustomTabViewState extends State<CustomTabView> {
  var user = AuthOperations().getCurrentUser();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: buildScaffoldBody(),
    );
  }

  Scaffold buildScaffoldBody() => Scaffold(
        appBar: AppBar(actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "/loginView");
            },
            icon: const Icon(Icons.logout),
          ),
        ]),
        body: const TabBarView(
          children: [
            CarList(),
            AddCarView(),
          ],
        ),
        bottomNavigationBar: buildBottomAppBar(),
      );

  BottomAppBar buildBottomAppBar() {
    return const BottomAppBar(
      child: TabBar(
        labelColor: Colors.amber,
        tabs: [
          Tab(
            icon: Icon(Icons.car_crash),
            text: "Araçlar",
          ),
          Tab(
            icon: Icon(Icons.abc),
            text: "Araç Ekle",
          ),
        ],
      ),
    );
  }
}
