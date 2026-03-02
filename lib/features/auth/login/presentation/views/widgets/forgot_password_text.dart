import 'package:flutter/material.dart';
import 'package:pharmacist/core/app_color.dart';

class ForgotPasswordText extends StatelessWidget {
  final VoidCallback onTap;

  const ForgotPasswordText({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: onTap,
        child: const Text(
          "Forgot Password?",
          style: TextStyle(
            color: AppColors.primaryblue,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}