import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stage/Entities/User.dart';
import 'package:stage/config/public_vars.dart';


class Services {
  String id = "";


  List<Stage> stages = new List();
  SharedPreferences sharedPreferences;
  User _user;


  static Future getUser(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

   String id = prefs.getString('id');

    final Response = await http.get(Uri.parse(baseUrl+'/user/getUser/$id'));

    final String responseString = Response.body;
    print(userFromJson(responseString));

    User u = userFromJson(responseString);
    //print(stage);
    Map<String,dynamic> json = jsonDecode(responseString);
    List<dynamic> body = json['stage'];
    List<Stage> values =
    body.map((dynamic item) => Stage.fromJson(item)).toList();
    print(values[0].title);
    print(values[1].date);


    return userFromJson(responseString);

  }
  Future  getId() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
  String  id = prefs.getString('id');
    print("home : " + id);
return id;

  }
}
