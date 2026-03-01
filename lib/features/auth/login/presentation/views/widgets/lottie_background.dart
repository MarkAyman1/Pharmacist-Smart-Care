import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieBackground extends StatelessWidget {
  final Widget child;
  final String lottieAsset;

  const LottieBackground({
    super.key,
    required this.child,
    this.lottieAsset = 'assets/animations/3D Medical.json',
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Lottie covers the entire screen
        Positioned.fill(
          child: Lottie.asset(
            lottieAsset,
            fit: BoxFit.fill, // مهم جدًا عشان يغطي الشاشة كلها
            repeat: true,
          ),
        ),

        // Optional: overlay لتخفيف سطوع الأنيميشن
        Positioned.fill(child: Container(color: Colors.black.withOpacity(0.2))),

        // الـ UI فوق الخلفية
        SafeArea(child: child),
      ],
    );
  }
}
