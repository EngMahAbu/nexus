import 'package:flutter/material.dart';
import 'colors.dart';

// App Light Theme
ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme(
    // Required
    brightness: Brightness.light,
    primary: primaryColor,
    onPrimary: onPrimaryColor,
    secondary: secondaryColor,
    onSecondary: onSecondaryColor,
    error: errorColor,
    onError: onErrorColor,
    surface: surface2Color,
    onSurface: onSurfaceColor,
    // Optional
  ),
  appBarTheme: AppBarThemeData(
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 24,
      color: primaryColor,
    ),
    backgroundColor: Colors.white,
    elevation: 20,
    actionsPadding: EdgeInsetsDirectional.only(end: 10),
    actionsIconTheme: IconThemeData(
      color: neutralColor,
      size: 20,
    )
  ),
  scaffoldBackgroundColor: surface2Color,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: primaryColor,
  ),
);
//   primarySwatch: defaultColor,

//   scaffoldBackgroundColor: Colors.white,
//   floatingActionButtonTheme: FloatingActionButtonThemeData(
//     backgroundColor: defaultColor,
//   ),
//   bottomNavigationBarTheme: BottomNavigationBarThemeData(
//     backgroundColor: Colors.white,
//     selectedItemColor: Colors.deepOrange,
//     selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
//     showUnselectedLabels: false,
//     unselectedIconTheme: IconThemeData(color: Colors.grey[700]),
//     type: BottomNavigationBarType.fixed,
//   ),
//   progressIndicatorTheme: ProgressIndicatorThemeData(color: Colors.deepOrange),
//   textTheme: TextTheme(
//     titleLarge: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
//     titleMedium: TextStyle(color: Colors.black),
//   ),
//   iconTheme: IconThemeData(color: Colors.black),
// );
//
//
// // App Dark Theme
// ThemeData darkTheme = ThemeData(
//   primarySwatch: defaultColor,
//   appBarTheme: AppBarThemeData(
//     titleTextStyle: TextStyle(
//       fontWeight: FontWeight.bold,
//       fontSize: 24,
//       color: Colors.white,
//     ),
//     backgroundColor: Colors.black54,
//     iconTheme: IconThemeData(color: Colors.grey),
//   ),
//   scaffoldBackgroundColor: Colors.black54,
//   bottomNavigationBarTheme: BottomNavigationBarThemeData(
//     backgroundColor: Colors.black54,
//     selectedItemColor: Colors.white,
//     selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
//     showUnselectedLabels: false,
//     unselectedIconTheme: IconThemeData(color: Colors.grey[700]),
//     type: BottomNavigationBarType.fixed,
//   ),
//   progressIndicatorTheme: ProgressIndicatorThemeData(color: Colors.grey),
//   textTheme: TextTheme(
//     titleLarge: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//     titleMedium: TextStyle(color: Colors.white),
//   ),
//   iconTheme: IconThemeData(color: Colors.grey),
// );
