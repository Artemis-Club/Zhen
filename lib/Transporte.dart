import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';





class TransporteScreen extends StatelessWidget {
  const TransporteScreen({super.key});

  Future<String> weather() async {
    final String apiKey = '1fc6a21d7c1a05d3aff1156d71ff425f';
    final String cityName = 'Valencia';
    final String url = 'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&lang=es';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // Si la respuesta es exitosa, parseamos el JSON
      final data = jsonDecode(response.body);
      // Aquí puedes acceder a los datos específicos que necesitas, por ejemplo, la descripción del clima
      final weatherDescription = data['weather'][0]['description'];
      return weatherDescription;
    } else {
      // Si la respuesta no es exitosa, lanzamos un error
      throw Exception('Error al obtener el clima: ${response.statusCode}');
    }
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 65.0,),
          Image(
            image: AssetImage("images/566499.png"),
            width: 120.0,
            height: 120.0,
            alignment:Alignment.center,
          ),
          FutureBuilder<String>(
            future: weather(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Text(snapshot.data ?? 'No data');
              }
            },
          ),
        ],
      ),
    );
  }
}
