class Planet{
  String name;

  Planet({this.name});

  factory Planet.fromJson(Map<String, dynamic> json){
    return Planet(
        name: json['name']
    );
  }
}