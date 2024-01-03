import 'package:filo_fire/models/maintance_model.dart';

import 'package:flutter/material.dart';

class MaintancesView extends StatelessWidget {
  late List<MaintanceModel?>? maintances;
  MaintancesView({
    super.key,
    required this.maintances,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: maintances?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        return _maintanceCard(maintances![index]);
      },
    );
  }

  Widget _maintanceCard(MaintanceModel? data) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _customMaintanceRow("Bakım Tipi:", data!.maintanceType as String),
            _customMaintanceRow("Bakım tarihi:", data.maintanceDate as String),
            _customMaintanceRow(
                "Bakım Açıklaması:", data.maintanceDescription as String),
            _customMaintanceRow(
                "Bakım Maliyeti:", data.maintanceCost as String),
          ],
        ),
      ),
    );
  }

  Widget _customMaintanceRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(child: Text(title)),
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            value,
          ),
        )
      ],
    );
  }
}
