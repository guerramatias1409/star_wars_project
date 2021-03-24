import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:star_wars_project/Controllers/dark_mode_controller.dart';

class BackgroundWidget extends StatelessWidget {
  final ImageProvider background = AssetImage("assets/Images/fondo3.jpg");
  final ImageProvider darkBackground = AssetImage("assets/Images/fondo4.jpg");

  @override
  Widget build(BuildContext context) {
    return Consumer<DarkModeController>(
      builder: (BuildContext context,
          DarkModeController darkModeController, Widget child){
        return Container(
          decoration: BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: darkModeController.isDarkMode
                      ? darkBackground
                      : background)),
        );
      },
    );
  }
}
