import 'package:http/http.dart' as http;
import 'package:star_wars_project/Models/planet.dart';
import 'package:star_wars_project/Models/starship.dart';
import 'package:star_wars_project/Models/vehicle.dart';
import 'package:star_wars_project/Models/character.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;


  Future<List<Character>> getAllCharacters() async {
    print("getAllCharacters");
    List<Character> characters = [];
    String jsonPage = await rootBundle.loadString('Assets/people1.json');
    final jsonResponse = json.decode(jsonPage);
    var list = jsonResponse['results'] as List;
    list.forEach((element) async {
      characters.add(Character.fromJson(element));
    });
    print("CHARACTERS LENGHT: ${characters.length}");
    return characters;


    /*String charactersUrl = 'https://swapi.dev/api/people/';
    List<Character> characters = [];
    var response = await http.get(Uri.parse(charactersUrl));
    var jsonData = json.decode(response.body);
    print("RESPONSE ${response.statusCode}");
    print("RESPONSE BODY ${response.body}");
    var list = jsonData['results'] as List;
    list.forEach((element) async {
      characters.add(Character.fromJson(element));
    });
    while(jsonData['next'] != "" && jsonData['next'] != null){
      String next = jsonData['next'];
      response = await http.get(Uri.parse(next.replaceAll('http:', 'https:')));
      jsonData = json.decode(response.body);
      list = jsonData['results'] as List;
      list.forEach((element) async {
        characters.add(Character.fromJson(element));
      });
    }
    print("CHARACTERS LENGHT: ${characters.length}");
    return characters;*/
  }

  String getPlanet(String planetEndpoint) {
  return planetEndpoint;
  }

  /*Future<Planet> getPlanet(String planetEndpoint) async{
    var response = await http.get(Uri.parse(planetEndpoint.replaceAll('http:', 'https:')));
    return Planet.fromJson(json.decode(response.body));
  }*/

  List<String> getCharacterVehicles(dynamic vehiclesList) {
  List<String> vehicles = [];
  var list = vehiclesList as List;
  list.forEach((element) async{
    vehicles.add(element.toString());
  });
  return vehicles;
  }

  /*Future<List<Vehicle>> getCharacterVehicles(dynamic vehiclesList) async{
    List<Vehicle> vehicles = [];
    var list = vehiclesList as List;
    list.forEach((element) async{
      var response = await http.get(Uri.parse(element.replaceAll("http", "https")));
      vehicles.add(Vehicle.fromJson(json.decode(response.body)));
    });
    return vehicles;
  }*/

  List<String> getCharacterStarships(dynamic starshipsList) {
  List<String> starships = [];
  var list = starshipsList as List;
  list.forEach((element) async{
    starships.add(element);
  });
  return starships;
  }

  /*Future<List<Starship>> getCharacterStarships(dynamic starshipsList) async{
    List<Starship> starships = [];
    var list = starshipsList as List;
    list.forEach((element) async{
      var response = await http.get(Uri.parse(element.replaceAll("http", "https")));
      starships.add(Starship.fromJson(json.decode(response.body)));
    });
    return starships;
  }*/


  Future<void> sendPost(Character character) async{
    print("send post init");
    final response = await http.post(Uri.parse('https://jsonplaceholder.typicode.com/posts/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'userId': 1,
          'dateTime': DateTime.now().toString(),
          'character_name': character.name
        }));

    if(response.statusCode == 201){
      print("POST SENT");
      print("POST: ${response.body}");
    }else{
      print("FAILED TO POST, TRY AGAIN");
    }
  }



