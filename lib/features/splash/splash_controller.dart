import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pharmacist/features/main/presentation/views/main_screen_view.dart';

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
        MaterialPageRoute(builder: (_) => MainScreenView()),
      );
    });
  }
}
