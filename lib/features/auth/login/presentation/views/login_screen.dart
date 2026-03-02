import 'package:flutter/material.dart';
import 'package:pharmacist/features/auth/login/presentation/views/widgets/bottom_widget.dart';
import 'package:pharmacist/features/auth/login/presentation/views/widgets/login_form.dart';
import 'package:pharmacist/features/auth/widgets/header_section.dart';
import 'package:pharmacist/features/auth/login/presentation/views/widgets/lottie_background.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LottieBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            const HeaderSection(),
            const SizedBox(height: 100),
            const LoginForm(),
            const Spacer(),
            BottomWidget(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
