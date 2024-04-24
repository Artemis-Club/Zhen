import 'package:flutter/material.dart';
import 'package:weather/weather.dart';





class TransporteScreen extends StatelessWidget {
  const TransporteScreen({super.key});

  void weather(BuildContext context) async{
    WeatherFactory wf = new WeatherFactory('1fc6a21d7c1a05d3aff1156d71ff425f', language: Language.SPANISH);
    Weather w = await wf.currentWeatherByCityName("Valencia");

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

        ],
      ),
    );
  }
}
