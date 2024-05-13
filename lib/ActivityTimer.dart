import 'dart:async';
import 'package:flutter/material.dart';

/*class ActivityTimer extends StatefulWidget {
  final bool isKilometers;
  final void Function() startTimer; // Callback para manejar la parada desde el exterior
  final void Function() stopTimer;
  final void Function() resetTimer;// Callback para manejar el reset desde el exterior

  const ActivityTimer({super.key, this.isKilometers = false, required this.startTimer, required this.stopTimer, required this.resetTimer});

  @override
  _ActivityTimerState createState() => _ActivityTimerState();
}

class _ActivityTimerState extends State<ActivityTimer> {
  Timer? _timer;
  Duration _duration = const Duration();

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _duration = _duration + const Duration(seconds: 1);
      });
    });
  }

  void stopTimer() {
    if (_timer!= null && _timer!.isActive) {
      _timer!.cancel();
      widget.stopTimer.call(); // Usar el operador?. para evitar errores si onStop es null
    }
  }

  void resetTimer() {
    if (_timer!= null && _timer!.isActive) {
      _timer!.cancel();
      widget.resetTimer.call(); // Usar el operador?. para evitar errores si onReset es null
    }
    setState(() {
      _duration = const Duration();
    });
  }
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(_duration.inHours);
    final minutes = twoDigits(_duration.inMinutes.remainder(60));
    final seconds = twoDigits(_duration.inSeconds.remainder(60));

    return Text(
      widget.isKilometers ? '0.0 km' : '$hours:$minutes:$seconds',
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    );
  }
}
*/


/*import 'dart:async';
import 'package:flutter/material.dart';

class ActivityTimer extends StatefulWidget {
  final bool isKilometers;

  ActivityTimer({this.isKilometers = false});

  @override
  _ActivityTimerState createState() => _ActivityTimerState();
}

class _ActivityTimerState extends State<ActivityTimer> {
  Timer? _timer;
  Duration _duration = Duration();

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _duration = _duration + Duration(seconds: 1);
      });
    });
  }

  void stopTimer() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }
  }

  void resetTimer() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }
    setState(() {
      _duration = Duration();
    });
  }

  @override
  Widget build(BuildContext context) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(_duration.inHours);
    final minutes = twoDigits(_duration.inMinutes.remainder(60));
    final seconds = twoDigits(_duration.inSeconds.remainder(60));

    return Text(
      widget.isKilometers ? '0.0 km' : '$hours:$minutes:$seconds',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    );
  }
}
*/


class ActivityTimer extends StatefulWidget {
  final bool isKilometers;

  ActivityTimer({this.isKilometers = false});

  @override
  ActivityTimerState createState() => ActivityTimerState();
}

/*class ActivityTimerState extends State<ActivityTimer> {
  Timer? _timer;
  Duration _duration = Duration();

  void startTimer() {
    if (_timer?.isActive != true) {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          _duration = _duration + Duration(seconds: 1);
        });
      });
    }
  }

  void stopTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
  }

  void resetTimer() {
    stopTimer();
    setState(() {
      _duration = Duration();
    });
  }
  void startActivity() {
    startTimer();
  }


  @override
  Widget build(BuildContext context) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(_duration.inHours);
    final minutes = twoDigits(_duration.inMinutes.remainder(60));
    final seconds = twoDigits(_duration.inSeconds.remainder(60));

    return Text(
      widget.isKilometers ? '0.0 km' : '$hours:$minutes:$seconds',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    );
  }
}
*/
class ActivityTimerState extends State<ActivityTimer> {
  Timer? _timer;
  Duration _duration = Duration();

  void startTimer() {
    if (_timer?.isActive!= true) {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          _duration = _duration + Duration(seconds: 1);
        });
      });
    }
  }

  void stopTimer() {
    if (_timer!= null) {
      _timer!.cancel();
    }
  }

  void resetTimer() {
    stopTimer();
    setState(() {
      _duration = Duration();
    });
  }

  void startActivity() {
    startTimer();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      startActivity();
    });
  }

  @override
  Widget build(BuildContext context) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(_duration.inHours);
    final minutes = twoDigits(_duration.inMinutes.remainder(60));
    final seconds = twoDigits(_duration.inSeconds.remainder(60));

    return Text(
      widget.isKilometers? '0.0 km' : '$hours:$minutes:$seconds',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    );
  }
}
