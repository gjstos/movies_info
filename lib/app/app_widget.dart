import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Modular.navigatorKey,
      title: 'Flutter Slidy',
      theme: ThemeData(
        textTheme: GoogleFonts.nanumGothicTextTheme(),
        accentColor: Colors.white60,
        scaffoldBackgroundColor: Colors.grey[900],
        appBarTheme: ThemeData().appBarTheme.copyWith(color: Colors.black),
      ),
      initialRoute: '/',
      onGenerateRoute: Modular.generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
