import 'package:flutter/material.dart';
import 'package:stage/Entities/User.dart';
import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:stage/components/default_button.dart';
import 'package:stage/config/public_vars.dart';
import 'package:stage/screens/login_success/login_success_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class OtpForm extends StatefulWidget {
  const OtpForm({
    Key key,
  }) : super(key: key);

  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  String code ;
  int codeu;
  FocusNode pin2FocusNode;
  FocusNode pin3FocusNode;
  String u1,u2,u3,u4;
  FocusNode pin4FocusNode;
  String id_user;
  String email_user;
  Future<User> user;
  SharedPreferences prefs;


  Future<Null> getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
codeu = prefs.getInt("codeI");
      id_user = prefs.getString("id");
    email_user = prefs.getString('emailU');
    print(email_user);
    });

    print("rimeh"+email_user);
  }
  Future<User> verif(String email,String code) async {
    final response = await http.patch(
      Uri.parse(baseUrl+'/user/activateAccount'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, dynamic>{
            'email' : email_user,
            'code': int.parse(code) }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      print(jsonDecode(response.body));
      return User.fromJson(jsonDecode(response.body));

    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      print("not logged");
      Fluttertoast.showToast(
          msg: "code invalid",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);

      throw Exception('Failed to create account.');
    }
  }



  @override
  void initState() {
    super.initState();
    getSharedPrefs();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pin2FocusNode.dispose();
    pin3FocusNode.dispose();
    pin4FocusNode.dispose();
  }

  void nextField(String value, FocusNode focusNode) {
    if (value.length == 1) {
      focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          SizedBox(height: SizeConfig.screenHeight * 0.15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: getProportionateScreenWidth(60),
                child: TextFormField(

                  autofocus: true,
                  obscureText: true,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    u1 = value;
                    nextField(value, pin2FocusNode);
                  },
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(60),
                child: TextFormField(
                  focusNode: pin2FocusNode,
                  obscureText: true,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    u2 = value;
                    nextField(value, pin3FocusNode);},
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(60),
                child: TextFormField(
                  focusNode: pin3FocusNode,
                  obscureText: true,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    u3 = value;
                    nextField(value, pin4FocusNode);
                  },
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(60),
                child: TextFormField(
                  focusNode: pin4FocusNode,
                  obscureText: true,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    u4= value;
                    if (value.length == 1) {

                      pin4FocusNode.unfocus();
                      code = u1+u2+u3+u4;
                      print(code);
                      // Then you need to check is the code is correct or not
                    }
                  },
                ),
              ),


            ],

          ),


          SizedBox(height: SizeConfig.screenHeight * 0.15),


          DefaultButton(
            text: "Continue",
            press: ()async {

print(code);
print(email_user);

               await verif(email_user,u1+u2+u3+u4 );


                Navigator.pushNamed(context, LoginSuccessScreen.routeName);
             /* }
              else {
                Fluttertoast.showToast(
                    msg: "code invalide",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);

              }
*/
            },
          )
        ],
      ),
    );
  }
}
