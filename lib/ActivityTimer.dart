import 'dart:async';
import 'package:flutter/material.dart';

class ActivityTimer extends StatefulWidget {
  final bool isKilometers;
  final void Function() onStop; // Callback para manejar la parada desde el exterior
  final void Function() onReset; // Callback para manejar el reset desde el exterior

  ActivityTimer({this.isKilometers = false, required this.onStop, required this.onReset});

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
      widget.onStop();
    }
  }

  void resetTimer() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
      widget.onReset();
    }
    setState(() {
      _duration = Duration();
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
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    );
  }
}
