import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacist/core/app_theme.dart';
import 'package:pharmacist/core/services/cache_helper.dart';
import 'package:pharmacist/core/theme/bloc/theme_bloc.dart';
import 'package:pharmacist/core/theme/bloc/theme_state.dart';
import 'package:pharmacist/features/splash/splash_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  runApp(Pharmacist());
}

class Pharmacist extends StatelessWidget {
  const Pharmacist({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            title: 'pharmacist',
            debugShowCheckedModeBanner: false,
            themeMode: themeState.themeMode,
            theme: AppThemes.lightTheme,
            darkTheme: AppThemes.darkTheme,
            home: SplashScreen(),
          );
        },
      ),
    );
  }
}

