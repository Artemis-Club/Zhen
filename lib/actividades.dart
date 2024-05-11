import 'pointsManager.dart';

class ActivityManager {
  final PointsManager _pointsManager;

  ActivityManager(this._pointsManager);

  void performBiking(int minutes) {
    _pointsManager.addBikingPoints(minutes);
    // Aquí podría ir lógica adicional específica para el ciclismo
  }

  void performPublicTransport(int kilometers) {
    _pointsManager.addPublicTransportPoints(kilometers);
    // Lógica específica para el uso de transporte público
  }

  void performElectricCar(int kilometers) {
    _pointsManager.addElectricCarPoints(kilometers);
    // Lógica específica para el uso de coches eléctricos
  }

  void performWalking(int minutes) {
    _pointsManager.addWalkingPoints(minutes);
    // Lógica específica para caminar
  }
}
