import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:star_wars_project/Models/mode_controller.dart';
import 'package:star_wars_project/Models/my_character_controller.dart';
import 'package:star_wars_project/Screens/first_screen.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => MyCharacterController()),
    ChangeNotifierProvider(create: (context) => ModeController()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    precacheImage(AssetImage("Assets/fondo4.jpg"), context);
    precacheImage(AssetImage("Assets/fondo3.jpg"), context);
    precacheImage(AssetImage("Assets/logo.png"), context);
    return MaterialApp(
      title: 'Star Wars App',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.robotoMonoTextTheme(textTheme).copyWith(
          subtitle1: GoogleFonts.robotoMono(textStyle: GoogleFonts.robotoMono(
              textStyle: TextStyle(
                color: Colors.black,
                fontSize: 28,
                decoration: TextDecoration.none,
                letterSpacing: 18,
              )
          ))
        ),
      ),
      navigatorKey: navigatorKey,
      home: FirstScreen(),
    );
  }
}
