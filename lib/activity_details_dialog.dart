//import 'package:codethon_project_dart/ActivityTimer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'ActivityTimer.dart';

/*class ActivityDetailsDialog {
static void show(BuildContext context, String title, String activityName, int pointsPerUnit, String unit, Function onStart, Function onStop) {
List<String> environmentalBenefits = getEnvironmentalBenefits(activityName);
    //String randomBenefit = (environmentalBenefits..shuffle()).first;
environmentalBenefits = environmentalBenefits?? [];
String randomBenefit = environmentalBenefits.isNotEmpty? (environmentalBenefits..shuffle()).first : "No hay beneficios ambientales conocidos.";

    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(
          'NUEVA ACTIVIDAD DE $title',
          style: TextStyle(
            fontSize: 18, // Cambia el tamaño de fuente aquí
            fontWeight: FontWeight.bold, // Cambia el peso de la fuente aquí
            color: Colors.indigoAccent, // Cambia el color de la fuente aquí
          ),
        ),

        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              SizedBox(height: 10),
              Text('¿Sabías que?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey, width: 1),
                ),
                child: Text(randomBenefit, style: TextStyle(fontSize: 13)),
              ),
              SizedBox(height: 10),
              RichText(
                text: TextSpan(
                    children: [
                      TextSpan(
                          text: '¡Recibirás $pointsPerUnit Naranjitos ',
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)
                      ),
                      WidgetSpan(
                          child: Image.asset('images/Naranjitos.png', width: 20, height: 20)
                      ),
                      TextSpan(
                          text: ' por cada $unit que uses $activityName!',
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)
                      ),
                    ]
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Cancelar'),
            onPressed: () {

              Navigator.pop(context);
            }
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: Text('Iniciar'),
            onPressed: () {
              onStart();
              // Aquí puedes añadir la lógica para iniciar la actividad
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }



  static List<String> getEnvironmentalBenefits(String activityName) {
    if (activityName == "Montar en bicicleta") {
      return [
        "Las emisiones de la bicicleta pueden ser más de 30 veces menores que las de un coche de combustible fósil.",
        "Montar en bicicleta nos va a ayudar a fortalecer los músculos de las piernas sin poner en dificultades a nuestras articulaciones.",
        "Montar en bicicleta a intensidad moderada y de manera regular aumenta el HDL (colesterol bueno) y reduce el LDL (colesterol malo).",
        "El ciclismo puede frenar los efectos del envejecimiento y rejuvenecer el sistema inmunitario. Los ciclistas conservan la masa muscular y la fuerza según pasan los años, mientras los niveles de testosterona de los hombres se mantienen razonablemente altos."
      ].where((benefit) => benefit.isNotEmpty).toList();;
    }else if (activityName == "Usar transporte público") {
      return [
        "El tren se posiciona como el medio de transporte (motorizado) más ecológico, con una media de emisiones de 14 gramos de CO2 por kilómetro y pasajero, seguido del autobús, con 68 gramos de CO2 frente a los 157,5 gramos que emite cada coche particular.",
        "El excesivo uso del vehículo conlleva a un colapso diario de las ciudades, especialmente en las horas puntas. Esto convierte a las ciudades en lugares sucios, ruidosos y grises. De tal forma que el transporte público es una alternativa idónea para mejorar la afluencia del tráfico reduciendo retenciones y atascos logrando una mejor movilidad urbana.",
        "Según indica la DGT, el autobús es el medio de transporte más seguro, únicamente con el 0,2 % de las víctimas mortales en carretera.",
        "Aprovechar para leer, escuchar música, ponerte al día, conversar o simplemente pensar, los trayectos de autobús o metro son buenos lugares donde cada día el viaje es diferente.",
        "Los gastos asociados al coche pueden cuadruplicar a los del transporte público. Un coche cuesta mucho más de lo que pagamos al comprarlo, además de ello deberemos tener en cuenta el combustible, mantenimiento, ITV, seguro, peajes… y más gastos periódicos que surgen. Esto hace que moverse en transporte público sea mucho más económico tanto a corto como a largo plazo."
      ].where((benefit) => benefit.isNotEmpty).toList();;
    } else if (activityName == "Usar coche eléctrico") {
      return [
        "¿Verdad que una ciudad tranquila es mejor ciudad? La contaminación acústica empeora la habitabilidad, sobre todo en zonas residenciales con mucho tráfico. Tu coche eléctrico ayuda a tener ciudades mucho menos ruidosas y estresantes. Con este vehículo te beneficias de una mayor calidad de vida y haces más agradable la del vecindario.",
        "En Europa, hay más de 150.000 puntos públicos de recarga. En Valencia contamos con varios puntos de recarga público. De manera que podrás ahorrarte dinero también en combustible!",
        "¿Sabías que en muchas ocasiones podrás estacionar tu vehículo eléctrico sin pagar y sin límite de tiempo? Has leído bien, pues la temida zona azul es gratuita para los vehículos eléctricos en la ciudad de Valencia. Así, los vehículos 100% eléctricos y aquellos ‘híbridos enchufables’",
        "Al ser vehículos respetuosos con el medioambiente cuentan con importantes bonificaciones en el Impuesto sobre Vehículos de Tracción Mecánica, también conocido como “Impuesto municipal de circulación” (IVTM)."
      ].where((benefit) => benefit.isNotEmpty).toList();;
    } else if (activityName == "Salir a andar") {
      return [
        "Está demostrado que caminar quema más grasa y calorías que otros ejercicios, ayuda a que el sistema cardiovascular se active y fortifique, y te ayuda a eliminar el colesterol perjudicial para el organismo.",
        "Caminar de manera regular beneficia la salud psicológica, ayudando a mejorar la depresión, el estrés, insomnio y muchos otros problemas emocionales y mentales.",
        "Al eliminar la necesidad de vehículos motorizados, se reducen las emisiones de carbono y la contaminación del aire. Adoptar el hábito de caminar contribuye directamente a la creación de ciudades más limpias.",
        "Fomentar la movilidad peatonal disminuye la congestión vehicular, haciendo que las ciudades sean más habitables. Esto permite la creación de zonas peatonales, parques urbanos y áreas verdes, mejorando la calidad de vida y promoviendo un entorno más armonioso."
      ].where((benefit) => benefit.isNotEmpty).toList();;
    }
    return [];
  }
}
*/


/*class ActivityDetailsDialog {
  static void show(BuildContext context, String title, String activityName, int pointsPerUnit, String unit, Function startActivity, Function stopActivity) {
    List<String> environmentalBenefits = getEnvironmentalBenefits(activityName);
    String randomBenefit = environmentalBenefits.isNotEmpty ? (environmentalBenefits..shuffle()).first : "No hay beneficios ambientales conocidos.";

    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text('NUEVA ACTIVIDAD DE $title'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              SizedBox(height: 10),
              Text('¿Sabías que?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey, width: 1),
                ),
                child: Text(randomBenefit, style: TextStyle(fontSize: 13)),
              ),
              SizedBox(height: 10),
              RichText(
                text: TextSpan(
                    children: [
                      TextSpan(
                          text: '¡Recibirás $pointsPerUnit Naranjitos ',
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)
                      ),
                      WidgetSpan(
                          child: Image.asset('images/Naranjitos.png', width: 20, height: 20)
                      ),
                      TextSpan(
                          text: ' por cada $unit que uses $activityName!',
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)
                      ),
                    ]
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          CupertinoDialogAction(
              isDefaultAction: true,
              child: Text('Cancelar'),
              onPressed: () {

                Navigator.pop(context);
              }
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: Text('Iniciar'),
            onPressed: () {
              //startActivity();
              startActivity();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
  static List<String> getEnvironmentalBenefits(String activityName) {
if (activityName == "Montar en bicicleta") {
return [
"Las emisiones de la bicicleta pueden ser más de 30 veces menores que las de un coche de combustible fósil.",
"Montar en bicicleta nos va a ayudar a fortalecer los músculos de las piernas sin poner en dificultades a nuestras articulaciones.",
"Montar en bicicleta a intensidad moderada y de manera regular aumenta el HDL (colesterol bueno) y reduce el LDL (colesterol malo).",
"El ciclismo puede frenar los efectos del envejecimiento y rejuvenecer el sistema inmunitario. Los ciclistas conservan la masa muscular y la fuerza según pasan los años, mientras los niveles de testosterona de los hombres se mantienen razonablemente altos."
].where((benefit) => benefit.isNotEmpty).toList();;
}else if (activityName == "Usar transporte público") {
return [
"El tren se posiciona como el medio de transporte (motorizado) más ecológico, con una media de emisiones de 14 gramos de CO2 por kilómetro y pasajero, seguido del autobús, con 68 gramos de CO2 frente a los 157,5 gramos que emite cada coche particular.",
"El excesivo uso del vehículo conlleva a un colapso diario de las ciudades, especialmente en las horas puntas. Esto convierte a las ciudades en lugares sucios, ruidosos y grises. De tal forma que el transporte público es una alternativa idónea para mejorar la afluencia del tráfico reduciendo retenciones y atascos logrando una mejor movilidad urbana.",
"Según indica la DGT, el autobús es el medio de transporte más seguro, únicamente con el 0,2 % de las víctimas mortales en carretera.",
"Aprovechar para leer, escuchar música, ponerte al día, conversar o simplemente pensar, los trayectos de autobús o metro son buenos lugares donde cada día el viaje es diferente.",
"Los gastos asociados al coche pueden cuadruplicar a los del transporte público. Un coche cuesta mucho más de lo que pagamos al comprarlo, además de ello deberemos tener en cuenta el combustible, mantenimiento, ITV, seguro, peajes… y más gastos periódicos que surgen. Esto hace que moverse en transporte público sea mucho más económico tanto a corto como a largo plazo."
].where((benefit) => benefit.isNotEmpty).toList();;
} else if (activityName == "Usar coche eléctrico") {
return [
"¿Verdad que una ciudad tranquila es mejor ciudad? La contaminación acústica empeora la habitabilidad, sobre todo en zonas residenciales con mucho tráfico. Tu coche eléctrico ayuda a tener ciudades mucho menos ruidosas y estresantes. Con este vehículo te beneficias de una mayor calidad de vida y haces más agradable la del vecindario.",
"En Europa, hay más de 150.000 puntos públicos de recarga. En Valencia contamos con varios puntos de recarga público. De manera que podrás ahorrarte dinero también en combustible!",
"¿Sabías que en muchas ocasiones podrás estacionar tu vehículo eléctrico sin pagar y sin límite de tiempo? Has leído bien, pues la temida zona azul es gratuita para los vehículos eléctricos en la ciudad de Valencia. Así, los vehículos 100% eléctricos y aquellos ‘híbridos enchufables’",
"Al ser vehículos respetuosos con el medioambiente cuentan con importantes bonificaciones en el Impuesto sobre Vehículos de Tracción Mecánica, también conocido como “Impuesto municipal de circulación” (IVTM)."
].where((benefit) => benefit.isNotEmpty).toList();;
} else if (activityName == "Salir a andar") {
return [
"Está demostrado que caminar quema más grasa y calorías que otros ejercicios, ayuda a que el sistema cardiovascular se active y fortifique, y te ayuda a eliminar el colesterol perjudicial para el organismo.",
"Caminar de manera regular beneficia la salud psicológica, ayudando a mejorar la depresión, el estrés, insomnio y muchos otros problemas emocionales y mentales.",
"Al eliminar la necesidad de vehículos motorizados, se reducen las emisiones de carbono y la contaminación del aire. Adoptar el hábito de caminar contribuye directamente a la creación de ciudades más limpias.",
"Fomentar la movilidad peatonal disminuye la congestión vehicular, haciendo que las ciudades sean más habitables. Esto permite la creación de zonas peatonales, parques urbanos y áreas verdes, mejorando la calidad de vida y promoviendo un entorno más armonioso."
].where((benefit) => benefit.isNotEmpty).toList();;
}
return [];
}
}
*/

class ActivityDetailsDialog {
  static  show(
      BuildContext context,
      String title,
      String activityName,
      int pointsPerUnit,
      String unit,
      ActivityTimerState timerState) {



    List<String> environmentalBenefits = getEnvironmentalBenefits(activityName);
    String randomBenefit = environmentalBenefits.isNotEmpty ? (environmentalBenefits..shuffle()).first : "No hay beneficios ambientales conocidos.";

    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text('NUEVA ACTIVIDAD DE $title'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              const SizedBox(height: 10),
              const Text('¿Sabías que?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey, width: 1),
                ),
                child: Text(randomBenefit, style: const TextStyle(fontSize: 13)),
              ),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                    children: [
                      TextSpan(
                          text: '¡Recibirás $pointsPerUnit Naranjitos ',
                          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)
                      ),
                      WidgetSpan(
                          child: Image.asset('images/Naranjitos.png', width: 20, height: 20)
                      ),
                      TextSpan(
                          text: ' por cada $unit que uses $activityName!',
                          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)
                      ),
                    ]
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          CupertinoDialogAction(
              isDefaultAction: true,
              child: const Text('Cancelar'),
              onPressed: () {

                Navigator.pop(context);
              }
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: const Text('Iniciar'),
            onPressed: () {
              //startActivity();
              //onStart();
              timerState.startActivity();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  static List<String> getEnvironmentalBenefits(String activityName) {
    if (activityName == "Montar en bicicleta") {
      return [
        "Las emisiones de la bicicleta pueden ser más de 30 veces menores que las de un coche de combustible fósil.",
        "Montar en bicicleta nos va a ayudar a fortalecer los músculos de las piernas sin poner en dificultades a nuestras articulaciones.",
        "Montar en bicicleta a intensidad moderada y de manera regular aumenta el HDL (colesterol bueno) y reduce el LDL (colesterol malo).",
        "El ciclismo puede frenar los efectos del envejecimiento y rejuvenecer el sistema inmunitario. Los ciclistas conservan la masa muscular y la fuerza según pasan los años, mientras los niveles de testosterona de los hombres se mantienen razonablemente altos."
      ].where((benefit) => benefit.isNotEmpty).toList();
    }else if (activityName == "Usar transporte público") {
      return [
        "El tren se posiciona como el medio de transporte (motorizado) más ecológico, con una media de emisiones de 14 gramos de CO2 por kilómetro y pasajero, seguido del autobús, con 68 gramos de CO2 frente a los 157,5 gramos que emite cada coche particular.",
        "El excesivo uso del vehículo conlleva a un colapso diario de las ciudades, especialmente en las horas puntas. Esto convierte a las ciudades en lugares sucios, ruidosos y grises. De tal forma que el transporte público es una alternativa idónea para mejorar la afluencia del tráfico reduciendo retenciones y atascos logrando una mejor movilidad urbana.",
        "Según indica la DGT, el autobús es el medio de transporte más seguro, únicamente con el 0,2 % de las víctimas mortales en carretera.",
        "Aprovechar para leer, escuchar música, ponerte al día, conversar o simplemente pensar, los trayectos de autobús o metro son buenos lugares donde cada día el viaje es diferente.",
        "Los gastos asociados al coche pueden cuadruplicar a los del transporte público. Un coche cuesta mucho más de lo que pagamos al comprarlo, además de ello deberemos tener en cuenta el combustible, mantenimiento, ITV, seguro, peajes… y más gastos periódicos que surgen. Esto hace que moverse en transporte público sea mucho más económico tanto a corto como a largo plazo."
      ].where((benefit) => benefit.isNotEmpty).toList();
    } else if (activityName == "Usar coche eléctrico") {
      return [
        "¿Verdad que una ciudad tranquila es mejor ciudad? La contaminación acústica empeora la habitabilidad, sobre todo en zonas residenciales con mucho tráfico. Tu coche eléctrico ayuda a tener ciudades mucho menos ruidosas y estresantes. Con este vehículo te beneficias de una mayor calidad de vida y haces más agradable la del vecindario.",
        "En Europa, hay más de 150.000 puntos públicos de recarga. En Valencia contamos con varios puntos de recarga público. De manera que podrás ahorrarte dinero también en combustible!",
        "¿Sabías que en muchas ocasiones podrás estacionar tu vehículo eléctrico sin pagar y sin límite de tiempo? Has leído bien, pues la temida zona azul es gratuita para los vehículos eléctricos en la ciudad de Valencia. Así, los vehículos 100% eléctricos y aquellos ‘híbridos enchufables’",
        "Al ser vehículos respetuosos con el medioambiente cuentan con importantes bonificaciones en el Impuesto sobre Vehículos de Tracción Mecánica, también conocido como “Impuesto municipal de circulación” (IVTM)."
      ].where((benefit) => benefit.isNotEmpty).toList();
    } else if (activityName == "Salir a andar") {
      return [
        "Está demostrado que caminar quema más grasa y calorías que otros ejercicios, ayuda a que el sistema cardiovascular se active y fortifique, y te ayuda a eliminar el colesterol perjudicial para el organismo.",
        "Caminar de manera regular beneficia la salud psicológica, ayudando a mejorar la depresión, el estrés, insomnio y muchos otros problemas emocionales y mentales.",
        "Al eliminar la necesidad de vehículos motorizados, se reducen las emisiones de carbono y la contaminación del aire. Adoptar el hábito de caminar contribuye directamente a la creación de ciudades más limpias.",
        "Fomentar la movilidad peatonal disminuye la congestión vehicular, haciendo que las ciudades sean más habitables. Esto permite la creación de zonas peatonales, parques urbanos y áreas verdes, mejorando la calidad de vida y promoviendo un entorno más armonioso."
      ].where((benefit) => benefit.isNotEmpty).toList();
    }
    return [];
  }
}