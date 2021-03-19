class Starship{
  String name;

  Starship({this.name});

  factory Starship.fromJson(Map<String, dynamic> json){
    return Starship(
        name: json['name']
    );
  }
}