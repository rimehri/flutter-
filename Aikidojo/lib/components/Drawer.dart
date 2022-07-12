import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:stage/screens/home/components/body.dart';
import 'package:stage/screens/home/home_screen.dart';
import 'package:stage/screens/sign_in/sign_in_screen.dart';
import 'package:stage/profileDetails/Profile.dart';


class DRAWER extends StatefulWidget {

  static String routeName = "/drawer";

  @override
  _DRAWERState createState() => _DRAWERState();
}

class _DRAWERState extends State<DRAWER> {
  double value = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                   Color.fromRGBO(247, 237, 243,20 ),
                 Color.fromRGBO(255, 237, 243,20 ),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              )
            ),
          ),
          //the Navigation Menu
          SafeArea(
            child: Container(
              width: 200.0,
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  DrawerHeader(child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50.0,
                        backgroundImage: NetworkImage("https://picsum.photos/250?image=9") ,
                      ),
                      SizedBox(height: 20.0),
                      Text("",style: TextStyle(color: Colors.black38,
                      fontSize: 10.0),
                      ),
    ],),),
                      Expanded(child: (ListView(
                        children: [
                          ListTile(
                            onTap:(){
                              Navigator.pushReplacementNamed(context, ProfilePage.routeName);
                            },
                            leading: Icon(Icons.account_circle_rounded,color: Colors.black38,),
                            title: Text("Profil",style: TextStyle(color: Colors.black38),),

                          ),
                          ListTile(
                            onTap:(){},
                            leading: Icon(Icons.settings,color: Colors.black38,),
                            title: Text("Setting",style: TextStyle(color: Colors.black38),),

                          ),
                          ListTile(
                            onTap:(){},
                            leading: Icon(Icons.help,color: Colors.black38,),
                            title: Text("Help",style: TextStyle(color: Colors.black38),),

                          ),
                          ListTile(
                            onTap:(){Navigator.pushReplacementNamed(context, SignInScreen.routeName);},
                            leading: Icon(Icons.logout,color: Colors.black38,),
                            title: Text("Logout",style: TextStyle(color: Colors.black38),),

                          ),
                        ],
                      )
                      )
                      )



                ],
              ),
            )
          ),
          TweenAnimationBuilder(tween: Tween <double>(begin: 0, end: value),
                                duration: Duration(milliseconds: 500),
                                builder: (_,double val,__){
            return(
Transform(
  alignment: Alignment.center ,
transform: Matrix4.identity()
  ..setEntry(3, 2,0.001)
    ..setEntry(0, 3, 200*val)
    ..rotateY((pi/6) * val),
    child: HomeScreen(),

));


    }),
          GestureDetector(
            onHorizontalDragUpdate: (e){
              if(e.delta.dx>0){

                setState(() {
                  value =1;
                });
              }
              else{
                setState(() {
                  value =0;
                });
              }
            },
            /*onTap: (){
              setState(() {
                value == 0
                    ? value =1
                    : value = 0;
              });
            },*/
          )
        ],
      ),
    );
  }
}
