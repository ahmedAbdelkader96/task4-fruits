import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task4/ui/fruit_slider_page.dart';

void main() {
  runApp(const FruitsApp());
}

class FruitsApp extends StatelessWidget {
  const FruitsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Fruits App",
      theme: ThemeData(
        primaryColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          titleTextStyle: GoogleFonts.lato(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        textTheme: TextTheme(
          headline2: GoogleFonts.lato(
            fontWeight: FontWeight.w600,
            letterSpacing: -3,
            height: 0.9,
            fontSize: 64,
          ),
          headline5: GoogleFonts.lato(
            letterSpacing: -1,
            fontWeight: FontWeight.w500,
          ),
        ).apply(
          displayColor: Colors.white,
          bodyColor: Colors.white,
        ),
      ),
      home: const FruitsSliderPage(),
    );
  }
}
