import 'package:flutter/material.dart';
import 'package:pharmacist/features/auth/widgets/header_section.dart';
import 'package:pharmacist/features/auth/login/presentation/views/widgets/lottie_background.dart';
import 'package:pharmacist/features/auth/register/presentation/view/widgets/bottom_widget.dart';
import 'package:pharmacist/features/auth/register/presentation/view/widgets/register_form.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LottieBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const HeaderSection(),
                const SizedBox(height: 50),
                const RegisterForm(),
                const SizedBox(height: 20),
                BottomWidget(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
