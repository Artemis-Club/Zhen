


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_icons/weather_icons.dart'; // Asegúrate de importar la biblioteca de íconos de clima

class weatherIconScreen extends StatelessWidget {
  const weatherIconScreen({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FutureBuilder<String?>(
          future: weather(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // Utiliza el código del ícono para mostrar el ícono de clima
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Asegúrate de que el código del ícono es válido y corresponde a un ícono existente en la biblioteca weather_icons
                  BoxedIcon(WeatherIcons.fromString(snapshot.data?.split('\n').last?? 'fallback_icon_code')),

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