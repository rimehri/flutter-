
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:stage/Entities/User.dart';
import 'package:stage/components/custom_surfix_icon.dart';
import 'package:stage/components/default_button.dart';
import 'package:stage/components/form_error.dart';
import 'package:stage/screens/forgot_password/reset_password.dart';
import 'package:stage/components/no_account_text.dart';
import 'package:stage/config/public_vars.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  SharedPreferences sharedPreferences;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.04),
              Text(
                "Forgot Password",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(28),
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Please enter your email and we will send \nyou a link to return to your account",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.1),
              ForgotPassForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class ForgotPassForm extends StatefulWidget {
  @override
  _ForgotPassFormState createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {
  final _formKey = GlobalKey<FormState>();
  String email1;
  List<String> errors = [];



  Future forgetpassword(String email) async {

    // double amount1 = double.parse(amount);
    final Response = await http.patch(
        Uri.parse("http://192.168.1.22:3000/user/forgotPassword"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body:jsonEncode(<String, String> {"email": email1}));

    if (Response.statusCode == 200) {


    }  else {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Log In Error'),
          content: Text(
            'mail not found! '+email1,
            style: TextStyle(fontSize: 20.0, color: Colors.red),
          ),
          actions: <Widget>[
            FlatButton(
                onPressed: () => Navigator.pop(context, 'OK'),

                child: Text('OK'))
          ],
        ),
      );
      throw Exception("ff");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            onSaved: (newValue) => email1 = newValue,
            onChanged: (value) {
              email1 = value;
              if (value.isNotEmpty && errors.contains(kEmailNullError)) {
                setState(() {
                  errors.remove(kEmailNullError);
                });
              } else if (emailValidatorRegExp.hasMatch(value) &&
                  errors.contains(kInvalidEmailError)) {
                setState(() {
                  errors.remove(kInvalidEmailError);
                });
              }
              return null;
            },
            validator: (value) {
              if (value.isEmpty && !errors.contains(kEmailNullError)) {
                setState(() {
                  errors.add(kEmailNullError);
                });
              } else if (!emailValidatorRegExp.hasMatch(value) &&
                  !errors.contains(kInvalidEmailError)) {
                setState(() {
                  errors.add(kInvalidEmailError);
                });
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: "Email",
              hintText: "Enter your email",
              // If  you are using latest version of flutter then lable text and hint text shown like this
              // if you r using flutter less then 1.20.* then maybe this is not working properly
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          FormError(errors: errors),
          SizedBox(height: SizeConfig.screenHeight * 0.1),
          DefaultButton(
              text: "Continue",
              press: () async{
                final String apiUrl = baseUrl+"/user/forgetPassword/";
                if (_formKey.currentState.validate()){
                  SharedPreferences prefs =
                  await SharedPreferences.getInstance();

                  prefs.setString('emailUser', email1);




                  print(email1);
                  Map<String, String> cardata = {
                    "email": email1,};
                  Map<String, String> header = {
                    "Content-Type": "application/json; chartset=UTF-8"
                  };
                  http.patch(Uri.parse(apiUrl),
                      headers: header,
                      body: json.encode(cardata)

                  ).then((http.Response reponse) {
                    String message = reponse.statusCode == 200
                        ? "true"
                        : "failed";
                    if (message =="true"){
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
                                height: 350,
                                width: 300,
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
                                        'Check you e-mail : \n ' ,
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      RaisedButton(
                                        onPressed: () => Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) => ResetPasswordPage())),
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
                      );} else {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Log In Error'),
                          content: Text(
                            'mail not found! ',
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

                    print("email" + email1);


                    /*  await forgetpassword(email1);}
                else { return;}*/






                    // Do what you want to do
                  }
                  ); }}
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.1),
          NoAccountText(),
        ],
      ),
    );
  }
}


