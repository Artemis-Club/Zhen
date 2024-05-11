import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'ActivityTimer.dart';
/*class ActivityInProgress extends StatelessWidget {
  final String activityName;
  final bool isKilometers; // Indica si debe mostrar kilómetros o tiempo

  ActivityInProgress({required this.activityName, this.isKilometers = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Color(0xFFFFE4C7), // Un color crema que combina con la interfaz
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(activityName,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            if (!isKilometers)
              Text("00:00:00", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)), // Cronómetro
            if (isKilometers)
              Text("0.0 km", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)), // Distancia
            IconButton(
              icon: Icon(CupertinoIcons.check_mark_circled_solid),
              color: Colors.green,
              onPressed: () {
                // Funcionalidad para finalizar actividad
              },
            ),
            IconButton(
              icon: Icon(CupertinoIcons.xmark_circle_fill),
              color: Colors.red,
              onPressed: () {
                // Funcionalidad para cancelar actividad
              },
            ),
          ],
        ),
      ),
    );
  }
}
*/



class ActivityInProgress extends StatelessWidget {
  final String activityName;
  final bool isKilometers;

  ActivityInProgress({required this.activityName, this.isKilometers = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Color(0xFFFFE4C7),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(activityName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            ActivityTimer(
              isKilometers: isKilometers,
              onStop: () {}, // Define la lógica específica al parar
              onReset: () {}, // Define la lógica específica al resetear
            ),
            IconButton(
              icon: Icon(CupertinoIcons.check_mark_circled_solid),
              color: Colors.green,
              onPressed: () {
                // Aquí podrías necesitar acceso al estado de ActivityTimer para parar el timer
              },
            ),
            IconButton(
              icon: Icon(CupertinoIcons.xmark_circle_fill),
              color: Colors.red,
              onPressed: () {
                // Aquí podrías necesitar acceso al estado de ActivityTimer para resetear el timer
              },
            ),
          ],
        ),
      ),
    );
  }
}
