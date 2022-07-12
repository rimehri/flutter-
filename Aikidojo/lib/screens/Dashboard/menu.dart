




import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stage/components/button_floating.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:stage/screens/club/add_club.dart';

class Dashboard extends StatefulWidget {

  static String routeName = "/Dash";
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
    //  backgroundColor: Colors.white,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Padding(padding: const EdgeInsets.all(12.0),
              child: Center(
                child: Wrap(
                  spacing: 20.0,
                  runSpacing: 20.0,
                  children: [


                    SizedBox(
                      width: 120.0,
                      height: 120.0,
                      child: Card(
                        color: Color.fromRGBO(247, 237, 243,20 ),
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)
                        ),
                        child: Center(
                          child: Padding(
                            padding:  const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Image.asset("assets/icons/house.png",width: 60.0,),
                                SizedBox(height: 20.0),
                                Text("Home",style: TextStyle(
                                    color: Colors.black38,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10.0
                                ),)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    InkWell(
                      child: SizedBox(
                        width: 120.0,
                        height: 120.0,
                        child: Card(
                          color: Color.fromRGBO(247, 237, 243,20 ),
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)
                          ),
                          child: Center(
                            child: Padding(
                              padding:  const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Image.asset("assets/icons/club.png",width: 60.0,),
                                  SizedBox(height: 20.0),
                                  Text("Clubs",style: TextStyle(
                                      color: Colors.black38,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10.0
                                  ),)
                                ],
                              ),

                            ),
                          ),
                        ),

                      ),
                      onTap: ()=>{
                      Navigator.pushReplacementNamed(context, add_club.routeName)
                    },
                    ),
                    SizedBox(
                      width: 120.0,
                      height: 120.0,
                      child: Card(
                        color: Color.fromRGBO(247, 237, 243,20 ),
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)
                        ),
                        child: Center(
                          child: Padding(
                            padding:  const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Image.asset("assets/icons/members.png",width: 60.0,),
                                SizedBox(height: 20.0),
                                Text("AIKIDOKA",style: TextStyle(
                                    color: Colors.black38,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10.0
                                ),)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 120.0,
                      height: 120.0,
                      child: Card(
                        color: Color.fromRGBO(247, 237, 243,20 ),
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)
                        ),
                        child: Center(
                          child: Padding(
                            padding:  const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Image.asset("assets/icons/aikido.png",width: 60.0,),
                                SizedBox(height: 20.0),
                                Text("Events",style: TextStyle(
                                    color: Colors.black38,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10.0
                                ),)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),





                  ],
                ),

              ),
            ),
            Container(
                margin: EdgeInsets.only(right:0, top: 10),
                alignment: Alignment.bottomRight,
                child: butt()),

          ],

        ),

      ),



    );
  }
}
