import 'package:flutter/material.dart';

class AppThemes {
  ThemeData get lightTheme => ThemeData(
        brightness: Brightness.light,
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF007BFF),
          primaryContainer: Color(0xFF0056D2),
          secondary: Color(0xFFFFA500),
          secondaryContainer: Color(0xFFFFCC80),
          surface: Colors.white,
          error: Color(0xFFD32F2F),
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Color(0xFF212121),
          onError: Colors.white,
        ),
        scaffoldBackgroundColor: //Color(0xFF00FBFF),
            const Color(0xFFF3F4F6),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF3F4F6),
          iconTheme: IconThemeData(color: Color(0xFF007BFF)),
        ),
        iconTheme: const IconThemeData(color: Color(0xFF606060)),
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
          bodyMedium: TextStyle(fontSize: 16, color: Colors.black54),
          labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black54),
          labelSmall: TextStyle(fontSize: 12, color: Colors.black45),
          displayLarge: TextStyle(color: Color(0xFF212121), fontSize: 28, fontWeight: FontWeight.bold),
          titleMedium: TextStyle(color: Color(0xFF424242), fontSize: 20, fontWeight: FontWeight.w500),
          bodyLarge: TextStyle(color: Color(0xFF212121), fontSize: 16),
          bodySmall: TextStyle(color: Color(0xFF757575), fontSize: 14),
        ),
      );

  ThemeData get darkTheme => ThemeData(
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF90CAF9),
          primaryContainer: Color(0xFF42A5F5),
          secondary: Color(0xFFFFCC80),
          secondaryContainer: Color(0xFFFFA500),
          surface: Color(0xFF1E1E1E),
          error: Color(0xFFEF5350),
          onPrimary: Colors.black,
          onSecondary: Colors.black,
          onSurface: Colors.white,
          onError: Colors.black,
        ),
        scaffoldBackgroundColor: const Color(0xFF121212),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E1E1E),
          iconTheme: IconThemeData(color: Color(0xFF90CAF9)),
        ),
        iconTheme: const IconThemeData(color: Color(0xFFB0BEC5)),
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white70),
          bodyMedium: TextStyle(fontSize: 16, color: Colors.white54),
          labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white60),
          labelSmall: TextStyle(fontSize: 12, color: Colors.white54),
          displayLarge: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
          titleMedium: TextStyle(color: Color(0xFFE0E0E0), fontSize: 20, fontWeight: FontWeight.w500),
          bodyLarge: TextStyle(color: Colors.white, fontSize: 16),
          bodySmall: TextStyle(color: Color(0xFFBDBDBD), fontSize: 14),
        ),
      );
}
