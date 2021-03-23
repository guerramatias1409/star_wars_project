import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'Controllers/dark_mode_controller.dart';
import 'Controllers/mode_controller.dart';
import 'Controllers/my_character_controller.dart';
import 'package:star_wars_project/Screens/first_screen.dart';
import 'package:star_wars_project/Widgets/my_scroll_behavior.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => MyCharacterController()),
    ChangeNotifierProvider(create: (context) => ModeController()),
    ChangeNotifierProvider(create: (context) => DarkModeController())
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
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.robotoMonoTextTheme(textTheme).copyWith(
            subtitle1: GoogleFonts.robotoMono(
                textStyle: GoogleFonts.robotoMono(
                    textStyle: TextStyle(
          color: Colors.black,
          fontSize: 28,
          decoration: TextDecoration.none,
          letterSpacing: 18,
        )))),
      ),
      navigatorKey: navigatorKey,
      builder: (context, child) {
        return ScrollConfiguration(behavior: MyScrollBehavior(), child: child);
      },
      home: FirstScreen(),
    );
  }
}
