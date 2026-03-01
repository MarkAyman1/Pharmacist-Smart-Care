import 'package:flutter/material.dart';
import 'package:pharmacist/features/auth/widgets/header.dart';
import 'package:pharmacist/features/auth/widgets/warning_animated_text.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(height: 20),
        Header(),
        SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: WarningAnimatedText(),
        ),
        // SizedBox(height: 30),
      ],
    );
  }
}
