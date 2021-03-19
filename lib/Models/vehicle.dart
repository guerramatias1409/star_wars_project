class Vehicle{
  String name;

  Vehicle({this.name});

  factory Vehicle.fromJson(Map<String, dynamic> json){
    return Vehicle(
      name: json['name']
    );
  }
}