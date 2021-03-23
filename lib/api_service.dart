import 'package:http/http.dart' as http;
import 'package:star_wars_project/Models/planet.dart';
import 'package:star_wars_project/Models/starship.dart';
import 'package:star_wars_project/Models/vehicle.dart';
import 'package:star_wars_project/Models/character.dart';
import 'dart:convert';

Future<List<Character>> getAllCharacters() {
  return APIService().getAllCharacters();
}

Future<Planet> getPlanet(String planetEndpoint) {
  return APIService().getPlanet(planetEndpoint);
}

Future<List<Vehicle>> getCharacterVehicles(dynamic vehiclesList) {
  return APIService().getCharacterVehicles(vehiclesList);
}

Future<List<Starship>> getCharacterStarships(dynamic starshipsList) {
  return APIService().getCharacterStarships(starshipsList);
}

Future<int> sendPost(Character character) {
  return APIService().sendPost(character);
}

class APIService {
  Future<List<Character>> getAllCharacters() async {
    String charactersUrl = 'https://swapi.dev/api/people/';
    List<Character> characters = [];

    //TODO esta funcion solo toma los primeros 10 resultados
    var response = await http.get(Uri.parse(charactersUrl));
    var jsonData = json.decode(response.body);
    var list = jsonData['results'] as List;
    list.forEach((element) async {
      characters.add(Character.fromJson(element));
    });

    /*int index = 0;
    var jsonData;
    do {
      var response = await http.get(Uri.parse(index == 0
          ? charactersUrl
          : jsonData['next'].replaceAll('http:', 'https:')));
      jsonData = json.decode(response.body);
      var list = jsonData['results'] as List;
      list.forEach((element) async {
        characters.add(Character.fromJson(element));
      });
      index++;
    } while (jsonData['next'] != "" && jsonData['next'] != null);*/

    print("CHARACTERS LENGHT: ${characters.length}");

    return characters;
  }

  Future<Planet> getPlanet(String planetEndpoint) async {
    var response =
        await http.get(Uri.parse(planetEndpoint.replaceAll('http:', 'https:')));
    return Planet.fromJson(json.decode(response.body));
  }

  Future<List<Vehicle>> getCharacterVehicles(dynamic vehiclesList) async {
    List<Vehicle> vehicles = [];
    var list = vehiclesList as List;
    list.forEach((element) async {
      var response =
          await http.get(Uri.parse(element.replaceAll("http", "https")));
      vehicles.add(Vehicle.fromJson(json.decode(response.body)));
    });
    return vehicles;
  }

  Future<List<Starship>> getCharacterStarships(dynamic starshipsList) async {
    List<Starship> starships = [];
    var list = starshipsList as List;
    list.forEach((element) async {
      var response =
          await http.get(Uri.parse(element.replaceAll("http", "https")));
      starships.add(Starship.fromJson(json.decode(response.body)));
    });
    return starships;
  }

  Future<int> sendPost(Character character) async {
    final response = await http.post(
        Uri.parse('https://jsonplaceholder.typicode.com/posts/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'userId': 1,
          'dateTime': DateTime.now().toString(),
          'character_name': character.name
        }));

    if (response.statusCode == 201) {
      print("POST: ${response.body}");
      return 1;
    } else {
      print("FAILED TO POST, TRY AGAIN");
      return 0;
    }
  }
}
