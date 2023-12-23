import 'package:filo_fire/models/maintance_model.dart';
import 'package:filo_fire/models/vehicle_model.dart';
import 'package:filo_fire/network/fleet_network.dart';

class UserOperations {
  final String userId;
  final FleetNetwork fleetNetwork = FleetNetwork();

  UserOperations(this.userId);

  Future<void> getUserVehiclesAndmaintanceHistory() async {
    try {
      // Kullanıcının sahip olduğu araçları çek
      List<VehicleModel> userVehicles =
          await fleetNetwork.getUserVehicles(userId);

      // Her araç için bakım geçmişini çek
      for (var VehicleModel in userVehicles) {
        String vehicleId = VehicleModel.toString();
        // Varsayılan olarak araç ID'si 'id' olarak kabul edildi, kendi yapılanıza göre ayarlayabilirsiniz.
        List<MaintanceModel> maintanceHistory =
            await fleetNetwork.getmaintanceHistoryByVehicleId(vehicleId);

        // Burada işlemleri gerçekleştirin
        print("Araç: $VehicleModel, Bakım Geçmişi: $maintanceHistory");
      }
    } catch (e) {
      print("Hata: $e");
    }
  }

  Future<void> addVehicle(VehicleModel vehicleData) async {
    try {
      // Yeni araç kaydını oluştur
      await fleetNetwork.addVehicle(vehicleData);
    } catch (e) {
      print("Hata: $e");
    }
  }
}
