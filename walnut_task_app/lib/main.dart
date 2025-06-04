import 'package:flutter/material.dart';
import 'package:walnut_task_app/product/constants/routing_constants.dart';
import 'package:walnut_task_app/product/initialize/app_initilaze.dart';

void main() async {
  await ApplicationStart.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFFF5F5F5),
        cardColor: Colors.transparent,
        shadowColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Color(0xFFF5F5F5),
        ),
        fontFamily: 'Poppins',
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontWeight: FontWeight.w400),
          bodyLarge: TextStyle(fontWeight: FontWeight.w500),
          bodySmall: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
          titleLarge: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      title: 'Walnut Task App',
      debugShowCheckedModeBanner: false,
      initialRoute: myAppointmentsView,
      onGenerateRoute: RoutingConstants.createRoute,
    );
  }
}
