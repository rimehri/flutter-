import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stage/screens/training/liste_stage.dart';


class stagesD extends StatefulWidget {
  static String routeName = "/detailsStage";

  @override
  _stagesDState createState() => _stagesDState();
}

class _stagesDState extends State<stagesD> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, ri.routeName)


          ),
          title: Text('Traning'),
        ),
        body: Column(
          children: [

            Container(
              padding: EdgeInsets.fromLTRB(200, 50, 0, 0),
              width: 310,
              child: FlatButton(
                color: Colors.red,
                textColor: Colors.white,
                disabledColor: Colors.grey,
                disabledTextColor: Colors.black,
                padding: EdgeInsets.only(left: 8.0),
                splashColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                child: Row(
                  children: [
                    Icon(Icons.add_circle),
                    Text("  Ajouter"),
                  ],
                ),
                onPressed: () {}
              ),
            ),
          ],
        ));
  }
}
