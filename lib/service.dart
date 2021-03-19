import 'package:http/http.dart' as http;
import 'package:star_wars_project/Models/planet.dart';
import 'package:star_wars_project/Models/starship.dart';
import 'package:star_wars_project/Models/vehicle.dart';
import 'package:star_wars_project/Models/character.dart';
import 'dart:convert';

Future<List<Character>> getAllCharacters() async {
  String charactersUrl = 'https://swapi.dev/api/people/';
  List<Character> characters = [];
  var response = await http.get(Uri.parse(charactersUrl));
  var jsonData = json.decode(response.body);
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
  return characters;
}

Future<Planet> getPlanet(String planetEndpoint) async{
  var response = await http.get(Uri.parse(planetEndpoint.replaceAll('http:', 'https:')));
  return Planet.fromJson(json.decode(response.body));
}

Future<List<Vehicle>> getCharacterVehicles(dynamic vehiclesList) async{
  List<Vehicle> vehicles = [];
  var list = vehiclesList as List;
  list.forEach((element) async{
    var response = await http.get(Uri.parse(element.replaceAll("http", "https")));
    vehicles.add(Vehicle.fromJson(json.decode(response.body)));
  });
  return vehicles;
}

Future<List<Starship>> getCharacterStarships(dynamic starshipsList) async{
  List<Starship> starships = [];
  var list = starshipsList as List;
  list.forEach((element) async{
    var response = await http.get(Uri.parse(element.replaceAll("http", "https")));
    starships.add(Starship.fromJson(json.decode(response.body)));
  });
  return starships;
}


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

