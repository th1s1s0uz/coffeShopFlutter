import 'package:coffeshopflutter1/wellcome.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'color_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.aBeeZeeTextTheme(),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorManager.primaryColor,
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: ColorManager.appBarColor,
        ),
        cardTheme: CardTheme(
          color: ColorManager.cardBackgroundColor,
        ),
      ),
      home: WelcomePage(),
    );
  }
}
