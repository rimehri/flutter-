import 'dart:async';
import 'dart:core';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stage/Entities/User.dart';
import 'package:stage/config/public_vars.dart';
import 'package:stage/models/Cart.dart';
import 'package:stage/screens/sign_in/sign_in_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../constants.dart';
import '../../../size_config.dart';

class CartCard extends StatefulWidget {
  const CartCard({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final Stage cart;

  @override
  _CartCardState createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  String id = "";


  List<Stage> stages = new List();
  SharedPreferences sharedPreferences;
  User _user;

  Future getId() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString('id');
    print("home : " + id);


  }
  Future<User> getUser(String id) async {

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
    final User user = await getUser(id);

    return userFromJson(responseString);

  }

  @override

  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 88,
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(10)),
              decoration: BoxDecoration(
                color: Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(15),
              ),
              //child: Image.asset("/images/aa.png"),
            ),
          ),
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.cart.date.toString(),
              style: TextStyle(color: Colors.black, fontSize: 16),
              maxLines: 2,
            ),
            SizedBox(height: 10),
            Text.rich(
              TextSpan(
                text: "\$${"r"}",
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: kPrimaryColor),
                children: [
                  TextSpan(
                      text: " x${widget.cart.sensei}",
                      style: Theme.of(context).textTheme.bodyText1),
                ],
              ),
            ),
    FlatButton(
    child: Text('SignUp', style: TextStyle(fontSize: 20.0),),
    onPressed: () {getUser(id);},
    ) ],
        )
      ],
    );
  }
  @override
  void initState() {

    super.initState();
    getId();
    getUser(id);
  }

}
