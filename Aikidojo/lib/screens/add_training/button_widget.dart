import 'package:flutter/material.dart';
import 'package:stage/screens/add_training/add.dart';
import 'package:stage/screens/add_training/add.dart';
class ButtonWidget extends StatelessWidget {
  final VoidCallback onClicked;
  final String text;

  const ButtonWidget({
    Key key,
     this.onClicked,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(

    margin: EdgeInsets.only(left:0 , right: 0, top: 20),
    padding: EdgeInsets.only(left: 20, right: 190),
    height: 54,
    decoration: BoxDecoration(


      borderRadius: BorderRadius.circular(50),
      color: Colors.grey[200],
      boxShadow: [
        BoxShadow(

            offset: Offset(0, 10),
            blurRadius: 50,
            color: Color(0xffEEEEEE)
        ),
      ],
    ),
    child: Container(

      child: InkWell(
        child: Container(
             // style: ElevatedButton.styleFrom(minimumSize: Size(100, 42)),
          //style: ElevatedButton.styleFrom( primary:Colors.grey[200],minimumSize: Size(80,42)),

              child: Container(


                child: Row(

                  mainAxisSize: MainAxisSize.min,
                  children: [

                    Icon( Icons.date_range,
                      color: Color.fromRGBO(200, 25, 25, 0.5),),
                    const SizedBox(width: 20),
                    Text(

                      text,
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold),


                    ),

                  ],
                ),
              ),

            ),
        onTap:   onClicked,
      ),
    ),
  );
}
