import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData themeData = ThemeData(
  primarySwatch: const MaterialColor(
    0xFF4DD0E1,
    _customMaterialColor,
  ),
  scaffoldBackgroundColor: backGroundColor,
  appBarTheme: const AppBarTheme(
    color: backGroundColor,
    centerTitle: true,
  ),
  elevatedButtonTheme: elevatedButtonThemeData(),
  iconButtonTheme: iconButtonThemeData(),
  textTheme: textTheme(),
);

TextTheme textTheme() {
  return TextTheme(
    headlineLarge: _textStyle(24.sp, FontWeight.bold, Color(0xFFFFFFFF)),
    headlineMedium: _textStyle(22.sp, FontWeight.bold, Color(0XFFFFFFFF)),
    headlineSmall: _textStyle(20.sp, FontWeight.w600, Color(0XFFFFFFFF)),
    bodyLarge: _textStyle(16.sp, FontWeight.normal, Color(0xFFD3D3D3)),
    bodySmall: _textStyle(14.sp, FontWeight.normal, Color(0xFFD3D3D3)),
  );
}

TextStyle _textStyle(double fontSize, FontWeight fontWeight, Color color) {
  return GoogleFonts.inter(
    textStyle: TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
    ),
  );
}

IconButtonThemeData iconButtonThemeData() {
  return IconButtonThemeData(
    style: ButtonStyle(
      backgroundColor:
          WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
        if (states.contains(WidgetState.pressed)) {
          return buttonDarkColor;
        }
        return buttonLightColor;
      }),
      foregroundColor: WidgetStateProperty.all<Color>(backGroundColor),
      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
        EdgeInsets.symmetric(
          vertical: verticalPadding,
          horizontal: horizontalPadding,
        ),
      ),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
      elevation: WidgetStateProperty.all<double>(elevation),
      overlayColor:
          WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
        if (states.contains(WidgetState.pressed)) {
          return buttonLightColor.withOpacity(0.2);
        }
        return Colors.transparent;
      }),
      iconColor: WidgetStateProperty.all<Color>(backGroundColor),
      textStyle: WidgetStateProperty.all<TextStyle>(
        GoogleFonts.inter(
          textStyle: TextStyle(
            color: backGroundColor,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ),
  );
}

ElevatedButtonThemeData elevatedButtonThemeData() {
  return ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor:
          WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
        if (states.contains(WidgetState.pressed)) {
          return buttonDarkColor;
        }
        return buttonLightColor;
      }),
      foregroundColor:
          WidgetStateProperty.all<Color>(backGroundColor), // Text color
      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
        EdgeInsets.symmetric(
          vertical: verticalPadding,
          horizontal: horizontalPadding,
        ),
      ),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
      elevation: WidgetStateProperty.all<double>(elevation),
      iconColor: WidgetStateProperty.all<Color>(backGroundColor),
      textStyle: WidgetStateProperty.all<TextStyle>(
        GoogleFonts.inter(
          textStyle: TextStyle(
            color: backGroundColor,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ),
  );
}

double radius = 8.r;
const double elevation = 4;
double verticalPadding = 10.h;
double horizontalPadding = 10.w;
double verticalMargin = 10.h;
double horizontalMargin = 10.w;
Size designViewport = const Size(411.4, 867.4);

const Color backGroundColor = Color(0xFF1A1A2E);
const Color foreGroundColor = Color(0x7E4DD0E1);
const Color accentColor = Color(0xFFFFD700);
const Color buttonLightColor = Color(0xFFFFD700);
const Color buttonDarkColor = Color(0xFFFFC107);
const Color whiteColor = Color(0xFFFFFFFF);

BoxShadow shadow = BoxShadow(
  color: Colors.grey.withOpacity(0.5),
  spreadRadius: 0,
  blurRadius: 2,
  offset: const Offset(0, 3),
);

const Map<int, Color> _customMaterialColor = {
  50: Color.fromRGBO(136, 14, 79, .1),
  100: Color.fromRGBO(136, 14, 79, .2),
  200: Color.fromRGBO(136, 14, 79, .3),
  300: Color.fromRGBO(136, 14, 79, .4),
  400: Color.fromRGBO(136, 14, 79, .5),
  500: Color.fromRGBO(136, 14, 79, .6),
  600: Color.fromRGBO(136, 14, 79, .7),
  700: Color.fromRGBO(136, 14, 79, .8),
  800: Color.fromRGBO(136, 14, 79, .9),
  900: Color.fromRGBO(136, 14, 79, 1),
};
