import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacist/core/theme/bloc/theme_bloc.dart';
import 'package:pharmacist/core/theme/bloc/theme_event.dart';
import 'package:pharmacist/core/theme/bloc/theme_state.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final isDark = state.isDark;

        return IconButton(
          tooltip: isDark ? 'Switch to light mode' : 'Switch to dark mode',
          icon: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            transitionBuilder: (child, animation) {
              return RotationTransition(
                turns: Tween<double>(begin: 0.75, end: 1).animate(animation),
                child: FadeTransition(opacity: animation, child: child),
              );
            },
            child: Icon(
              isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
              key: ValueKey<bool>(isDark),
              color: Colors.white,
            ),
          ),
          onPressed: () {
            context.read<ThemeBloc>().add(ThemeToggled());
          },
        );
      },
    );
  }
}

