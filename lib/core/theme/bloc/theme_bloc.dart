import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:pharmacist/core/services/cache_helper.dart';

import 'theme_event.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  static const String _themeKey = 'is_dark_theme';

  ThemeBloc() : super(const ThemeState(themeMode: ThemeMode.system)) {
    on<ThemeToggled>(_onThemeToggled);
    on<ThemeModeChanged>(_onThemeModeChanged);

    _loadSavedTheme();
  }

  Future<void> _loadSavedTheme() async {
    final isDark = CacheHelper.getBool(_themeKey);

    if (isDark == null) return;

    add(ThemeModeChanged(isDark ? ThemeMode.dark : ThemeMode.light));
  }

  Future<void> _onThemeToggled(
    ThemeToggled event,
    Emitter<ThemeState> emit,
  ) async {
    final isCurrentlyDark = state.isDark;
    final newMode = isCurrentlyDark ? ThemeMode.light : ThemeMode.dark;

    emit(state.copyWith(themeMode: newMode));
    await _saveTheme(newMode);
  }

  Future<void> _onThemeModeChanged(
    ThemeModeChanged event,
    Emitter<ThemeState> emit,
  ) async {
    emit(state.copyWith(themeMode: event.mode));
    await _saveTheme(event.mode);
  }

  Future<void> _saveTheme(ThemeMode mode) async {
    final isDark = mode == ThemeMode.dark;

    await CacheHelper.saveBool(key: _themeKey, value: isDark);
  }
}
