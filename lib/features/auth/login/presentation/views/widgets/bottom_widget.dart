import 'package:flutter/material.dart';
import 'package:pharmacist/features/auth/register/presentation/view/register_screen.dart';
import 'package:pharmacist/features/auth/widgets/custom_bottom_widget.dart';

class BottomWidget extends StatelessWidget {
  const BottomWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBottomWidget(
      message: "Don't have an account?",
      actionText: "Sign Up",
      onActionTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RegisterScreen()),
        );
      },
    );
  }
}
