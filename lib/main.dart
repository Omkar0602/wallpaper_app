import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallpaper_app/views/home.dart';
import 'package:wallpaper_app/views/widget/widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WallpapersHub',
      theme: ThemeData(
       
        primarySwatch: Colors.blue,
      ),
      home: AnimatedSplashScreen(
            duration: 3000,
            splash:  Lottie.network("https://assets7.lottiefiles.com/packages/lf20_iwlmrnb5.json"),
            
            nextScreen: const Home(),
            splashIconSize: 250,
            splashTransition: SplashTransition.sizeTransition,
            pageTransitionType: PageTransitionType.leftToRightWithFade,
            backgroundColor: Colors.white)
    );
  }
}
