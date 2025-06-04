import 'package:flutter/material.dart';

extension ThemeExtensions on BuildContext {
  Color get primaryColor => const Color(0xFFebad31);
  Color get secondaryColor => const Color(0xFFd7851b);
  Color get blackColor => Color(0xFF121212);
  Color get lightGrey => const Color(0xFFF5F5F5);
  Color get red => const Color.fromARGB(255, 244, 26, 26);
  Color get grey =>  const Color.fromARGB(255, 77, 77, 77);
  Color get green =>  Colors.green;
  Color get whiteColor => Colors.white;
  Color get transparent => Colors.transparent;

  TextStyle get titleLarge => Theme.of(this).textTheme.titleLarge!;
  TextStyle get bodyMedium => Theme.of(this).textTheme.bodyMedium!;
  TextStyle get bodyLarge => Theme.of(this).textTheme.bodyLarge!;
  TextStyle get bodySmall => Theme.of(this).textTheme.bodySmall!;
}
