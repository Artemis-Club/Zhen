import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'db_service.dart';


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
  MyApp({required this.dbService});
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
    Screen1(),
    Screen2(),
    Screen3(),
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

        //backgroundColor: Colors.indigo,
        items: <BottomNavigationBarItem>[
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
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Pantalla 1'),
    );
  }
}

class Screen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Pantalla 2'),
    );
  }
}

class Screen3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Pantalla 3'),
    );
  }
}
class Screen4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
    child: Text('Pantalla 4'),
    );
  }
}