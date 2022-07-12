
class Club {
  String name;
  String logo;
  String id;
  List <Place1> place;
  String category;


  Club({this.name, this.logo, this.id,this.place,this.category});
  static Club fromMap(Map<String, dynamic> map) {
    List<Place1> place = [];
    if (map['place'] != null) {
      for (Iterable row in map['club']) {
        if (row == null) continue;
        for (Map map in row) {
          place.add(Place1.fromJson(map));
        }
      }
    }}

  factory Club.fromJson(Map<String, dynamic> json) => Club(


    name: json["name"],
    logo: json["logo"],
    place: List<Place1>.from(
        json["place"].map((x) => Place1.fromJson(x))),
    id: json["id"],
    category: json["category"],

  );

  Map<String, dynamic> toJson() => {


    "name": name,
    "logo": logo,

    "place": List<dynamic>.from(place.map((x) => x.toJson())),
    "id": id,
    "category": category,

  };
}
class Place1 {
  int longitude;
  int latitude;

  Place1({this.longitude, this.latitude});

  factory Place1.fromJson(Map<dynamic, dynamic> json) => Place1(
    longitude: json["longitude"],
    latitude: json["latitude"],

  );

  Map<String, dynamic> toJson() => {
    "longitude": ["longitude"],

    "latitude": latitude,

  };

}