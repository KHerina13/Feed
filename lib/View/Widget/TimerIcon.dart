import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class TimerIcon extends StatefulWidget {
  @override
  _TimerIconState createState() => _TimerIconState();
}

class _TimerIconState extends State<TimerIcon> with TickerProviderStateMixin {
  late Timer _timer;
  int _remainingTime =  Random().nextInt(20) + 10;

  // Random().nextInt(20) + 10;

  @override
  void initState() {
    super.initState();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        _timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.timer),
      onPressed: _startTimer,
      tooltip: '$_remainingTime seconds',
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
