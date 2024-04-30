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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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





class Screen2 extends StatefulWidget {
  const Screen2({super.key});

  @override
  _Screen2State createState() => _Screen2State();
}

//SIN LOCALIZADOR ROJO SIN BARRA BUSQUEDA
/*class _Screen2State extends State<Screen2> {
  final Completer<GoogleMapController> _controller = Completer();
  Future<LatLng> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    return LatLng(position.latitude, position.longitude);
  }

  Future<void> _loadMapStyle() async {
    String mapStyle = await rootBundle.loadString('themes/day.json');
    _controller.future.then((controller) {
      controller.setMapStyle(mapStyle);
    });
  }

  @override
  void initState() {
    super.initState();
    _loadMapStyle();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LatLng>(
      future: _getCurrentLocation(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error al obtener la ubicación'));
        } else {
          return GoogleMap(
            mapType: MapType.normal,
            myLocationEnabled: true,
            initialCameraPosition: CameraPosition(
              target: snapshot.data!,
              zoom: 15.7746,
            ),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          );
        }
      },
    );
  }
}
*/


//SOLUCION WEB SIN BARRA BUSQUEDA

/*

class _Screen2State extends State<Screen2> {
  final Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = {};
  Stream<Position>? _locationStream;
  LatLng? _lastPosition;

  Future<void> _loadMapStyle() async {
    String mapStyle = await rootBundle.loadString('themes/day.json');
    _controller.future.then((controller) {
      controller.setMapStyle(mapStyle);
    });
  }

  @override
  void initState() {
    super.initState();
    _loadMapStyle();
    final LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.bestForNavigation,
      distanceFilter: 10, // Actualiza la ubicación cada 10 metros
    );
    _locationStream = Geolocator.getPositionStream(locationSettings: locationSettings);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Position>(
      stream: _locationStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error al obtener la ubicación'));
        } else {
          Position position = snapshot.data!;
          LatLng currentLocation = LatLng(position.latitude, position.longitude);
          if (_lastPosition == null || Geolocator.distanceBetween(
              _lastPosition!.latitude, _lastPosition!.longitude, currentLocation.latitude, currentLocation.longitude) > 5) {
            setState(() {
              // Actualiza el marcador existente en lugar de agregar uno nuevo
              _markers.removeWhere((marker) => marker.markerId == MarkerId('userLocation'));
              _markers.add(
                Marker(
                  markerId: MarkerId('userLocation'),
                  position: currentLocation,
                  infoWindow: InfoWindow(title: 'Tu Ubicación'),
                ),
              );
              _lastPosition = currentLocation;
            });
          }
          return GoogleMap(
            mapType: MapType.normal,
            myLocationEnabled: true,
            markers: _markers,
            initialCameraPosition: CameraPosition(
              target: currentLocation,
              zoom: 18.000,
            ),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          );
        }
      },
    );
  }
}

*/




// CON LOCALIZADOR ROJO Y BARRA BUSQUEDA
  class _Screen2State extends State<Screen2> {
    final Completer<GoogleMapController> _controller = Completer();
    Set<Marker> _markers = {}; // Conjunto para almacenar los marcadores

    Future<LatLng> _getCurrentLocation() async {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.bestForNavigation);
      return LatLng(position.latitude, position.longitude);
    }

    Future<void> _loadMapStyle() async {
      String mapStyle = await rootBundle.loadString('themes/day.json');
      _controller.future.then((controller) {
        controller.setMapStyle(mapStyle);
      });
    }

    @override
    void initState() {
      super.initState();
      _loadMapStyle();
      _getCurrentLocation().then((position) {
        setState(() {
          _markers.add(
            Marker(
              markerId: MarkerId('userLocation'),
              position: position,
              infoWindow: InfoWindow(title: 'Tu Ubicación'),

            ),
          );
        });
      });
    }

    @override
    Widget build(BuildContext context) {
      return FutureBuilder<LatLng>(
        future: _getCurrentLocation(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error al obtener la ubicación'));
          } else {
            return Scaffold(
              body: Stack(
                children: [
                  GoogleMap(
                    mapType: MapType.normal,
                    myLocationEnabled: true,
                    markers: _markers,
                    // Añade los marcadores al mapa
                    initialCameraPosition: CameraPosition(
                      target: snapshot.data!,
                      zoom: 18.000,
                    ),
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                  ),
                  Positioned(
                    top: 10, // Ajusta la posición vertical
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Buscar...',
                          prefixIcon: Icon(CupertinoIcons.search),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
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
                    backgroundImage: _profileImage != null
                        ? FileImage(_profileImage!) // Usa FileImage correctamente
                        : AssetImage('images/noUserPhoto.jpg'), // Asegúrate de tener esta imagen en tu carpeta de assets
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