import 'dart:async';

import 'package:bordered_text/bordered_text.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:star_wars_project/Models/character.dart';
import 'package:star_wars_project/Models/mode_controller.dart';
import 'package:star_wars_project/Widgets/character_widget.dart';
import 'package:star_wars_project/service.dart';

class FirstScreen extends StatefulWidget {
  FirstScreen({Key key}) : super(key: key);

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen>
    with TickerProviderStateMixin {
  Future<List<Character>> _future;
  ImageProvider background = AssetImage("Assets/fondo4.jpg");
  ImageProvider logo = AssetImage("Assets/logo.png");
  AnimationController animationController;

  @override
  void initState() {
    print("first screen init state");
    animationController = AnimationController(
        vsync: this, duration: Duration(seconds: 3));
    Timer(Duration(seconds: 1),(){
      animationController.forward();
    });
    checkInitialConnection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (BuildContext context,
        ModeController connectivityController, Widget child) {
      return Material(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(
                      fit: BoxFit.fitHeight, image: background)),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 30, left: 16, right: 16, bottom: 10),
                  child: FadeTransition(
                      opacity: animationController
                          .drive(CurveTween(curve: Curves.easeOut)),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              animationController.repeat();
                            },
                            child: Container(
                              height: 150,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover, image: logo)),
                            ),
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
                    ? Center(
                        child: Text(
                        "You need connection to get data",
                        style: TextStyle(color: Colors.white),
                      ))
                    : Flexible(
                        child: FutureBuilder(
                          future: _future,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return GridView.count(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                crossAxisCount: 2,
                                children: _characterList(snapshot.data),
                              );
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          },
                        ),
                      )
              ],
            )

/*          Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                title: Text("Star Wars Project"),
                actions: [
                  Consumer(builder: (BuildContext context,
                      ModeController connectivityController, Widget child) {
                    return Switch(
                        value: connectivityController.isOnline,
                        onChanged: (value) async{
                          await connectivityController.changeMode(
                              connectivityBoolean: value);
                          if(connectivityController.isOnline == true){
                            refreshList();
                          }
                        });
                  })
                ],
              ),
              body: connectivityController.isOnline == false && _future == null
                  ? Center(child: Text("You need connection to get data"))
                  : FutureBuilder(
                      future: _future,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return ListView(
                            children: _characterList(snapshot.data),
                          );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },
                    ),
              floatingActionButton: connectivityController.isOnline
                  ? FloatingActionButton(
                      onPressed: () {
                        rebuildList();
                      },
                      child: Icon(Icons.refresh),
                    )
                  : Container(),
            )*/
            ,
          ],
        ),
      );
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
