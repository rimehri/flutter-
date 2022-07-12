import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stage/Entities/User.dart';
import 'package:stage/config/public_vars.dart';
import 'package:stage/screens/complete_profile/complete_profile_screen.dart';
import 'package:stage/screens/grade/list_grade.dart';
import 'package:stage/screens/training/liste_stage.dart';
import 'components/profile_menu.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:stage/screens/profile/profile_screen.dart';
class ProfileUI2 extends StatefulWidget {
  static String routeName = "/pro";

  @override
  _ProfileUI2State createState() => _ProfileUI2State();
}
Future<User> getUser(String id) async {
  final String apiUrl = "https://tuncoin.herokuapp.com/loggedUser/$id";

  final Response = await http.get(Uri.parse(baseUrl+'/user/getUser/$id'));

  final String responseString = Response.body;
  print(userFromJson(responseString));

  return userFromJson(responseString);

}

class _ProfileUI2State extends State<ProfileUI2> {
   bool _status = true;
   User _user;
   String id = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text("Profil"),
    leading: IconButton(
    icon: Icon(Icons.arrow_back),
    onPressed: () =>
    Navigator.pushReplacementNamed(context, ProfileScreen.routeName),
    ),),
        body: SingleChildScrollView(
          child: Column(

            children: [
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            "https://image.shutterstock.com/image-photo/martial-art-aikido-athlete-demonstrates-260nw-1517204768.jpg"
                        ),
                        fit: BoxFit.cover
                    )
                ),

                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    child: Container(

                      alignment: Alignment(0.0,3.0),
                      child:
                      Container(
                        width: 140,
                        height: 140,
                        child: CircleAvatar(


                          backgroundImage: NetworkImage(
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTGeg0a5wyDchHuY6tgbDkWKNLYiS7vHn4w4g&usqp=CAU ",

                          ),
                          radius: 60.0,
                          child: Padding(
                            padding: EdgeInsets.only(top: 90.0, left: 60.0),

                            child: new Icon(


                              Icons.camera_alt,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Padding(

                padding: EdgeInsets.only(
                    left: 300.0, right: 0.0, top: 0.0),
                child: new Column(


                  children: <Widget>[
                  _status ?  _getEditIcon() : new Container(

                  ),
                  ],
                ),
              ),


              Text(
                _user.firstName
                ,style: TextStyle(
                  fontSize: 25.0,
                  color:Colors.blueGrey,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w400
              ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "wardia , tunis"
                ,style: TextStyle(
                  fontSize: 18.0,
                  color:Colors.black87,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w300
              ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Aikidoka at Club"
                ,style: TextStyle(
                  fontSize: 15.0,
                  color:Colors.black87,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w300
              ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Grade: XY"
                ,style: TextStyle(
                  fontSize: 15.0,
                  color:Colors.black87,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w300
              ),
              ),



              SizedBox(
                height: 30,
              ),

              Padding(
                //listView
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                      children: [
                        ProfileMenu(
                          text: "Training ",
                          icon: "assets/icons/Bill Icon.svg",

                          press: () => Navigator.pushReplacementNamed(context, ri.routeName),

                        ),
                        ProfileMenu(
                          text: "Grades",
                          icon: "assets/icons/Star Icon.svg",
                          press: () => Navigator.pushReplacementNamed(context, grade.routeName),


                        ),
                        ProfileMenu(
                          text: "Complete Your Profile",
                          icon: "assets/icons/Star Icon.svg",
                          press: () => Navigator.pushReplacementNamed(context, CompleteProfileScreen.routeName),


                        ),]
                  )




              ),

            ],
          ),
        )
    );
  }

  Widget _getEditIcon() {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: Colors.red,
        radius: 14.0,
        child: new Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = true;
        });
      },
    );
  }
   Future getId() async {
     WidgetsFlutterBinding.ensureInitialized();
     SharedPreferences prefs = await SharedPreferences.getInstance();
     id = prefs.getString('id');
     print("home : " + id);

     //get User

     final User user = await getUser(id);
     setState(() {
       _user = user;
       // print('lenghth' + (_user.stage.length).toString());
     });
     // for (var i = 0; i < _user.stage.length; i++) {
     //   stages.insert(0, _user.stage[i]);
     // }
   }
   @override
   void initState() {




     super.initState();
     getId();
     getUser(id);
   }
}