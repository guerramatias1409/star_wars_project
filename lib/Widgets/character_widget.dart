import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Controllers/my_character_controller.dart';
import 'package:star_wars_project/Models/character.dart';
import 'package:star_wars_project/Screens/second_screen.dart';

class CharacterWidget extends StatefulWidget {
  final Character character;

  CharacterWidget({this.character});

  @override
  _CharacterWidgetState createState() => _CharacterWidgetState();
}

class _CharacterWidgetState extends State<CharacterWidget> {
  @override
  Widget build(BuildContext context) {
    num height = widget.character.height;
    num weight = widget.character.weight;
    return GestureDetector(
      onTap: () {
        selectAndGoToSecondScreen();
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ),
        color: Colors.white.withOpacity(0.3),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(widget.character.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center),
              Text(
                  height == null
                      ? "Height: unknown"
                      : height > 100
                          ? "Height: ${height / 100}m"
                          : "Height: ${height}cm",
                  style: TextStyle(fontSize: 15)),
              Text(weight == null ? "Weight: unknown" : "Weight: $weight kg",
                  style: TextStyle(fontSize: 15)),
              Text("Gender: ${widget.character.gender}",
                  style: TextStyle(fontSize: 15))
            ],
          ),
        ),
      ),
    );
  }

  void selectAndGoToSecondScreen() {
    Provider.of<MyCharacterController>(context, listen: false)
        .selectCharacter(widget.character);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SecondScreen()));
  }
}
