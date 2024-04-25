import 'dart:async';

import 'package:codethon_project_dart/global/global_var.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'db_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



//me cago en mi prima como no se cambie

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Supabase.initialize(
      url: 'https://ebrshztwmwageblbeono.supabase.co', // Reemplaza con tu URL de Supabase
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVicnNoenR3bXdhZ2VibGJlb25vIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTA5NDgyNjYsImV4cCI6MjAyNjUyNDI2Nn0.F3bg-b81AoWKLW4BjG2IooS6R6F2blx3p3nkrFrkXVk' // Reemplaza con tu clave anon de Supabase
  );
  final dbService = DBService(Supabase.instance.client);

  runApp(MyApp(dbService: dbService));
}

class MyApp extends StatelessWidget {

  final DBService dbService;
  const MyApp({super.key, required this.dbService});
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

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
    const Screen4(),
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

        //backgroundColor: Colors.indigo,
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




class Screen2 extends StatelessWidget {


  final Completer<GoogleMapController> googleMapCompleterController = Completer<GoogleMapController>();
  GoogleMapController? controllerGoogleMap;

  Screen2({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      /*child: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0), // Ajusta el padding horizontal para controlar el ancho
              child: CupertinoSearchTextField(
                placeholder: 'Buscar',
                onChanged: (value) {
                  // Aquí puedes manejar los cambios en el texto de búsqueda
                },
                onSubmitted: (value) {
                  // Aquí puedes manejar la acción de enviar el texto de búsqueda
                },
              ),
            ),
            Expanded(
              child: Center(*/
                body: Stack(
                  children: [
                    GoogleMap(
                      mapType: MapType.normal,
                      myLocationEnabled: true,
                      initialCameraPosition: googlePlexInitialPosition,
                      onMapCreated: (GoogleMapController mapController){
                        controllerGoogleMap = mapController;
                        googleMapCompleterController.complete(controllerGoogleMap);
                      },

                    ),
                  ],
              ),
            );

  }
}


/*class Screen2 extends StatelessWidget {
  final Completer<GoogleMapController> googleMapCompleterController = Completer<GoogleMapController>();
  GoogleMapController? controllerGoogleMap;

  // Asegúrate de inicializar googlePlexInitialPosition correctamente
  final CameraPosition googlePlexInitialPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    print("Iniciando el widget Screen2"); // Similar a console.log en JavaScript

    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            myLocationEnabled: true,
            initialCameraPosition: googlePlexInitialPosition,
            onMapCreated: (GoogleMapController mapController) {
              controllerGoogleMap = mapController;
              googleMapCompleterController.complete(controllerGoogleMap);
              print("Mapa creado y controlador asignado"); // Similar a console.log en JavaScript
            },
          ),
        ],
      ),
    );
  }
}*/


class Screen3 extends StatelessWidget {
  const Screen3({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Pantalla 3'),
    );
  }
}

class Screen4 extends StatelessWidget {
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

