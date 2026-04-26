import 'package:flutter/material.dart';
import 'package:pharmacist/core/widgets/profile_drawer.dart';

class ProfileIconButton extends StatelessWidget {
  const ProfileIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        ProfileDrawer.controller?.showDrawer();
      },
      icon: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.person, color: Colors.white, size: 24),
      ),
    );
  }
}
