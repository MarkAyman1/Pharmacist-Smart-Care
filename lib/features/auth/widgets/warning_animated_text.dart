import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WarningAnimatedText extends StatelessWidget {
  final String text;

  const WarningAnimatedText({
    super.key,
    this.text = "This version is restricted to licensed pharmacists only",
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // final colorScheme = theme.colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.warning_amber_rounded,
          color: Colors.orange.shade700,
          size: 22,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: AnimatedTextKit(
            repeatForever: true,
            pause: const Duration(seconds: 2),
            animatedTexts: [
              TypewriterAnimatedText(
                text,
                textStyle: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.orange.shade800,
                  fontWeight: FontWeight.w600,
                ),
                speed: const Duration(milliseconds: 40),
              ),
            ],
            isRepeatingAnimation: true,
            displayFullTextOnTap: true,
          ),
        ),
      ],
    );
  }
}
