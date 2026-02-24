import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pharmacist/main.dart';

class SplashController {
  final BuildContext context;
  final Duration duration;

  SplashController({
    required this.context,
    this.duration = const Duration(seconds: 5),
  });

  void start() {
    Timer(duration, () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MyHomePage(title: '')),
      );
    });
  }
}
