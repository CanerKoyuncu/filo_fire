import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filo_fire/models/driver_model.dart';
import 'package:filo_fire/models/maintance_model.dart';
import 'package:filo_fire/models/vehicle_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FleetNetwork {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
          driverID: doc["driverID"],
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
          .collection('fault_records')
          .where('vehicleId', isEqualTo: vehicleId)
          .get();

      return querySnapshot.docs.map((doc) {
        return MaintanceModel(
          maintanceId: doc.id,
          vehicleId: vehicleId,
          maintanceCost: doc["maintanceCost"],
          maintanceDate: doc["maintanceDate"],
          maintanceDescription: doc["maintanceDescription"],
          maintanceType: doc["maintanceType"],
        );
      }).toList();
    } catch (e) {
      print("Hata: $e");
      return [];
    }
  }

  Future<void> createFaultRecord(MaintanceModel record) async {
    User? user = _auth.currentUser;
    if (user != null) {
      // Kullanıcı girişi yapıldıysa
      CollectionReference faultRecords = _firestore.collection('fault_records');

      await faultRecords.add({
        'userId': user.uid,
        ...record.toMap(),
      });
    } else {
      // Kullanıcı girişi yapılmamışsa hata işleme
      throw Exception("Kullanıcı girişi yapılmamış.");
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

  //Aracın driverID değişkenini değiştirir
  Future<void> updateCarDriver(
    String carId,
    String driverId,
  ) async {
    try {
      await _firestore.collection('vehicles').doc(carId).update({
        'driverID': driverId,
      });
    } catch (e) {
      throw Exception("Error updating car driver: $e");
    }
  }

  //Driver ekle

  Future<String> addDriver(DriverModel driverModel) async {
    try {
      DocumentReference driverRef =
          await _firestore.collection('drivers').add(driverModel.toJson());
      String driverID = driverRef.id;
      return driverID;
    } catch (e) {
      print("Hata: $e");
      return '';
    }
  }

  Future<DriverModel?> getDriverWithID(String driverID) async {
    try {
      DocumentSnapshot querySnapshot =
          await _firestore.collection('drivers').doc(driverID).get();

      var doc = querySnapshot.data();
      return DriverModel.fromJson(doc!, driverID);
    } catch (e) {
      return null;
    }
  }

  //Aracın driverID değişkenini değiştirir

  Future<void> updateDriverData(
    //TODO: sıkıntılı bir durum dolayısıyla güncelleme yaparken sıkıntı çıkıyor.
    String driverID,
    DriverModel driverModel,
  ) async {
    try {
      await _firestore.collection('drivers').doc(driverID).update({
        "firstName": driverModel.firstName,
        "lastName": driverModel.lastName,
        "licenseIssueDate": driverModel.licenseIssueDate,
        "licebseNumber": driverModel.licenseNumber,
        "phoneNumber": driverModel.phoneNumber,
      });
    } catch (e) {
      throw Exception("Error updating car driver: $e");
    }
  }
}
