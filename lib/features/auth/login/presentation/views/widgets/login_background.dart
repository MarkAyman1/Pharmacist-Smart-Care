import 'package:flutter/material.dart';
import 'package:pharmacist/core/app_color.dart';

class LoginBackground extends StatelessWidget {
  final Widget child;

  const LoginBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primaryblue,
              AppColors.primaryLightColor,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(child: child),
      ),
    );
  }
}