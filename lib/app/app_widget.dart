import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Modular.navigatorKey,
      title: 'MoviesInfo',
      theme: ThemeData(
        textTheme: GoogleFonts.ubuntuTextTheme(),
        accentColor: Color(0xff6C63FF),
        scaffoldBackgroundColor: Colors.black,
        appBarTheme:
            ThemeData().appBarTheme.copyWith(color: const Color(0xff272727)),
        primaryTextTheme: GoogleFonts.ubuntuTextTheme(),
      ),
      initialRoute: '/',
      onGenerateRoute: Modular.generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
