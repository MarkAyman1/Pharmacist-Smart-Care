import 'package:flutter/material.dart';

class OrderDetailsScrollView extends StatelessWidget {
  const OrderDetailsScrollView({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: child,
    );
  }
}
