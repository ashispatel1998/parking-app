import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

import '../main.dart';
import 'main-screen.dart';
class SplashScreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 5,
      navigateAfterSeconds: MainScreen(),
      title: Text(
        'PAH',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35.0 ),
      ),
      photoSize: 100,
      image:  Image(
        image: AssetImage('assets/images/car.gif'),
      ),
      backgroundColor: Colors.white,
      loaderColor: Colors.black,
      loadingText: Text('Getting things ready for you!'),
    );
  }
}

