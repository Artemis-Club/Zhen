


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:weather_icons/weather_icons.dart'; // Asegúrate de importar la biblioteca de íconos de clima

class WeatherIconScreen extends StatelessWidget {
  const WeatherIconScreen({super.key});

  Future<String> weather() async {
    final response = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=Valencia,es&appid=1fc6a21d7c1a05d3aff1156d71ff425f&units=metric&lang=es'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      String weatherDescription = data['weather'][0]['description'];
      double temperature = data['main']['temp'];
      String weatherIconCode = data['weather'][0]['icon']; // Extrae el código del ícono de clima
      return 'Descripción: $weatherDescription\nTemperatura: $temperature°C\nÍcono de Clima: $weatherIconCode';
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<String> leerJson() async {
    // Carga el archivo JSON como un Future<String>
    final jsonString = await rootBundle.loadString('files/contenedores.json');

    // Decodifica la cadena JSON en una List<Map<String, dynamic>>
    final List<dynamic> jsonData = jsonDecode(jsonString);

    // Convierte la lista de datos JSON en un Set<Marker>
    final Set<Marker> markers = jsonData.map((json) {
      final position = LatLng(json['geo_point_2d']['lat'], json['geo_point_2d']['lon']);
      return Marker(
        markerId: MarkerId(json['objectid'].toString()),
        position: position,
        infoWindow: InfoWindow(title: json['empresa']),
      );
    }).toSet();

    return markers.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FutureBuilder<String?>(
          future: leerJson(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // Utiliza el código del ícono para mostrar el ícono de clima
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Text(snapshot.data?? 'Cargando...'),
                ],
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}