import 'package:flutter/material.dart';

class MyStyles {
  static Color backgroundColor = Colors.white;

  static Color appBarColor = const Color(0xFF8E44AD);

  static Color purple = const Color(0xFF8E44AD);
  static Color lightPurple = const Color(0xFFA569BD);
  static Color lightestPurple = const Color(0xFFC8A2D8);

  static Color grey = const Color(0xFF212121);
  static Color green = const Color(0xFF80DB80);
  static Color red = const Color(0xFFB22222);

  // style dla inputów
  static InputDecoration inputStyle = InputDecoration(
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide.none,
    ),
    contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
    hintText: 'Enter text',
    hintStyle: const TextStyle(color: Colors.grey),
  );

  // przyciski
  static ButtonStyle buttonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(purple),
    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
    textStyle: MaterialStateProperty.all<TextStyle>(
      const TextStyle(fontSize: 20.0),
    ),
    shape: MaterialStateProperty.all<OutlinedBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
      const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
    ),
    elevation: MaterialStateProperty.all<double>(5.0), // Dodanie cienia
    shadowColor: MaterialStateProperty.all<Color>(Colors.grey), // Kolor cienia
  );

  // napisy
  static TextStyle backgroundTextStyle = const TextStyle(
    color: Colors.white,
    fontSize: 24.0,
  );

  // napisy na przyciskach
  static TextStyle buttonTextStyle = const TextStyle(
    color: Colors.white,
    fontSize: 16.0,
  );


  // napisy na inputach
  static TextStyle inputTextStyle = const TextStyle(
    color: Colors.black,
    fontSize: 16.0,
  );
}