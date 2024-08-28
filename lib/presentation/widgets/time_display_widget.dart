import 'dart:async';

import 'package:flutter/material.dart';
import 'package:football/presentation/home/controllers/home_page_controller.dart';
import 'package:intl/intl.dart';

class TimeDisplay extends StatefulWidget {
  final HomePageController controller;

  const TimeDisplay({super.key, required this.controller});

  @override
  TimeDisplayState createState() => TimeDisplayState();
}

class TimeDisplayState extends State<TimeDisplay> {
  String _formattedTime = '';
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer to prevent memory leaks
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final now = DateTime.now();
      final formatter = DateFormat('HH:mm:ss');
      if (mounted) {
        setState(() {
          _formattedTime = formatter.format(now);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        _formattedTime,
        style: const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
