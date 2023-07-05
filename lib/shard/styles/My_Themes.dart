import 'package:flutter/material.dart';
import 'clors.dart';
class MyThemeData {
  static final ThemeData lightTheme = ThemeData(
    fontFamily: 'Poppins',
    primaryColor: Colors.purple,
    primarySwatch: Colors.purple,
    scaffoldBackgroundColor: mainBackgroundColor,
    colorScheme: ColorScheme(
      primary: Colors.purple,
      onPrimary: Colors.white,
      secondary: GreenColor,
      onSecondary: Colors.white,
      error: Colors.red,
      onError: Colors.white,

      onSurface: Colors.grey,
      surface: Colors.white,
      onBackground: Colors.white,
      brightness: Brightness.light,
      background: mainBackgroundColor,
    ),
    // textTheme: TextTheme(
    //     displayLarge:  TextStyle(
    //         fontFamily: 'Poppins', fontSize: 18, color: Colors.grey, fontWeight: FontWeight.w500),
    //     displayMedium: TextStyle(
    //         fontFamily: 'Poppins', fontSize: 18, color: Colors.grey, fontWeight: FontWeight.w500),
    //     displaySmall: TextStyle(
    //         fontSize: 16, color: WhiteColor, fontWeight: FontWeight.w400)),
    appBarTheme: AppBarTheme(
      backgroundColor: PrimaryColor,
      elevation: 0,
      iconTheme: IconThemeData(color: WhiteColor),
    ),
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: PrimaryColor),
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.transparent),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: PrimaryColor, unselectedItemColor: GreyColor),
  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: Colors.purple,
    primarySwatch: Colors.purple,
    scaffoldBackgroundColor: mainBackgroundColorDark,
    colorScheme: ColorScheme(
      primary: Colors.purple,
      onPrimary: Colors.white,
      secondary: GreenColor,
      onSecondary: Colors.white,
      error: Colors.red,
      onError: Colors.white,
      onSurface: Colors.grey,
      surface: Colors.white,
      onBackground: Colors.white,
      brightness: Brightness.light,
      background: mainBackgroundColorDark,
    ),
    // textTheme: TextTheme(
    //
    //     displayLarge: TextStyle(
    //         fontFamily: 'Poppins', fontSize: 18, color: Colors.grey, fontWeight: FontWeight.w500),
    //     displayMedium: TextStyle(
    //         fontFamily: 'Poppins', fontSize: 18, color: Colors.purple, fontWeight: FontWeight.w500),
    //     displaySmall: TextStyle(
    //         fontSize: 16, color: WhiteColor, fontWeight: FontWeight.w400)),
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF141922),
      elevation: 0,
      iconTheme: IconThemeData(color: WhiteColor),

    ),
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: PrimaryColor),
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.transparent),
    canvasColor: Color(0xFF141922),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF141922),
      selectedItemColor: PrimaryColor,
      unselectedItemColor: GreyColor,
    ),
  );
}
