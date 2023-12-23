import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filo_fire/models/maintance_model.dart';
import 'package:filo_fire/models/vehicle_model.dart';

class FleetNetwork {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Kullanıcının sahip olduğu araçları getir
  Future<List<VehicleModel>> getUserVehicles(String userId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection('vehicles')
          .where('userId', isEqualTo: userId)
          .get();

      List<VehicleModel> cars = querySnapshot.docs.map((doc) {
        return VehicleModel(
          id: doc.id,
          userId: doc["userId"],
          brand: doc["brand"],
          model: doc["model"],
          plate: doc["plate"],
          productionYear: doc["productionYear"],
          color: doc["color"],
        );
      }).toList();

      return cars;
    } catch (e) {
      print("Hata: $e");
      return [];
    }
  }

  // Araç ID'sine göre bakım geçmişini getir
  Future<List<MaintanceModel>> getmaintanceHistoryByVehicleId(
      String vehicleId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection('maintance_history')
          .where('vehicleId', isEqualTo: vehicleId)
          .get();

      return querySnapshot.docs.map((doc) {
        return MaintanceModel(
            maintanceId: doc.id,
            vehicleId: vehicleId,
            maintanceCost: doc["maintanceCost"],
            maintanceDate: doc["maintanceDate"],
            maintanceDescription: doc["maintanceDexcription"],
            maintanceType: doc["maintanceType"]);
      }).toList();
    } catch (e) {
      print("Hata: $e");
      return [];
    }
  }

  // Yeni araç kaydı oluştur
  Future<void> addVehicle(VehicleModel vehicleData) async {
    try {
      await _firestore.collection('vehicles').add(vehicleData.toMap());
    } catch (e) {
      print("Hata: $e");
    }
  }
}
