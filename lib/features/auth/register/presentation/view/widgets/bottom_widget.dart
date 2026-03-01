import 'package:flutter/material.dart';
import 'package:pharmacist/features/auth/login/presentation/views/login_screen.dart';
import 'package:pharmacist/features/auth/widgets/custom_bottom_widget.dart';

class BottomWidget extends StatelessWidget {
  const BottomWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBottomWidget(
      message: "Already have an account?",
      actionText: "Login",
      onActionTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      },
    );
  }
}
