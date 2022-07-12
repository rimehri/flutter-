import 'dart:convert';
User userFromJson(String str) => User.fromJson(json.decode(str));

class User {
  final String image;

  final bool isActive ;
  final String id;
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String gender;
  final int resetCode;
  final String role;
  final String phone;

  final bool social;
  final String date;
  //List<Geade> grade = []58075633
  List<Stage> stage = [];
//List <Map<String,Object>> stage ;


  @override
  String toString() {
    return 'User{image: $image, isActive: $isActive,id: $id,  email: $email, password: $password, firstName: $firstName, lastName: $lastName, gender: $gender, resetCode:$resetCode, role: $role, stage:$stage,phone: $phone,social: $social, date: $date}';
  }

  User userFromJson(String str) => User.fromJson(json.decode(str));

  static User fromMap(Map<String, dynamic> map) {
    List<Stage> stage = [];
    if (map['stage'] != null) {
      for (Iterable row in map['stage']) {
        if (row == null) continue;
        for (Map map in row) {
          stage.add(Stage.fromJson(map));
        }
      }
    }}



  User({
    this.image,
    this.isActive,
      this.id,
    this.email,
    this.password,
      this.firstName,
      this.lastName,
    this.gender,
    this.resetCode,
      this.phone,
      this.role,
      this.social,
this.stage,



      this.date});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      image: json['image'],
    isActive: json['isActive'],
      id: json['_id'],
      email: json['email'],
      password: json['password'],

      firstName: json['firstName'],
      lastName: json['lastName'],

      gender: json['gender'],

      role: json['role'],

      resetCode: json['resetCode'],


      social: json['social'],
      date: json['date'],
     stage: List<Stage>.from(json["stage"].map((x) => Stage.fromJson(x))),
     // stage: [{"_id":"611d10f0390dec100cbf8d93","title":"aa","date":"2021-08-19T23:00:00.000Z","place":[{"_id":"611d10f0390dec100cbf8d94","longitude":-122.084,"latitude":37.4219983}],"category":"International","sensei":"aa"}]
    );
  }
}

class Stage {
  String title;
  String category;
  String sensei;
  List <Place> place;
  DateTime date;


  @override
  String toString() {
    return 'Stage{title: $title, category: $category, sensei: $sensei, place: $place, date: $date}';
  }

  Stage({this.title, this.category, this.sensei,this.place,this.date});
  static Stage fromMap(Map<String, dynamic> map) {
    List<Place> place = [];
    if (map['place'] != null) {
      for (Iterable row in map['stage']) {
        if (row == null) continue;
        for (Map map in row) {
          place.add(Place.fromJson(map));
        }
      }
    }}

  factory Stage.fromJson(Map<String, dynamic> json) => Stage(


    title: json["title"],
      date: DateTime.parse(json["date"]),
    place: List<Place>.from(
        json["place"].map((x) => Place.fromJson(x))),
    category: json["category"],
    sensei: json["sensi"],
  );

  Map<String, dynamic> toJson() => {


    "title": title,
    "date": date,
    "place": List<dynamic>.from(place.map((x) => x.toJson())),
    "category": category,
    "sensei": sensei,
  };
}
class Place {
  double longitude;
  double
  latitude;

  Place({this.longitude, this.latitude});

  factory Place.fromJson(Map<dynamic, dynamic> json) => Place(
    longitude: json["longitude"],
    latitude: json["latitude"],

  );

  Map<String, dynamic> toJson() => {
    "longitude": ["longitude"],

    "latitude": latitude,

  };

    }


/*

"image": "avatar.jpg",
"isActive": "false",
"_id": "60fec3cc61ce24000491d33f",
"email": "kmejri@yahoo.fr",
"password": "$2b$10$1DdFdqHz85kKSqYx.F/QpOUN.9WfThylh2ONoW2vG/MRlmDkcav6u",
"firstName": "kais",
"lastName": "mejri",
"gender": "Male",
"role": "sensei",
"resetCode": 9047,
"address": [],
"grade": [],
"stage": [],
"attestation": [],
"club": [],
"socialMedia": [],
"__v": 0*/
