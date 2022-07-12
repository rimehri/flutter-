import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stage/Entities/User.dart';
import 'package:stage/config/public_vars.dart';
import 'package:http/http.dart' as http;

class list_new extends StatefulWidget {
  static String routeName = "/newlist";
  const list_new({Key key}) : super(key: key);

  @override
  _list_newState createState() => _list_newState();
}

class _list_newState extends State<list_new> {
  String id = "";


  List<Stage> values = new List();
  SharedPreferences sharedPreferences;
  User _user;


  Future getId() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    print("home : " + id);
    setState(() {
      id = prefs.getString('id');
    });


  }

  Future<List<Stage>> getCryptocurrency(String id) async {
    //final String apiUrl = "https://tuncoin.herokuapp.com/cryptocurrency/values";
    var Response = await http.get(Uri.parse(baseUrl+'/user/getUser/$id'));

    if (Response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(Response.body);

      List<dynamic> body = json['stage'];

     List values =
      body.map((dynamic item) => new Stage.fromJson(item)).toList();
      return values;
    } else {
      throw ("Can't get the value");
    }
  }
   Future<List<Stage>> getCryp;
  Future<User> getUser(String id) async {

    var Response = await http.get(Uri.parse(baseUrl+'/user/getUser/$id'));

    final String responseString = Response.body;
   // print(userFromJson(responseString));

    User u = userFromJson(responseString);
    //Stage s = stageFromjson(responseString);
    //print(stage);
    Map<String,dynamic> json = jsonDecode(responseString);
    List<dynamic> body = json['stage'];
    List<Stage> values =
    body.map((dynamic item) => Stage.fromJson(item)).toList();

    print(values[0].title);

    return u;

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<List<Stage>>(
          future: getCryp,
          builder: (context, snapshot){
            if(snapshot.hasData) {
              List<Stage> data= snapshot.data;
              return ListView.builder(
                itemBuilder: (context,index){
                  return ListTile(

                   // leading: CircleAvatar(backgroundImage: NetworkImage(),
                    title:Text(data[index].title),
                    subtitle: Text(""),
                  );
                },

              );

            }else{
              return CircularProgressIndicator();
            }
    }
        ),
      ),
    );
  }
  @override
  void initState() {

    super.initState();
   getId();
    getUser(id);
   getCryp =getCryptocurrency(id);

  }

}
