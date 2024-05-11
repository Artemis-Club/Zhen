class PointsManager {
  int _points = 0;

  int get points => _points;

  // Puntos otorgados por minuto o kilómetro
  static const int pointsPerMinuteBiking = 5;
  static const int pointsPerKilometerPublicTransport = 10;
  static const int pointsPerKilometerElectricCar = 5;
  static const int pointsPerMinuteWalking = 4;

  void addBikingPoints(int minutes) {
    _points += minutes * pointsPerMinuteBiking;
  }

  void addPublicTransportPoints(int kilometers) {
    _points += kilometers * pointsPerKilometerPublicTransport;
  }

  void addElectricCarPoints(int kilometers) {
    _points += kilometers * pointsPerKilometerElectricCar;
  }

  void addWalkingPoints(int minutes) {
    _points += minutes * pointsPerMinuteWalking;
  }

  void resetPoints() {
    _points = 0;
  }

  Map<String, int> pointsPerActivity = {
    "Montar en bicicleta": 5,
    "Usar transporte público": 10,
    "Usar coche eléctrico": 5,
    "Salir a andar": 4,
  };

  int getPointsForActivity(String activityName) {
    return pointsPerActivity[activityName] ??
        0; // Devuelve 0 si la actividad no está definida
  }

  Map<String, String> activityUnits = {
    "Montar en bicicleta": "minuto",
    "Usar transporte público": "kilómetro",
    "Usar coche eléctrico": "kilómetro",
    "Salir a andar": "minuto",
  };

  String getUnitForActivity(String activityName) {
    return activityUnits[activityName] ??
        "minuto"; // Devuelve "minuto" como valor por defecto
  }
}

