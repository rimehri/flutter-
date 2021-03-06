
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:stage/config/public_vars.dart';
import 'package:stage/screens/sign_in/sign_in_screen.dart';

import 'package:shared_preferences/shared_preferences.dart';
class UpdatePasswordPage extends StatefulWidget {
  static String routeName = "/UpdatePassword";
  @override
  _UpdatePasswordPageState createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool hidePassword = true;
  SharedPreferences prefs;
  bool hidePassword2 = true;
  bool hidePassword3= true;
  String code1;
  String email1;
  String password1;
  TextEditingController _confirmpas = TextEditingController();
  TextEditingController _code = TextEditingController();
  TextEditingController _password = TextEditingController();
  Future<Null> getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email1 = prefs.getString('emailUser');
      print(email1);
    });

    print("rimeh"+email1);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: Text("Update  Password"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _formkey,
              child: Column(
                children: [
                  Center(
                    child: Text(
                      'Update Password !',
                      style: TextStyle(
                          color: Color.fromRGBO(222,10,48,1),
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat'),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: TextFormField(
                      controller: _code,
                      decoration: InputDecoration(
                        hintText: 'Your actual Password ',
                        border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(50.0))),
                        hintStyle: TextStyle(fontFamily: 'Montserrat'),
                        filled: true,
                        contentPadding: EdgeInsets.all(16.0),
                          prefixIcon: Icon(Icons.lock_outline),

                      suffixIcon: IconButton(

                        onPressed: () {
                          setState(() {
                            hidePassword = !hidePassword;
                          });
                        },
                        icon: Icon(hidePassword
                            ? Icons.visibility_off
                            : Icons.visibility),
                      ),),
                      obscureText: hidePassword,
                      keyboardType: TextInputType.text,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return " Password invalid";
                        }
                        code1 = value;
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding:
                    EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                    child: TextFormField(
                      controller: _password,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(50.0))),
                        hintStyle: TextStyle(fontFamily: 'Montserrat'),
                        filled: true,
                        contentPadding: EdgeInsets.all(16.0),
                        prefixIcon: Icon(Icons.lock_outline),
                        suffixIcon: IconButton(

                          onPressed: () {
                            setState(() {
                              hidePassword = !hidePassword;
                            });
                          },
                          icon: Icon(hidePassword
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      obscureText: hidePassword,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Please entre Password ";
                        }
                        password1 =value;
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: TextFormField(
                      controller: _confirmpas,
                      decoration: InputDecoration(
                        hintText: 'Confirm Password',
                        border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(50.0))),
                        hintStyle: TextStyle(fontFamily: 'Montserrat'),
                        filled: true,
                        contentPadding: EdgeInsets.all(16.0),
                        prefixIcon: Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              hidePassword2 = !hidePassword2;
                            });
                          },
                          icon: Icon(hidePassword
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      obscureText: hidePassword,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Please entre Password ";
                        }
                        if (_password.text != _confirmpas.text) {
                          return "error confirm password ";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 8.0)),
                  Container(
                    width: 320.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        stops: [0.1, 0.9],
                        colors: [
                          Color.fromRGBO(222,10,48,1),
                          Color.fromRGBO(237, 116, 138, 1),

                        ],
                      ),
                    ),
                    child: FlatButton(
                      child: Text(
                        'New Password',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      textColor: Colors.white,
                      color: Colors.transparent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      onPressed: () async {
                        final String apiUrl = baseUrl+"/user/resetPassword/";
                        if (_formkey.currentState.validate()) {
                          getSharedPrefs();
                          print(code1);
                          print(password1);
                          print(email1+"yy");
                          Map<String,dynamic> carda = {
                            "email" : email1,
                            "resetCode" : int.parse(code1),
                            "password" : password1
                          };
                          Map<String, String> header = {
                            "Content-Type": "application/json; chartset=UTF-8"
                          };

                          http.patch(Uri.parse(apiUrl),
                              headers: header,
                              body: json.encode(carda)).then((http.Response reponse) {

                            String message = reponse.statusCode == 200
                                ? "c"
                                : "false";
                            if (message =="c"){
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => Dialog(
                                  backgroundColor: Colors.white,
                                  shape:
                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                                  child: Stack(
                                    overflow: Overflow.visible,
                                    alignment: Alignment.topCenter,
                                    children: [
                                      Container(
                                        height: 300,
                                        width: 350,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
                                          child: Column(
                                            children: [
                                              Text(
                                                'Information',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold, fontSize: 20),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                'Update passwoed with seccuss : \n ' ,
                                                style: TextStyle(fontSize: 20),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              RaisedButton(
                                                onPressed: () => Navigator.of(context).pushReplacement(
                                                    MaterialPageRoute(
                                                        builder: (context) => SignInScreen())),
                                                color: Colors.green,
                                                child: Text(
                                                  'Okay',
                                                  style: TextStyle(color: Colors.white),
                                                ),
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
                              );}
                            else {
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Log In Error'),
                                  content: Text(
                                    'Code Invalid',
                                    style: TextStyle(fontSize: 20.0, color: Colors.red),
                                  ),
                                  actions: <Widget>[
                                    FlatButton(
                                        onPressed: () => Navigator.pop(context, 'OK'),

                                        child: Text('OK'))
                                  ],
                                ),
                              );

                            }
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
