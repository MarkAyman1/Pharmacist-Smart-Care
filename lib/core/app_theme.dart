import 'package:flutter/material.dart';
import 'package:pharmacist/core/app_color.dart';
import 'package:pharmacist/main.dart';

// Defines the text styles for both light and dark typography
const TextTheme appTextTheme = TextTheme(
  headlineLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
  titleLarge: TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: AppColors.darkBackground,
  ),
  bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
  bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
  labelSmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
);

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primaryblue,
    useMaterial3: false,
    scaffoldBackgroundColor: AppColors.lightGrey,
    //colorScheme
    colorScheme: const ColorScheme(
      primary: AppColors.primaryblue,
      onPrimary: AppColors.black,
      secondary: AppColors.accentGreen,
      onSecondary: AppColors.darkGrey,
      surface: AppColors.white,
      onSurface: AppColors.darkGrey,
      error: Color(0xFFB00020),
      onError: AppColors.white,
      brightness: Brightness.light,
      primaryContainer: AppColors.primaryLightColor,
    ),
    textTheme: appTextTheme.apply(
      bodyColor: AppColors.darkGrey,
      displayColor: AppColors.darkGrey,
    ),

    // appBarTheme: const AppBarTheme(
    //   backgroundColor: AppColors.primaryblue,
    //   foregroundColor: AppColors.darkGrey,
    //   elevation: 0,
    //   titleTextStyle: TextStyle(
    //     color: AppColors.darkGrey,
    //     fontSize: 20,
    //     fontWeight: FontWeight.bold,
    //   ),
    // ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.white,
      selectedItemColor: AppColors.primaryblue,
      unselectedItemColor: AppColors.darkGrey,
    ),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        iconColor: WidgetStateProperty.all(AppColors.primaryLightColor),
      ),
    ),
    iconTheme: IconThemeData(
      color: AppColors.primaryLightColor,
      size: 24, // optional
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryLightColor,
        foregroundColor: AppColors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),

    cardTheme: const CardThemeData(
      color: Color(0xFFDEF7E4),
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color>((
        Set<WidgetState> states,
      ) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primaryblue;
        }
        return AppColors.mediumGrey;
      }),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: AppColors.primaryblue,
    useMaterial3: false,
    scaffoldBackgroundColor: AppColors.darkBackground,
    //colorScheme
    colorScheme: const ColorScheme(
      primary: AppColors.primaryblue,
      onPrimary: AppColors.white,
      secondary: AppColors.secondaryDarkColor,
      onSecondary: AppColors.darkOnSurface,
      surface: AppColors.darkSurface,
      onSurface: AppColors.darkOnSurface,
      error: Color(0xFFCF6679),
      onError: AppColors.white,
      brightness: Brightness.dark,
    ),
    textTheme: appTextTheme.apply(
      bodyColor: AppColors.darkOnSurface,
      displayColor: AppColors.darkOnSurface,
    ),
    // appBarTheme: const AppBarTheme(
    //   backgroundColor: AppColors.darkSurface,
    //   foregroundColor: AppColors.darkOnSurface,
    //   elevation: 0,
    //   titleTextStyle: TextStyle(
    //     color: AppColors.darkOnSurface,
    //     fontSize: 20,
    //     fontWeight: FontWeight.bold,
    //   ),
    // ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.darkSurface,
      selectedItemColor: AppColors.primaryblue,
      unselectedItemColor: AppColors.darkMediumGrey,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryblue,
        foregroundColor: AppColors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    cardTheme: const CardThemeData(
      color: AppColors.darkSurface,
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color>((
        Set<WidgetState> states,
      ) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primaryblue;
        }
        return AppColors.darkMediumGrey;
      }),
    ),
  );
  static AppBar customAppBar({
    required String title,
    bool showBackButton = false,
    bool isDarkMode = false,
  }) {
    final gradientColors = isDarkMode
        ? [AppColors.primaryblue, AppColors.secondaryDarkColor]
        : [AppColors.primaryblue, AppColors.primaryblue, AppColors.accentGreen];

    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(navigatorKey.currentContext!).pop(),
            )
          : null,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.25),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
      ),
    );
  }
}
