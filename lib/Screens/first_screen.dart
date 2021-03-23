import 'dart:async';

import 'package:bordered_text/bordered_text.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:star_wars_project/Models/character.dart';
import 'package:star_wars_project/Models/dark_mode_controller.dart';
import 'package:star_wars_project/Models/mode_controller.dart';
import 'package:star_wars_project/Widgets/character_widget.dart';
import 'package:star_wars_project/Widgets/loading_widget.dart';
import 'package:star_wars_project/service.dart';

class FirstScreen extends StatefulWidget {
  FirstScreen({Key key}) : super(key: key);

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen>
    with TickerProviderStateMixin {
  Future<List<Character>> _future; //Use to avoid rebuilding FutureBuilder
  ImageProvider background = AssetImage("Assets/fondo3.jpg");
  ImageProvider darkBackground = AssetImage("Assets/fondo4.jpg");
  ImageProvider logo = AssetImage("Assets/logo.png");
  AnimationController animationController;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    Timer(Duration(seconds: 1), () {
      animationController.forward();
    });
    checkInitialConnection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (BuildContext context,
        ModeController connectivityController, Widget child) {
      return Consumer(builder: (BuildContext context,
          DarkModeController darkModeController, Widget child) {
        return Material(
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.black,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: darkModeController.isDarkMode
                            ? darkBackground
                            : background)),
              ),
              Scaffold(
                backgroundColor: Colors.transparent,
                drawer: Theme(
                  data: Theme.of(context).copyWith(
                    canvasColor: darkModeController.isDarkMode
                        ? Colors.white.withOpacity(0.9)
                        : Color(0xFF9B8C85).withOpacity(0.9),
                  ),
                  child: Drawer(
                    child: ListView(
                      children: [
                        Container(
                            padding: const EdgeInsets.fromLTRB(
                                16.0, 16.0, 16.0, 8.0),
                            margin: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              "Manage App Modes",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            )),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Divider(height: 5, color: Colors.black),
                        ),
                        Consumer(builder: (BuildContext context,
                            ModeController connectivityController,
                            Widget child) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Online Mode",
                                        style: TextStyle(fontSize: 22)),
                                    Switch(
                                        activeColor: Colors.black,
                                        inactiveThumbColor:
                                            Colors.black.withOpacity(0.4),
                                        value: connectivityController.isOnline,
                                        onChanged: (value) async {
                                          var result =
                                              await connectivityController
                                                  .changeMode(
                                                      connectivityBoolean:
                                                          value);
                                          if (result == 0) {
                                            connectivityController
                                                .changeCantSwitch(true);
                                          }
                                          if (result == 1) {
                                            connectivityController
                                                .changeCantSwitch(false);
                                          }
                                          if (connectivityController.isOnline ==
                                              true) {
                                            refreshList();
                                          }
                                        })
                                  ],
                                ),
                                connectivityController.cantSwitch
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Text(
                                            "You need internet connection to switch",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: darkModeController
                                                        .isDarkMode
                                                    ? Colors.red
                                                    : Colors.black,
                                                fontWeight: FontWeight.bold)),
                                      )
                                    : Container(),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                      "(Offline Mode won't allow you to reload data or send reports. To do this, switch to Online Mode)",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 13)),
                                ),
                                SizedBox(height: 10),
                                Divider(height: 5, color: Colors.black),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Dark Mode",
                                        style: TextStyle(fontSize: 22)),
                                    Switch(
                                        activeColor: Colors.black,
                                        inactiveThumbColor:
                                            Colors.black.withOpacity(0.4),
                                        value: darkModeController.isDarkMode,
                                        onChanged: (value) {
                                          darkModeController
                                              .changeDarkMode(value);
                                        })
                                  ],
                                )
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  iconTheme: IconThemeData(
                      color: darkModeController.isDarkMode
                          ? Colors.white
                          : Colors.black),
                ),
                body: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, bottom: 10),
                      child: FadeTransition(
                          opacity: animationController
                              .drive(CurveTween(curve: Curves.easeOut)),
                          child: Column(
                            children: [
                              Container(
                                height: 150,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover, image: logo)),
                              ),
                              BorderedText(
                                strokeWidth: 4,
                                strokeColor: Color(0xFFFFE444),
                                child: Text(
                                  "INVASION",
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              )
                            ],
                          )),
                    ),
                    SizedBox(height: 10),
                    connectivityController.isOnline == false && _future == null
                        ? Expanded(
                            child: Container(
                              width: 300,
                              child: Center(
                                child: BorderedText(
                                  strokeWidth: 2.5,
                                  strokeColor: Color(0xFFFFE444),
                                  child: Text(
                                    "You need connection to get data. Switch to Online Mode"
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
                        : Flexible(
                            child: FutureBuilder(
                              future: _future,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  return snapshot.data == null
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
                                                    decoration:
                                                        TextDecoration.none,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : GridView.count(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8),
                                          crossAxisCount: 2,
                                          children:
                                              _characterList(snapshot.data),
                                        );
                                } else {
                                  return LoadingWidget();
                                }
                              },
                            ),
                          ),
                  ],
                ),
              )
            ],
          ),
        );
      });
    });
  }

  List<Widget> _characterList(List<Character> listInfo) {
    List<Widget> list = [];
    listInfo.forEach((character) {
      list.add(CharacterWidget(character: character));
    });
    return list;
  }

  void rebuildList() async {
    print("Entro a rebuild");
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      print("No connection, cant refresh");
      Provider.of<ModeController>(context, listen: false)
          .changeMode(connectivityBoolean: false);
    } else {
      refreshList();
    }
  }

  void checkInitialConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    print(connectivityResult);
    if (connectivityResult == ConnectivityResult.none) {
      Provider.of<ModeController>(context, listen: false)
          .changeMode(connectivityBoolean: false);
    } else {
      Provider.of<ModeController>(context, listen: false)
          .changeMode(connectivityBoolean: true);
      refreshList();
    }
  }

  void refreshList() {
    setState(() {
      _future = getAllCharacters();
    });
  }
}
