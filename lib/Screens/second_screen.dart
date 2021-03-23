import 'dart:async';
import 'package:bordered_text/bordered_text.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:star_wars_project/Models/dark_mode_controller.dart';
import 'package:star_wars_project/Models/mode_controller.dart';
import 'package:star_wars_project/Models/my_character_controller.dart';
import 'package:star_wars_project/Models/character.dart';
import 'package:star_wars_project/Widgets/second_screen_body_widget.dart';
import 'package:star_wars_project/service.dart';

class SecondScreen extends StatefulWidget {
  SecondScreen();

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen>
    with SingleTickerProviderStateMixin<SecondScreen> {
  Character character;
  int index = 0;
  ImageProvider background = AssetImage("Assets/fondo3.jpg");
  ImageProvider backgroundDark = AssetImage("Assets/fondo4.jpg");
  bool sendingPost = false;
  bool postSent = false;
  bool postError = false;

  @override
  void didChangeDependencies() {
    if (index == 0) {
      getCharacter();
      index++;
    }
    super.didChangeDependencies();
  }

  void getCharacter() async {
    character = Provider.of<MyCharacterController>(context).selectedCharacter;
  }

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar();
    return Consumer(
      builder: (BuildContext context, DarkModeController darkModeController,
          Widget child) {
        return Material(
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: darkModeController.isDarkMode
                            ? backgroundDark
                            : background)),
              ),
              Column(
                children: [
                  SizedBox(height: 30),
                  Container(
                    width: double.infinity,
                    height: appBar.preferredSize.height - 10,
                    child: IconButton(
                      padding: const EdgeInsets.all(12.0),
                      alignment: Alignment.centerLeft,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      iconSize: 34,
                      icon: Icon(Icons.arrow_back,
                          color: darkModeController.isDarkMode
                              ? Colors.white
                              : Colors.black),
                    ),
                  ),
                  character == null
                      ? Expanded(
                          child: Container(
                            width: 300,
                            child: Center(
                              child: BorderedText(
                                strokeWidth: 2.5,
                                strokeColor: Color(0xFFFFE444),
                                child: Text(
                                  "No data. Please try again later..."
                                      .toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 25,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : SecondScreenBodyWidget(),
                  SizedBox(height: 110)
                ],
              ),
              character == null
                  ? Container()
                  : Align(
                      alignment: Alignment.bottomCenter,
                      child: Consumer(
                        builder: (BuildContext _context,
                            ModeController modeController, Widget child) {
                          return postError
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 15),
                                  child: BorderedText(
                                    strokeWidth: 2.5,
                                    strokeColor: Color(0xFFFFE444),
                                    child: Text(
                                      "We couldn't send the report. Please try again later..."
                                          .toUpperCase(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                  ),
                                )
                              : modeController.isOnline
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                                      child: AnimatedCrossFade(
                                        crossFadeState: !postSent
                                            ? CrossFadeState.showFirst
                                            : CrossFadeState.showSecond,
                                        duration: Duration(seconds: 1),
                                        firstChild: Container(
                                          height: 60,
                                          width: 300,
                                          child: FloatingActionButton.extended(
                                              backgroundColor: Colors.black,
                                              shape: Border.all(
                                                  color: Color(0xFFFFE444),
                                                  width: 4),
                                              onPressed: () {
                                                if (!sendingPost) {
                                                  setState(() {
                                                    sendingPost = true;
                                                  });
                                                  checkAndSendPost();
                                                }
                                              },
                                              label: Text(
                                                "Report",
                                                style: TextStyle(
                                                    color: Color(0xFFFFE444),
                                                    fontSize: 20),
                                              )),
                                        ),
                                        secondChild: Container(
                                          height: 60,
                                          width: 300,
                                          child: Container(
                                              height: 80,
                                              width: 80,
                                              decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  border: Border.all(
                                                      color: Color(0xFFFFE444),
                                                      width: 4),
                                                  shape: BoxShape.circle),
                                              child: Icon(Icons.check,
                                                  color: Color(0xFFFFE444),
                                                  size: 45)),
                                        ),
                                      ),
                                    )
                                  : Container();
                        },
                      ),
                    )
            ],
          ),
        );
      },
    );
  }

  void checkAndSendPost() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      print("No connection, cant refresh");
      Provider.of<ModeController>(context, listen: false)
          .changeMode(connectivityBoolean: false);
    } else {
      sendPost(character).then((result) {
        if (result == 1) {
          Timer(Duration(seconds: 1), () {
            setState(() {
              postSent = true;
            });
          });
        }
      });
    }
  }
}
