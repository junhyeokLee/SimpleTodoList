import 'package:flutter/material.dart';

class AppTheme {
  // 1
  static TextTheme lightTextTheme = const TextTheme(
    labelLarge: TextStyle(
        fontSize: 18.0, fontWeight: FontWeight.w400, color: Colors.black),
    bodyLarge: TextStyle(
        fontSize: 18.0, fontWeight: FontWeight.w400, color: Colors.black),
    bodyMedium: TextStyle(
        fontSize: 16.0, fontWeight: FontWeight.w400, color: Colors.black),
    displayLarge: TextStyle(
        fontSize: 40.0, fontWeight: FontWeight.w500, color: Colors.black),
    displayMedium: TextStyle(
        fontSize: 32.0, fontWeight: FontWeight.w400, color: Colors.black),
  );

  static TextTheme darkTextTheme = const TextTheme(
    labelLarge: TextStyle(
        fontSize: 18.0, fontWeight: FontWeight.w400, color: Colors.white),
    bodyLarge: TextStyle(
        fontSize: 18.0, fontWeight: FontWeight.w400, color: Colors.white),
    bodyMedium: TextStyle(
        fontSize: 16.0, fontWeight: FontWeight.w400, color: Colors.white),
    displayLarge: TextStyle(
        fontSize: 40.0, fontWeight: FontWeight.w500, color: Colors.white),
    displayMedium: TextStyle(
        fontSize: 32.0, fontWeight: FontWeight.w400, color: Colors.white),
  );

  // 2
  // static TextTheme darkTextTheme = const TextTheme(
  //   labelLarge: TextStyle(
  //       fontSize: 18.0, fontWeight: FontWeight.w400, color: Colors.white),
  //   bodyLarge: TextStyle(
  //       fontSize: 18.0, fontWeight: FontWeight.w400, color: Colors.white),
  //   bodyMedium: TextStyle(
  //       fontSize: 16.0, fontWeight: FontWeight.w400, color: Colors.white),
  //   displayLarge: TextStyle(
  //       fontSize: 40.0, fontWeight: FontWeight.w500, color: Colors.white),
  //   displayMedium: TextStyle(
  //       fontSize: 32.0, fontWeight: FontWeight.w400, color: Colors.white),
  // );

  // 3
  static light() {
    return ThemeData(
      useMaterial3: true,
      textTheme: lightTextTheme,
      fontFamily: 'Rubik',
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(32.0),
            ),
          ),
          backgroundColor: Colors.black87,
          foregroundColor: Colors.white),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.black87,
        // 원하는 배경색으로 변경
        indicatorColor: Colors.white,
        labelTextStyle: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white, // 선택된 텍스트 색상
            );
          }
          return TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.grey, // 선택되지 않은 텍스트 색상
          );
        }),
        iconTheme: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return IconThemeData(
              size: 30,
              color: Colors.black, // 선택된 아이콘 색상
            );
          }
          return IconThemeData(
            size: 24,
            color: Colors.grey, // 선택되지 않은 아이콘 색상
          );
        }),
      ),
      colorScheme: const ColorScheme.light().copyWith(
        primary: Colors.white,
        secondary: Colors.black87,
        brightness: Brightness.light,
      ),
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(Colors.black87),
        overlayColor: MaterialStateProperty.all(
          Colors.black54,
        ),
      )),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        elevation: 0,
        centerTitle: true,
        toolbarHeight: 64,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        labelStyle: TextStyle(color: Colors.black45),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            style: BorderStyle.solid,
            width: 2.0,
            color: Colors.black87,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            style: BorderStyle.solid,
            width: 2.0,
            color: Colors.black87,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            style: BorderStyle.solid,
            width: 1.0,
            color: Colors.black87,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
      ),
    );
  }

  // 4
  static dark() {
    return ThemeData(
      textTheme: darkTextTheme,
      fontFamily: 'Rubik',
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(32.0),
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.white,
        // 원하는 배경색으로 변경
        indicatorColor: Colors.black,
        labelTextStyle: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black, // 선택된 텍스트 색상
            );
          }
          return TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.grey, // 선택되지 않은 텍스트 색상
          );
        }),

        iconTheme: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return IconThemeData(
              size: 30,
              color: Colors.white, // 선택된 아이콘 색상
            );
          }
          return IconThemeData(
            size: 24,
            color: Colors.grey, // 선택되지 않은 아이콘 색상
          );
        }),
      ),
      colorScheme: const ColorScheme.dark().copyWith(
        primary: Colors.grey[900],
        secondary: Colors.white,
        brightness: Brightness.dark,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey[900],
        foregroundColor: Colors.white,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        elevation: 0,
        centerTitle: true,
        toolbarHeight: 64,
      ),
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(Colors.white),
        overlayColor: MaterialStateProperty.all(
          Colors.white54,
        ),
      )),
      inputDecorationTheme: const InputDecorationTheme(
        labelStyle: TextStyle(color: Colors.white54),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            style: BorderStyle.solid,
            width: 2.0,
            color: Colors.white54,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            style: BorderStyle.solid,
            width: 2.0,
            color: Colors.white54,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            style: BorderStyle.solid,
            width: 1.0,
            color: Colors.white54,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
      ),
    );
  }
}
