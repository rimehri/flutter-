import 'package:flutter/material.dart';
import 'dart:math';

import 'package:stage/screens/add_training/add.dart';
import 'package:stage/screens/cart/cart_screen.dart';
import 'package:stage/screens/grade/add_grade.dart';
class butt extends StatefulWidget {
  @override
  _buttState createState() => _buttState();
}

class _buttState extends State<butt> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;
  bool toggle = true;
  Alignment alignment1 = Alignment(0.0, 0.0);
  Alignment alignment2 = Alignment(0.0, 0.0);
  Alignment alignment3 = Alignment(0.0, 0.0);
  Alignment alignment4 = Alignment(0.0, 0.0);
  double size1 = 50.0;
  double size2 = 50.0;
  double size3 = 50.0;
  double size4 = 50.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 350),
      reverseDuration: Duration(milliseconds: 275),
    );
    _animation = CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
        reverseCurve: Curves.easeIn);
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: MediaQuery.of(context).size.height,
      //width: MediaQuery.of(context).size.width,

        child: Container(
          padding: EdgeInsets.fromLTRB(30, 30, 0, 0),
          height: 200.0,
          width: 250.0,
          child: Stack(
            children: [
              InkWell(
                child: AnimatedAlign(
                  duration: toggle
                      ? Duration(milliseconds: 275)
                      : Duration(milliseconds: 875),
                  alignment: alignment1,
                  curve: toggle ? Curves.easeIn : Curves.elasticOut,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 275),
                    curve: toggle ? Curves.easeIn : Curves.easeOut,
                    height: size1,
                    width: size1,
                    decoration: BoxDecoration(
                      color: Colors.black87,
                        borderRadius:  BorderRadius.circular(40.0),
                    ),
                    child: Icon(
                      Icons.person_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
                onTap: ()=>{
                  Navigator.pushReplacementNamed(context, CartScreen.routeName)
                },
                            ),
              InkWell(
                child: AnimatedAlign(
                  duration: toggle
                      ? Duration(milliseconds: 300)
                      : Duration(milliseconds: 875),
                  alignment: alignment2,
                  curve: toggle ? Curves.easeIn : Curves.elasticOut,
                  child: AnimatedContainer(

                    duration: Duration(milliseconds: 300),
                    curve: toggle ? Curves.easeIn : Curves.easeOut,
                    height: size2,
                    width: size2,
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius:  BorderRadius.circular(40.0),
                    ),

                    child: Icon(
                      Icons.person_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
                onTap: ()=>{
                  Navigator.pushReplacementNamed(context, CartScreen.routeName)
                },
              ),
              InkWell(
                child: AnimatedAlign(
                  duration: toggle
                      ? Duration(milliseconds: 275)
                      : Duration(milliseconds: 875),
                  alignment: alignment3,
                  curve: toggle ? Curves.easeIn : Curves.elasticOut,

                    child: AnimatedContainer(

                      duration: Duration(milliseconds: 275),
                      curve: toggle ? Curves.easeIn : Curves.easeOut,
                      height: size3,
                      width: size3,
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius:  BorderRadius.circular(40.0),
                      ),
                      child: Icon(
                        Icons.mode_edit,
                        color: Colors.white,
                      ),
                    ),
                  ),

              ),


              Align(
                alignment: Alignment.center,
                child: Transform.rotate(
                  angle: _animation.value * pi * (3 / 4),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 375),
                    curve: Curves.bounceInOut,
                    height: toggle ? 70.0 : 60.0,
                    width: toggle ? 70.0 : 60.0,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(200, 25, 25, 0.95),
                      borderRadius: BorderRadius.circular(60.0),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: IconButton(
                        splashColor: Colors.black38,
                        splashRadius: 31.0,
                        onPressed: () {
                          setState(() {
                            if (toggle) {
                              toggle = !toggle;
                              _controller.forward();
                              Future.delayed(Duration(milliseconds: 10),(){
                                alignment1 =Alignment(-0.7,-0.4);
                              size1 = 50.0;});
    Future.delayed(Duration(milliseconds: 100),(){
    alignment2 =Alignment(0.0,-0.8);size2 = 50.0;});
    Future.delayed(Duration(milliseconds: 200),(){
    alignment3 =Alignment(0.7,-0.4);size3 = 50.0;});




                            } else {
                              toggle = !toggle;
                              _controller.reverse();
                              alignment1 = Alignment(0.0,0.0);
                              alignment2 = Alignment(0.0,0.0);
                              alignment3 = Alignment(0.0,0.0);
                              size1=size2=size3=20.0;
                            }
                          });
                        },
                        icon: Image.asset(
                          "assets/icons/add.png",
                          height: 27.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

    );
  }
}
