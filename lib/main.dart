import 'dart:async';

import 'package:codethon_project_dart/Transporte.dart';
import 'package:codethon_project_dart/weatherIcon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'db_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:html';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';

import 'dart:io';







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
  int _currentIndex = 0;
  final List<Widget> _children = [
    const Screen1(),
    Screen2(),
    const Screen3(),
    //Screen4(),
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
            icon: Icon(Icons.search),
            label: 'Búsqueda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_rounded),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Hoy',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Ajustes',
          ),
        ],
        backgroundColor: Colors.indigo,
        selectedItemColor: Colors.blueGrey,
        unselectedItemColor: Colors.white,
        currentIndex: _currentIndex,
      ),
    );
  }
}


class Screen1 extends StatelessWidget {
  const Screen1({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Pantalla 1'),
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

//LOCALIZADOR DE MOVIMIENTO




class Screen2 extends StatefulWidget {
  @override
  _Screen2State createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  GoogleMapController? _mapController;
  Set<Marker> _markers = {};
  double _zoomLevel = 18.0;  // Nivel de zoom inicial deseado.
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
    final locationSettings = LocationSettings(
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
          markerId: MarkerId('userLocation'),
          position: newPosition,
          infoWindow: InfoWindow(title: 'Tu Ubicación'),
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
          target: LatLng(0, 0),  // Punto inicial genérico.
          zoom: _zoomLevel,
        ),
        onMapCreated: _onMapCreated,
      ),
    );
  }
}




  class Screen3 extends StatelessWidget {
  const Screen3({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Pantalla 3'),
    );
  }
}





/*class Screen4 extends StatefulWidget {
  const Screen4({super.key});

  @override
  _Screen4State createState() => _Screen4State();
}

class _Screen4State extends State<Screen4> {
  bool _isHovering = false;

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
            // Círculo con foto de perfil
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
                      // Aquí puedes manejar la imagen seleccionada
                      // Por ejemplo, actualizar el estado del widget con la nueva imagen
                      // Nota: Este es un ejemplo básico, necesitarás implementar la lógica para actualizar la imagen
                    }
                  },
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: _isHovering ? Colors.purple.shade200 : Colors.purple,
                    child: _isHovering
                        ? Text(
                      'Editar foto',
                      style: TextStyle(color: Colors.white),
                    )
                        : null,
                    backgroundImage: NetworkImage('https://example.com/path/to/profile/image.jpg'), // Reemplaza con la URL de tu imagen de perfil
                  ),
                ),
              ),
            ),
            // Texto debajo del círculo
            const Text(
              'Nombre de Usuario',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            // Cuadro con filas para las opciones centrado
            const SizedBox(height: 20),
            Container(
              width: 500,
              decoration: BoxDecoration(
                color: CupertinoColors.white, // Color de fondo del cuadro
                borderRadius: BorderRadius.circular(10), // Radio del borde redondeado
                border: Border.all(
                  color: CupertinoColors.systemGrey4, // Color del contorno
                  width: 1, // Ancho del contorno
                ),
              ),
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 0),
                children: <Widget>[
                  CupertinoListTile(
                    title: const Text('General'),
                    onTap: () {
                      // Agregar funcionalidad aquí
                    },
                  ),
                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: CupertinoColors.systemGrey4,
                    indent: 16,
                    endIndent: 16,
                  ),
                  CupertinoListTile(
                    title: const Text('Permisos'),
                    onTap: () {
                      // Agregar funcionalidad aquí
                    },
                  ),
                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: CupertinoColors.systemGrey4,
                    indent: 16,
                    endIndent: 16,
                  ),
                  CupertinoListTile(
                    title: const Text('Notificaciones'),
                    onTap: () {
                      // Agregar funcionalidad aquí
                    },
                  ),
                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: CupertinoColors.systemGrey4,
                    indent: 16,
                    endIndent: 16,
                  ),
                  CupertinoListTile(
                    title: const Text('Información Personal'),
                    onTap: () {
                      // Agregar funcionalidad aquí
                    },
                  ),
                  // Agrega más CupertinoListTile según sea necesario
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

*/
/*class Screen4 extends StatelessWidget {
  const Screen4({super.key});

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
            // Círculo con foto de perfil
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage('https://example.com/path/to/profile/image.jpg'), // Reemplaza con la URL de tu imagen de perfil
              ),
            ),
            // Texto debajo del círculo
            const Text(
              'Nombre de Usuario',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            // Cuadro con filas para las opciones centrado
            const SizedBox(height: 20),
            Container(
              width: 500,
              decoration: BoxDecoration(
                color: CupertinoColors.white, // Color de fondo del cuadro
                borderRadius: BorderRadius.circular(10), // Radio del borde redondeado
                border: Border.all(
                  color: CupertinoColors.systemGrey4, // Color del contorno
                  width: 1, // Ancho del contorno
                ),
              ),// Ajusta el ancho según sea necesario
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 0),
                children: <Widget>[
                  CupertinoListTile(
                    title: const Text('General'),
                    onTap: () {
                      // Agregar funcionalidad aquí
                    },
                  ),
                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: CupertinoColors.systemGrey4,
                    indent: 16,
                    endIndent: 16,
                  ),
                  CupertinoListTile(
                    title: const Text('Permisos'),
                    onTap: () {
                      // Agregar funcionalidad aquí
                    },
                  ),
                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: CupertinoColors.systemGrey4,
                    indent: 16,
                    endIndent: 16,
                  ),
                  CupertinoListTile(
                    title: const Text('Notificaciones'),
                    onTap: () {
                      // Agregar funcionalidad aquí
                    },
                  ),
                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: CupertinoColors.systemGrey4,
                    indent: 16,
                    endIndent: 16,
                  ),
                  CupertinoListTile(
                    title: const Text('Informacion Personal'),
                    onTap: () {
                      // Agregar funcionalidad aquí
                    },
                  ),
                  // Agrega más CupertinoListTile según sea necesario
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/
//INTENTO DE SOLUCION MAS RECIENTE

/*class Screen4 extends StatefulWidget {
  const Screen4({Key? key}) : super(key: key);

  @override
  _Screen4State createState() => _Screen4State();
}

class _Screen4State extends State<Screen4> {
  bool _isHovering = false;
  File? _profileImage;

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
            // Círculo con foto de perfil
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
                      setState(() {
                        _profileImage = File(result.files.single.path!);
                      });
                    }
                  },
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.transparent, // Hace que el fondo sea transparente
                    child: _isHovering
                        ? Text(
                      'Editar foto',
                      style: TextStyle(color: Colors.white),
                    )
                        : null,
                    backgroundImage:  AssetImage('images/UsuarioSinFoto.png'), // Asegúrate de tener esta imagen en tu carpeta de assets
                    // Asegúrate de tener esta imagen en tu carpeta de assets
                  ),
                ),
              ),
            ),
            // Texto debajo del círculo
            const Text(
              'Nombre de Usuario',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            // Cuadro con filas para las opciones centrado
            const SizedBox(height: 20),
            Container(
              width: 500,
              decoration: BoxDecoration(
                color: CupertinoColors.white, // Color de fondo del cuadro
                borderRadius: BorderRadius.circular(10), // Radio del borde redondeado
                border: Border.all(
                  color: CupertinoColors.systemGrey4, // Color del contorno
                  width: 1, // Ancho del contorno
                ),
              ),
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 0),
                children: <Widget>[
                  CupertinoListTile(
                    title: const Text('General'),
                    onTap: () {
                      // Agregar funcionalidad aquí
                    },
                  ),
                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: CupertinoColors.systemGrey4,
                    indent: 16,
                    endIndent: 16,
                  ),
                  CupertinoListTile(
                    title: const Text('Permisos'),
                    onTap: () {
                      // Agregar funcionalidad aquí
                    },
                  ),
                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: CupertinoColors.systemGrey4,
                    indent: 16,
                    endIndent: 16,
                  ),
                  CupertinoListTile(
                    title: const Text('Notificaciones'),
                    onTap: () {
                      // Agregar funcionalidad aquí
                    },
                  ),
                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: CupertinoColors.systemGrey4,
                    indent: 16,
                    endIndent: 16,
                  ),
                  CupertinoListTile(
                    title: const Text('Información Personal'),
                    onTap: () {
                      // Agregar funcionalidad aquí
                    },
                  ),
                  // Agrega más CupertinoListTile según sea necesario
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

*/






class Screen4 extends StatefulWidget {
  const Screen4({Key? key}) : super(key: key);

  @override
  _Screen4State createState() => _Screen4State();
}

class _Screen4State extends State<Screen4> {
  bool _isHovering = false;
  Image? _profileImage;

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
                      type: FileType.image,
                      allowedExtensions: ['jpg', 'png', 'jpeg'],
                    );
                    if (result != null && result.files.single.path != null) {
                      Uint8List? fileBytes = result.files.single.bytes;
                      if (fileBytes != null) {
                        setState(() {
                          _profileImage = Image.memory(fileBytes);
                        });
                      }
                    }
                  },
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: _isHovering ? Colors.grey[700] : Colors.transparent,
                    backgroundImage: _profileImage == null ? const AssetImage('images/UsuarioSinFoto.png') : null,
                    child: _profileImage != null ? ClipOval(child: _profileImage!) : null,
                  ),
                ),
              ),
            ),
            const Text(
              'Nombre de Usuario',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Container(
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
                  CupertinoListTile(
                    title: const Text('General'),
                    onTap: () {},
                  ),
                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: CupertinoColors.systemGrey4,
                    indent: 16,
                    endIndent: 16,
                  ),
                  CupertinoListTile(
                    title: const Text('Permisos'),
                    onTap: () {},
                  ),
                  // Más opciones como en el código original
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
