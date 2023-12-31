import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'pages/login_page.dart';

class CalculadoraIMCApp extends StatelessWidget {
  const CalculadoraIMCApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.teal, textTheme: GoogleFonts.robotoTextTheme()),
      home: const LoginPage(),
    );
  }
}
