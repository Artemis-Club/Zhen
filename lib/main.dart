import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'db_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io' as io;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'pointsManager.dart';
import 'activity_details_dialog.dart';
import 'ActivityInProgress.dart';
import 'ActivityTimer.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Supabase.initialize(
      url: 'https://ebrshztwmwageblbeono.supabase.co', // Reemplaza con tu URL de Supabase
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVicnNoenR3bXdhZ2VibGJlb25vIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTA5NDgyNjYsImV4cCI6MjAyNjUyNDI2Nn0.F3bg-b81AoWKLW4BjG2IooS6R6F2blx3p3nkrFrkXVk' // Reemplaza con tu clave anon de Supabase
  );
  final dbService = DBService(Supabase.instance.client);

  // Solicitar permisos de ubicación
  await Permission.location.request();

  runApp(MyApp(dbService: dbService));
}

class MyApp extends StatelessWidget {
  final DBService dbService;
  const MyApp({super.key, required this.dbService});

  


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 1;
  final List<Widget> _children = [
    const Screen3(),
    const Screen2(),
    Screen4(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[

          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Hoy',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_rounded),
            label: 'Inicio',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Ajustes',
          ),
        ],
        backgroundColor: Colors.indigoAccent,
        selectedItemColor: Colors.grey,
        unselectedItemColor: Colors.white,
        currentIndex: _currentIndex,
      ),
    );
  }
}




// CON LOCALIZADOR ROJO Y BARRA BUSQUEDA (TIMER 5S)
//ULTIMA SOLUCION


/*
class Screen2 extends StatefulWidget {
  @override
  _Screen2State createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  GoogleMapController? _mapController;
  Set<Marker> _markers = {};
  double _zoomLevel = 18.0;  // Nivel de zoom inicial.
  Timer? _locationUpdateTimer;

  @override
  void initState() {
    super.initState();
    _locationUpdateTimer = Timer.periodic(Duration(seconds: 5), (_) => _updateUserMarker());
  }

  @override
  void dispose() {
    _locationUpdateTimer?.cancel();
    _mapController?.dispose();
    super.dispose();
  }

  Future<void> _loadMapStyle() async {
    String style = await rootBundle.loadString('themes/day.json');
    if (_mapController != null) {
      _mapController!.setMapStyle(style);
    }
  }


  Future<LatLng> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return LatLng(position.latitude, position.longitude);
  }

  Future<void> _updateUserMarker() async {
    LatLng newPosition = await _getCurrentLocation();
    if (!mounted || _mapController == null) return;

    setState(() {
      _markers = {
        Marker(
          markerId: MarkerId('userLocation'),
          position: newPosition,
          infoWindow: InfoWindow(title: 'Tu Ubicación'),
        ),
      };
    });

    _mapController!.getZoomLevel().then((zoom) {
      _zoomLevel = zoom;  // Actualiza el nivel de zoom antes de mover la cámara.
      _mapController!.moveCamera(CameraUpdate.newLatLngZoom(newPosition, _zoomLevel));
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _loadMapStyle();  // Cargar el estilo tan pronto como el mapa esté creado.
    _updateUserMarker();  // Actualizar la ubicación del marcador inmediatamente después de crear el mapa.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        myLocationEnabled: true,
        markers: _markers,
        initialCameraPosition: CameraPosition(
          target: LatLng(0, 0),  // Punto inicial genérico.
          zoom: _zoomLevel,
        ),
        onMapCreated: _onMapCreated,
      ),
    );
  }
}
*/



//TODO BASTANTE BIEN SIN ERRORES
/*class Screen3 extends StatelessWidget {
  const Screen3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _Screen4State screen4 = screen4StateKey.currentState!;
    final pointsManager = PointsManager();  // Asumiendo que tienes una instancia correcta

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Nueva Actividad'),
        backgroundColor: Color(0xFFF5F5DC),
      ),
      backgroundColor: Color(0xFFF5F5DC),
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.indigoAccent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircleAvatar(
                            backgroundImage: screen4.profileImage ?? AssetImage('images/UsuarioSinFoto.png'),
                            radius: 25,
                          ),
                          Text(
                            screen4.username,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                          ),
                          Row(
                            children: [
                              Text(
                                '${pointsManager.points} ',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                              ),
                              Image.asset(
                                'images/Naranjitos.png',
                                width: 24,
                                height: 24,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.indigoAccent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  children: List.generate(4, (index) => _buildActivityCard(index, context)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityCard(int index, BuildContext context) {
    List<String> titles = ["BICICLETAS", "TRANSPORTE PUBLICO", "COCHE ELECTRICO", "ANDANDO"];
    List<String> activityNames = ["Montar en bicicleta", "Usar transporte público", "Usar coche eléctrico", "Salir a andar"];
    List<String> imageNames = [
      'images/Bicicletas.png',
      'images/TransportePublico.png',
      'images/CocheElectrico.png',
      'images/Andando.png'
    ];
    PointsManager pointsManager = PointsManager();
    return GestureDetector(
      onTap: () => ActivityDetailsDialog.show(
          context,
          titles[index],
          activityNames[index],  // Asegura que el nombre de la actividad es correcto
          pointsManager.getPointsForActivity(activityNames[index]),  // Obtiene puntos para la actividad
          pointsManager.getUnitForActivity(activityNames[index])
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey, width: 1),
          image: DecorationImage(
            image: AssetImage(imageNames[index]),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Color(0xFFF5F5DC),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                titles[index],
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  int getPointsPerUnit(String activityName) {
    // Aquí iría la lógica para determinar los puntos por unidad según la actividad
    return 10;  // Valor de ejemplo
  }

  String getUnit(String activityName) {
    // Aquí iría la lógica para determinar la unidad (minutos, kilómetros, etc.) según la actividad
    return "minuto";  // Valor de ejemplo
  }

}
*/

/*

class Screen3 extends StatefulWidget {
  const Screen3({super.key});

  @override
  _Screen3State createState() => _Screen3State();
}

class _Screen3State extends State<Screen3> {
  bool _isActivityInProgress = false;
  String _currentActivityName = '';
  bool _isKilometers = false;

  void startActivity(String activityName, bool isKilometers) {
    if (!_isActivityInProgress) { // Asegura que no se reinicie si ya está en progreso
      setState(() {
        _isActivityInProgress = true;
        _currentActivityName = activityName;
        _isKilometers = isKilometers;
      });
    }
  }

  void stopActivity() {
    setState(() {
      _isActivityInProgress = false;
    });
  }

  void resetActivity() {
    setState(() {
      _isActivityInProgress = false;
      _currentActivityName = '';
    });
  }


  @override
  Widget build(BuildContext context) {
    final screen4 = screen4StateKey.currentState;
    if (screen4 == null) {
      // Si screen4 es null, muestra un indicador de carga o un widget alternativo
      return const Center(child: CircularProgressIndicator());
    }

    final pointsManager = PointsManager();  // Asumiendo que tienes una instancia correcta
    List<Map<String, dynamic>> rewards = [
      {
        "name": "Premio 1",
        "imagePath": "images/premio1.png",
        "targetPoints": 3000,
      },
      {
        "name": "Premio 2",
        "imagePath": "images/premio2.png",
        "targetPoints": 5000,
      },
      // Agrega más premios según necesario
    ];
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Nueva Actividad'),
        backgroundColor: Color(0xFFF5F5DC),
      ),
      backgroundColor: const Color(0xFFF5F5DC),

      child: SafeArea(

        child: Column(
          children: [
            const SizedBox(height: 30),
            // Otros componentes aquí...
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.indigoAccent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircleAvatar(
                            backgroundImage: screen4.profileImage ?? const AssetImage('images/UsuarioSinFoto.png'),
                            radius: 25,
                          ),
                          Text(
                            screen4.username,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                          ),
                          Row(
                            children: [
                              Text(
                                '${pointsManager.points} ',
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                              ),
                              Image.asset(
                                'images/Naranjitos.png',
                                width: 24,
                                height: 24,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.indigoAccent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            if (_isActivityInProgress)
              ActivityInProgress(
                activityName: _currentActivityName,
                isKilometers: _isKilometers,
                onStop: stopActivity,
                onReset: resetActivity,
              ),

            const SizedBox(height: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  children: List.generate(4, (index) => _buildActivityCard(index, context)),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.lightBlueAccent[100],  // Un color que resalte pero que combine
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: rewards.map((reward) => buildRewardProgress(reward, pointsManager.points)).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRewardProgress(Map<String, dynamic> reward, int currentPoints) {
    double progress = (currentPoints / reward['targetPoints']).clamp(0.0, 1.0);
    return Column(
      children: [
        Text("${reward['name']} (${currentPoints}/${reward['targetPoints']})"),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.grey[300],
          color: Colors.green,
        ),
        Row(
          children: [
            Image.asset(reward['imagePath'], width: 50, height: 50),
            Text(reward['name']),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildActivityCard(int index, BuildContext context) {
    List<String> titles = ["BICICLETAS", "TRANSPORTE PUBLICO", "COCHE ELECTRICO", "ANDANDO"];
    List<String> activityNames = ["Montar en bicicleta", "Usar transporte público", "Usar coche eléctrico", "Salir a andar"];
    List<String> imageNames = [
      'images/Bicicletas.png',
      'images/TransportePublico.png',
      'images/CocheElectrico.png',
      'images/Andando.png'
    ];
    PointsManager pointsManager = PointsManager();

    /*return GestureDetector(
      onTap: () => ActivityDetailsDialog.show(
          context,
          titles[index],  // El título de la actividad
          activityNames[index],  // El nombre de la actividad
          pointsManager.getPointsForActivity(activityNames[index]),  // Los puntos por unidad para la actividad
          pointsManager.getUnitForActivity(activityNames[index]),  // La unidad para la actividad (minutos o kilómetros)
              () => startActivity(activityNames[index], pointsManager.getUnitForActivity(activityNames[index]) == "kilómetro"),  // onStart callback
              stopActivity  // () => stopActivity()
      ),*/
    return GestureDetector(
      onTap: () {
        final ActivityTimerState timerState = ActivityTimerState(); // Suponiendo que puedas obtener el estado de alguna manera.

        // Mostrar el diálogo y empezar el temporizador
        ActivityDetailsDialog.show(
            context,
            titles[index], // El título de la actividad
            activityNames[index], // El nombre de la actividad
            pointsManager.getPointsForActivity(activityNames[index]), // Los puntos por unidad para la actividad
            pointsManager.getUnitForActivity(activityNames[index]), // La unidad para la actividad (minutos o kilómetros)
            timerState // Pasando el estado de ActivityTimer
        );

        // Iniciar el temporizador
        timerState.startTimer();
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey, width: 1),
          image: DecorationImage(
            image: AssetImage(imageNames[index]),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5DC),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                titles[index],
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ),
    );

  }
}*/


class Screen3 extends StatefulWidget {
  const Screen3({Key? key}) : super(key: key);

  @override
  _Screen3State createState() => _Screen3State();
}

class _Screen3State extends State<Screen3> {
  bool _isActivityInProgress = false;
  String _currentActivityName = '';
  bool _isKilometers = false;

  void startActivity(String activityName, bool isKilometers) {
    if (!_isActivityInProgress) {
      setState(() {
        _isActivityInProgress = true;
        _currentActivityName = activityName;
        _isKilometers = isKilometers;
      });
    }
  }

  Future<String> weather() async {
    final response = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=Valencia,es&appid=1fc6a21d7c1a05d3aff1156d71ff425f&units=metric&lang=en'));

    if (response.statusCode == 200) {
      // Si la petición fue exitosa, parseamos el JSON.
      var data = jsonDecode(response.body);
      String weatherDescription = data['weather'][0]['description'];
      double temperature = data['main']['temp'];
      return weatherDescription;
    } else {
      // Si la petición falló, lanzamos un error.
      throw Exception('Failed to load weather data');
    }
  }

  void stopActivity() {
    setState(() {
      _isActivityInProgress = false;
    });
  }

  void resetActivity() {
    setState(() {
      _isActivityInProgress = false;
      _currentActivityName = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final screen4 = screen4StateKey.currentState;
    if (screen4 == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final pointsManager = PointsManager();
    List<Map<String, dynamic>> rewards = [
      {"name": "Camiseta oficial del Valencia CF", "imagePath": "images/CamisetaVal1.png", "targetPoints": 3000},
      {"name": "2 entradas para Oceanografic", "imagePath": "images/Oceanografic.png", "targetPoints": 5000},
    ];

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Nueva Actividad'),
        backgroundColor: Color(0xFFF5F5DC),
      ),
      backgroundColor: const Color(0xFFF5F5DC),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.indigoAccent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircleAvatar(
                              backgroundImage: screen4.profileImage ?? const AssetImage('images/UsuarioSinFoto.png'),
                              radius: 25,
                            ),
                            Text(
                              screen4.username,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                            ),
                            Row(
                              children: [
                                Text(
                                  '${pointsManager.points} ',
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                                ),
                                Image.asset(
                                  'images/Naranjitos.png',
                                  width: 24,
                                  height: 24,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: FutureBuilder<String?>(
                      future: weather(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          // Usa el operador?? para proporcionar un valor predeterminado en caso de que snapshot.data sea nulo.
                          if(snapshot.data == "few clouds" || snapshot.data == "scattered clouds" || snapshot.data == "broken clouds"){
                            return  Column(
                              children: [
                                Image.asset(
                                  "images/nublado.png",
                                  width: 100,
                                  height: 100,
                                ),
                                Text("nublado")

                              ],
                            );
                          }
                          else if(snapshot.data == "shower rain" || snapshot.data == "rain"){
                            return Column(
                              children: [
                                Image.asset(
                                  "images/lloviendo.png",
                                  width: 100,
                                  height: 100,
                                ),
                                Text("lluvia")
                              ],
                            );
                          }
                          else if(snapshot.data == "mist"){
                            return  Column(
                              children: [
                                Image.asset(
                                  "images/niebla.png",
                                  width: 100,
                                  height: 100,
                                ),
                                Text("niebla")
                              ],
                            );
                          }
                          else if(snapshot.data == "snow"){
                            return  Column(
                              children: [
                                Image.asset(
                                  "images/nievee.png",
                                  width: 100,
                                  height: 100,
                                ),
                                Text("nevando")
                              ],
                            );
                          }
                          else if(snapshot.data == "thunderstorm"){
                            return  Column(
                              children: [
                                Image.asset(
                                  "images/tormenta.png",
                                  width: 100,
                                  height: 100,
                                ),
                                Text("tormenta")
                              ],
                            );
                          }
                          else if(snapshot.data == "clear sky"){
                            return  Column(
                              children: [
                                Image.asset(
                                  "images/soleado.png",
                                  width: 100,
                                  height: 100,
                                ),
                                Text("cielo despejado")
                              ],
                            );
                          }
                          return Text(snapshot.data?? 'Cargando...');
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');

                        }
                        // Por defecto, muestra un indicador de carga.
                        return const CircularProgressIndicator();
                      },
                    ),
                      
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              if (_isActivityInProgress)
                ActivityInProgress(
                  activityName: _currentActivityName,
                  isKilometers: _isKilometers,
                  onStop: stopActivity,
                  onReset: resetActivity,
                ),
              const SizedBox(height: 16),
              GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                children: List.generate(4, (index) => _buildActivityCard(index, context)),
              ),
              const SizedBox(height: 16),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.teal[100],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: rewards.map((reward) => buildRewardProgress(reward, pointsManager.points)).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildRewardProgress(Map<String, dynamic> reward, int currentPoints) {
    double progress = (currentPoints / reward['targetPoints']).clamp(0.0, 1.0);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("${reward['name']} (${currentPoints}/${reward['targetPoints']})",
                style: TextStyle(fontWeight: FontWeight.bold)),
            Image.asset(reward['imagePath'], width: 50, height: 50),
          ],
        ),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.grey[300],
          color: Colors.green,
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Widget _buildActivityCard(int index, BuildContext context) {
    List<String> titles = ["BICICLETAS", "TRANSPORTE PUBLICO", "COCHE ELECTRICO", "ANDANDO"];
    List<String> activityNames = ["Montar en bicicleta", "Usar transporte público", "Usar coche eléctrico", "Salir a andar"];
    List<String> imageNames = [
      'images/Bicicletas.png',
      'images/TransportePublico.png',
      'images/CocheElectrico.png',
      'images/Andando.png'
    ];
    PointsManager pointsManager = PointsManager();

    return GestureDetector(
      onTap: () {
        final ActivityTimerState timerState = ActivityTimerState(); // Suponiendo que puedas obtener el estado de alguna manera.

        // Mostrar el diálogo y empezar el temporizador
        ActivityDetailsDialog.show(
            context,
            titles[index], // El título de la actividad
            activityNames[index], // El nombre de la actividad
            pointsManager.getPointsForActivity(activityNames[index]), // Los puntos por unidad para la actividad
            pointsManager.getUnitForActivity(activityNames[index]), // La unidad para la actividad (minutos o kilómetros)
            timerState // Pasando el estado de ActivityTimer
        );

        // Iniciar el temporizador
        timerState.startTimer();
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey, width: 1),
          image: DecorationImage(
            image: AssetImage(imageNames[index]),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5DC),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                titles[index],
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//LOCALIZADOR DE MOVIMIENTO

class Screen2 extends StatefulWidget {
  const Screen2({super.key});

  @override
  _Screen2State createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  GoogleMapController? _mapController;
  Set<Marker> _markers = {};
  final double _zoomLevel = 18.0;  // Nivel de zoom inicial deseado.
  StreamSubscription<Position>? _positionStreamSubscription;

  @override
  void initState() {
    super.initState();
    _loadMapStyle();
  }

  @override
  void dispose() {
    _positionStreamSubscription?.cancel();
    _mapController?.dispose();
    super.dispose();
  }

  Future<void> _loadMapStyle() async {
    String style = await rootBundle.loadString('themes/day.json');
    if (_mapController != null) {
      _mapController!.setMapStyle(style);
    }
  }

  void _startListeningToLocation() {
    const locationSettings = LocationSettings(
      accuracy: LocationAccuracy.bestForNavigation,
      distanceFilter: 5,  // Cambio mínimo de 5 metros antes de actualizar la ubicación.
    );
    _positionStreamSubscription = Geolocator.getPositionStream(locationSettings: locationSettings).listen(
            (Position position) {
          _updateMarkerOnMap(position);
        }
    );
  }

  void _updateMarkerOnMap(Position position) {
    LatLng newPosition = LatLng(position.latitude, position.longitude);
    if (!mounted || _mapController == null) return;

    setState(() {
      _markers = {
        Marker(
          markerId: const MarkerId('userLocation'),
          position: newPosition,
          infoWindow: const InfoWindow(title: 'Tu Ubicación'),
        ),
      };
    });

    _mapController!.animateCamera(CameraUpdate.newLatLngZoom(newPosition, _zoomLevel));
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _loadMapStyle();  // Asegurarse que el estilo se carga con el mapa.
    _startListeningToLocation();  // Comenzar a escuchar la ubicación después de que el mapa está listo.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        myLocationEnabled: true,
        markers: _markers,
        initialCameraPosition: CameraPosition(
          target: const LatLng(0, 0),  // Punto inicial genérico.
          zoom: _zoomLevel,
        ),
        onMapCreated: _onMapCreated,
      ),
    );
  }
}


/*class Screen4 extends StatefulWidget {
  const Screen4({Key? key}) : super(key: key);

  @override
  _Screen4State createState() => _Screen4State();
}

class _Screen4State extends State<Screen4> {
  bool _isHovering = false;
  dynamic _profileImage;
  String _username = 'Nombre de Usuario'; // Ejemplo de nombre de usuario
  int _hoveringIndex = -1; // Para manejar el efecto de sombra en las opciones de lista

  void _showUsernameDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Editar nombre de Usuario'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Nuevo nombre de usuario',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onChanged: (value) {
                  _username = value;
                },
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Cancelar
                    },
                    child: Text('Cancelar'),
                    style: TextButton.styleFrom(
                      foregroundColor: _isHovering ? Colors.grey[500] : Colors.black,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _username = _username; // Asegúrate de que el nombre de usuario se actualice con el valor ingresado
                      });
                      Navigator.of(context).pop(); // Cerrar el diálogo
                    },
                    child: Text('Confirmar'),
                    style: TextButton.styleFrom(
                      foregroundColor: _isHovering ? Colors.grey[500] : Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Ajustes'),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                onEnter: (_) => setState(() => _isHovering = true),
                onExit: (_) => setState(() => _isHovering = false),
                child: GestureDetector(
                  onTap: () async {
                    FilePickerResult? result = await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ['jpg', 'png', 'jpeg'],
                    );
                    if (result != null) {
                      if (kIsWeb) {
                        Uint8List? fileBytes = result.files.single.bytes;
                        if (fileBytes != null) {
                          setState(() {
                            _profileImage = MemoryImage(fileBytes);
                          });
                        }
                      } else {
                        String? filePath = result.files.single.path;
                        if (filePath != null) {
                          setState(() {
                            _profileImage = FileImage(io.File(filePath));
                          });
                        }
                      }
                    }
                  },
                  child: buildProfilePicture(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            buildOptionList(),
          ],
        ),
      ),
    );
  }

  Widget buildProfilePicture() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              onEnter: (_) => setState(() => _isHovering = true),
              onExit: (_) => setState(() => _isHovering = false),
              child: GestureDetector(
                onTap: () async {
                  // Lógica para seleccionar foto de perfil
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: CupertinoColors.systemGrey4,
                            width: 1,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: _isHovering ? Colors.grey.shade500 : Colors.transparent,
                          backgroundImage: _profileImage == null
                              ? const AssetImage('images/UsuarioSinFoto.png')
                              : _profileImage,
                        ),
                      ),
                    ),
                    if (_isHovering)
                      Text(
                        'Editar foto',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _username,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: _showUsernameDialog,
                color: Colors.black, // Mantén el color normal
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildOptionList() {
    return Container(
      width: 500,
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: CupertinoColors.systemGrey4,
          width: 1,
        ),
      ),
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.only(top: 0),
        children: <Widget>[
          buildOptionItem(0, 'General'),
          const Divider(
            height: 1,
            thickness: 1,
            color: CupertinoColors.systemGrey4,
            indent: 16,
            endIndent: 16,
          ),
          buildOptionItem(1, 'Permisos'),
          const Divider(
            height: 1,
            thickness: 1,
            color: CupertinoColors.systemGrey4,
            indent: 16,
            endIndent: 16,
          ),
          buildOptionItem(2, 'Notificaciones'),
          // Agrega más CupertinoListTile según sea necesario
        ],
      ),
    );
  }

  Widget buildOptionItem(int index, String title) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hoveringIndex = index),
      onExit: (_) => setState(() => _hoveringIndex = -1),
      child: Container(
        color: _hoveringIndex == index ? Colors.grey[300] : CupertinoColors.white,
        child: CupertinoListTile(
          title: Text(title),
          onTap: () {},
        ),
      ),
    );
  }
}
*/


// Define un GlobalKey para el estado de Screen4.
GlobalKey<_Screen4State> screen4StateKey = GlobalKey<_Screen4State>();

class Screen4 extends StatefulWidget {
  Screen4({Key? key}) : super(key: screen4StateKey);

  @override
  _Screen4State createState() => _Screen4State();
}

class _Screen4State extends State<Screen4> {
  bool _isHovering = false;
  dynamic _profileImage;
  String _username = 'Nombre de Usuario'; // Ejemplo de nombre de usuario
  int _hoveringIndex = -1; // Para manejar el efecto de sombra en las opciones de lista
  String get username => _username;
  dynamic get profileImage => _profileImage;
  void _showUsernameDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Editar nombre de Usuario'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Nuevo nombre de usuario',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onChanged: (value) {
                  _username = value;
                },
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Cancelar
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: _isHovering ? Colors.grey[500] : Colors.black,
                    ),
                    child: const Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _username = _username; // Asegúrate de que el nombre de usuario se actualice con el valor ingresado
                      });
                      Navigator.of(context).pop(); // Cerrar el diálogo
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: _isHovering ? Colors.grey[500] : Colors.black,
                    ),
                    child: const Text('Confirmar'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Ajustes'),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                onEnter: (_) => setState(() => _isHovering = true),
                onExit: (_) => setState(() => _isHovering = false),
                child: GestureDetector(
                  onTap: () async {
                    FilePickerResult? result = await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ['jpg', 'png', 'jpeg'],
                    );
                    if (result != null) {
                      if (kIsWeb) {
                        Uint8List? fileBytes = result.files.single.bytes;
                        if (fileBytes != null) {
                          setState(() {
                            _profileImage = MemoryImage(fileBytes);
                          });
                        }
                      } else {
                        String? filePath = result.files.single.path;
                        if (filePath != null) {
                          setState(() {
                            _profileImage = FileImage(io.File(filePath));
                          });
                        }
                      }
                    }
                  },
                  child: buildProfilePicture(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            buildOptionList(),
          ],
        ),
      ),
    );
  }

  Widget buildProfilePicture() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              onEnter: (_) => setState(() => _isHovering = true),
              onExit: (_) => setState(() => _isHovering = false),
              child: GestureDetector(
                onTap: () async {
                  // Lógica para seleccionar foto de perfil
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: CupertinoColors.systemGrey4,
                            width: 1,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: _isHovering ? Colors.grey.shade500 : Colors.transparent,
                          backgroundImage: _profileImage ?? const AssetImage('images/UsuarioSinFoto.png'),
                        ),
                      ),
                    ),
                    if (_isHovering)
                      const Text(
                        'Editar foto',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _username,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: _showUsernameDialog,
                color: Colors.black, // Mantén el color normal
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildOptionList() {
    return Container(
      width: 500,
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: CupertinoColors.systemGrey4,
          width: 1,
        ),
      ),
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.only(top: 0),
        children: <Widget>[
          buildOptionItem(0, 'General'),
          const Divider(
            height: 1,
            thickness: 1,
            color: CupertinoColors.systemGrey4,
            indent: 16,
            endIndent: 16,
          ),
          buildOptionItem(1, 'Permisos'),
          const Divider(
            height: 1,
            thickness: 1,
            color: CupertinoColors.systemGrey4,
            indent: 16,
            endIndent: 16,
          ),
          buildOptionItem(2, 'Notificaciones'),
          // Agrega más CupertinoListTile según sea necesario
        ],
      ),
    );
  }

  Widget buildOptionItem(int index, String title) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hoveringIndex = index),
      onExit: (_) => setState(() => _hoveringIndex = -1),
      child: Container(
        color: _hoveringIndex == index ? Colors.grey[300] : CupertinoColors.white,
        child: CupertinoListTile(
          title: Text(title),
          onTap: () {},
        ),
      ),
    );
  }
}

