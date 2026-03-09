import 'package:flutter/material.dart';

abstract class ThemeEvent {}

class ThemeToggled extends ThemeEvent {}

class ThemeModeChanged extends ThemeEvent {
  final ThemeMode mode;

  ThemeModeChanged(this.mode);
}

