import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TransporteScreen extends StatelessWidget {
  const TransporteScreen({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FutureBuilder<String?>(
          future: weather(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // Usa el operador?? para proporcionar un valor predeterminado en caso de que snapshot.data sea nulo.
              if(snapshot.data == "few clouds" || snapshot.data == "scattered clouds" || snapshot.data == "broken clouds"){
                return Column(
                children: [
                  Image(
                      image: AssetImage("images/nublado.png"),
                  ),

                ],
              );
              }
              else if(snapshot.data == "shower rain" || snapshot.data == "rain"){
                return Column(
                  children: [
                    Image(
                      image: AssetImage("images/lloviendo.png"),
                    ),
                  ],
                );
              }
              else if(snapshot.data == "mist"){
                return Column(
                  children: [
                    Image(
                      image: AssetImage("images/niebla.png"),
                    ),
                  ],
                );
              }
              else if(snapshot.data == "snow"){
                return Column(
                  children: [
                    Image(
                      image: AssetImage("images/nievee.png"),
                    ),
                  ],
                );
              }
              else if(snapshot.data == "thunderstorm"){
                return Column(
                  children: [
                    Image(
                      image: AssetImage("images/tormenta.png"),
                    ),
                  ],
                );
              }
              else if(snapshot.data == "clear sky"){
                return Column(
                  children: [
                    Image(
                      image: AssetImage("images/soleado.png"),
                    ),
                  ],
                );
              }
              return Text(snapshot.data?? 'Cargando...');
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');

            }
            // Por defecto, muestra un indicador de carga.
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}