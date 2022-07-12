import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stage/screens/profile/UIprofil.dart';
import 'package:stage/screens/training/details_Stage.dart';
import 'package:stage/screens/add_training/add.dart';
import 'package:stage/screens/grade/add_grade.dart';

class grade extends StatefulWidget {

  static String routeName = "/Listgrade";
  @override
  _gradeState createState() => _gradeState();
}



class _gradeState extends State<grade> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text("Training"),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () =>
                Navigator.pushReplacementNamed(context, ProfileUI2.routeName)
        ),
      ),

      body:





      Container(
        child: Align(
            alignment: Alignment(1.00,0.50),
            child: getBody()),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(168, 40, 40, 1),
        onPressed: ()=>{

          Navigator.pushReplacementNamed(context, addgrade.routeName)
        },

        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );






  }

  Widget getBody() {

    List items = [
      "1",
      "2",
      "3",
      "4"
    ];
    return ListView.builder(itemCount: items.length,itemBuilder: (context,index){

      return getCard();

    }) ;}
  Widget getCard(){

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: ListTile(
          onTap: ()=>{
            Navigator.pushReplacementNamed(context, stagesD.routeName)
          },
          title: Row(

            children: [
              Container(

                width: 120,
                height: 90,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),

                    color: Colors.grey,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage("https://upload.wikimedia.org/wikipedia/commons/thumb/f/f6/Nikyo_omote.jpeg/220px-Nikyo_omote.jpeg")
                    )
                ),
              ),
              SizedBox(
                width: 20,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [


                  Text("Title training",style: TextStyle(fontSize: 17)),
                  Text(" wardia Tunis ",style: TextStyle(fontSize: 10)
                  )
                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}
