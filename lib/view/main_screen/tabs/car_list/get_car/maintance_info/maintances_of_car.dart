import 'package:filo_fire/models/maintance_model.dart';
import 'package:filo_fire/network/fleet_network.dart';
import 'package:flutter/material.dart';

class MaintancesView extends StatefulWidget {
  late String carId;
  MaintancesView({
    super.key,
    required this.carId,
  });

  @override
  State<MaintancesView> createState() => _MaintancesViewState();
}

class _MaintancesViewState extends State<MaintancesView> {
  late Future<List<MaintanceModel>?> _loadMaintances;
  @override
  void initState() {
    _loadMaintances =
        FleetNetwork().getmaintanceHistoryByVehicleId(widget.carId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadMaintances,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return RefreshIndicator(
              onRefresh: () {
                return Future(() => setState(() {
                      _loadMaintances = FleetNetwork()
                          .getmaintanceHistoryByVehicleId(widget.carId);
                    }));
              },
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Row(
                      children: [
                        const Flexible(
                          flex: 2,
                          child: Column(
                            children: [
                              Text("Bakım Tipi:"),
                              Text("Bakım Tarihi:"),
                              Text("Bakım Açıklaması:"),
                              Text("Bakım Ücreti:"),
                            ],
                          ),
                        ),
                        const Spacer(
                          flex: 1,
                        ),
                        Flexible(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(snapshot.data?[index].maintanceType
                                  as String),
                              Text(snapshot.data?[index].maintanceDate
                                  as String),
                              Text(snapshot.data?[index].maintanceDescription
                                  as String),
                              Text(snapshot.data?[index].maintanceCost
                                  as String),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
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
