import 'package:flutter/material.dart';
import 'package:stage/config/public_vars.dart';
import 'package:stage/screens/forgot_password/Update_Password.dart';
import 'package:stage/screens/profile/UIprofil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stage/screens/sign_in/sign_in_screen.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
String IdUser;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(),
          SizedBox(height: 20),
          ProfileMenu(
            text: "My Account",
            icon: "assets/icons/User Icon.svg",
            press: () => {
              Navigator.pushReplacementNamed(context, ProfileUI2.routeName)

            },
          ),
          ProfileMenu(
            text: "Notifications",
            icon: "assets/icons/Bell.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Settings",
            icon: "assets/icons/Settings.svg",
            press: () {
              Navigator.pushNamed(context, UpdatePasswordPage.routeName);
            },
          ),
          ProfileMenu(
            text: "Help Center",
            icon: "assets/icons/Question mark.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Delete Account",
            icon: "assets/icons/remove.svg",
            press: () {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => Dialog(
                  backgroundColor: Colors.white,
                  shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                  child: Stack(
                    overflow: Overflow.visible,
                    alignment: Alignment.topCenter,

                    children: [
                      Container(
                        height: 300,
                        width: 300,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(40, 70, 40, 30),
                          child: Column(
                            children: [
                              Text(
                                'Alert',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'You Really Delete Your Account : \n ' ,
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children:[

                              RaisedButton(
                                  color: Colors.green,
                                  child: Text(
                                    'Yes',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                onPressed: () async {
                                  final String apiUrl = baseUrl +
                                      "/user/deleteAccount/";
                                  SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                                  prefs.setString('id', IdUser);
                                  print(IdUser);
                                  Map<String, String> cardata = {
                                    "id": IdUser,};
                                  Map<String, String> header = {
                                    "Content-Type": "application/json; chartset=UTF-8"
                                  };
                                  http.delete(Uri.parse(apiUrl),
                                      headers: header,
                                      body: json.encode(cardata)

                                  ).then((http.Response reponse) {
                                    String message = reponse.statusCode == 200
                                        ? "true"
                                        : "failed";
                                    if (message == "true") {
                                      print("delete");
                                      Navigator.pushNamed(context, SignInScreen.routeName);

                                    }
                                    else { print("Failed");}
                                  },


                                   );
                                }
                              ),
                              RaisedButton(
                                onPressed: () { Navigator.pop(context, 'No');},

                                color: Colors.red,
                                child: Text(
                                  'No',
                                  style: TextStyle(color: Colors.white),

                                ),
                              )
                            ]
                              )
                      )

                            ],
                          ),
                        ),
                      ),
                      Positioned(
                          top: -60,
                          child: CircleAvatar(
                            backgroundColor: Colors.green,
                            radius: 60,
                            child: Icon(
                              Icons.check_rounded,
                              color: Colors.white,
                              size: 50,
                            ),
                          )),
                    ],
                  ),
                ),
              );

            },
          ),
        ],
      ),
    );
  }
@override
void initState() {
  super.initState();
  getSharedPrefs();

}
  Future<Null> getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      IdUser = prefs.getString("id");


    });
}
}