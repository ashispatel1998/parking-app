import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Screens/forgot-password-screen.dart';
import 'Screens/splash-screen.dart';
import 'Screens/user-create-account-screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return MaterialApp(
      title: 'PAH',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme:
              GoogleFonts.josefinSansTextTheme(Theme.of(context).textTheme)),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreenPage(),
        'forgotpassword': (context) => ForgotPasswordScreen(),
        'usercreateaccount': (context) => CreateAccountScreen(),
      },
    );
  }
}
