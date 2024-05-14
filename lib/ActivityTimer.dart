import 'dart:async';
import 'package:flutter/material.dart';
import 'pointsManager.dart';

class ActivityTimer extends StatefulWidget {
  final bool isKilometers;

  const ActivityTimer({Key? key, this.isKilometers = false}) : super(key: key);

  @override
  ActivityTimerState createState() => ActivityTimerState();
}

class ActivityTimerState extends State<ActivityTimer> {
  Timer? _timer;
  Duration _duration = Duration();
  double _kilometers = 0.0;

  @override
  void initState() {
    super.initState();
    if (!widget.isKilometers) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          startTimer();
        }
      });
    }
  }

  void startTimer() {
    if (_timer?.isActive != true) {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (mounted) {
          setState(() {
            _duration += Duration(seconds: 1);
          });
        }
      });
    }
  }

  void stopTimer() {
    _timer?.cancel();
  }

  void resetTimer() {
    stopTimer();
    setState(() {
      _duration = Duration();
      _kilometers = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isKilometers) {
      return Text(
        '${_kilometers.toStringAsFixed(1)} km',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      );
    } else {
      String twoDigits(int n) => n.toString().padLeft(2, '0');
      final hours = twoDigits(_duration.inHours);
      final minutes = twoDigits(_duration.inMinutes.remainder(60));
      final seconds = twoDigits(_duration.inSeconds.remainder(60));
      return Text(
        '$hours:$minutes:$seconds',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      );
    }
  }
}

