import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stage/Entities/User.dart';
import 'package:stage/screens/cart/components/cart_card.dart';
import 'package:stage/screens/cart/services.dart';
import 'package:stage/screens/profile/UIprofil.dart';
import 'package:stage/screens/training/details_Stage.dart';
import 'package:stage/screens/add_training/add.dart';
import 'package:stage/screens/grade/add_grade.dart';

class ri extends StatefulWidget {

  static String routeName = "/Liststage";
  static String User_id = "";
  @override
  _riState createState() => _riState();
}



class _riState extends State<ri> {
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
        onPressed: ()=>{
          Navigator.pushReplacementNamed(context, addScreen.routeName)
        },

        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );






  }

 Widget getBody() {




  return FutureBuilder<dynamic>(
    future: getUserDetails(),
    builder: (
        BuildContext context,
        AsyncSnapshot<dynamic> snapshot,
        ) {
      print(snapshot.connectionState);
      if (snapshot.connectionState == ConnectionState.waiting) {
        return CircularProgressIndicator();
      } else if (snapshot.connectionState == ConnectionState.done) {
        print("---------");
        print(snapshot.data.stage);
        print("---------");
        if (snapshot.hasError) {

          return const Text('Error');
        } else if (snapshot.hasData) {
          return ListView.builder(itemCount: snapshot.data.stage.length,itemBuilder: (context,index){
 return Padding(
   padding: EdgeInsets.symmetric(vertical: 10),
   child: Dismissible(
     key: Key(snapshot.data.stage[index].title),
     direction: DismissDirection.endToStart,
     onDismissed: (direction) {
       setState(() {
         snapshot.data.stage.removeAt(index);
       });
     },
     background: Container(
       padding: EdgeInsets.symmetric(horizontal: 20),
       decoration: BoxDecoration(
         color: Color(0xFFFFE6E6),
         borderRadius: BorderRadius.circular(15),
       ),
       child: Row(
         children: [
           Spacer(),
           SvgPicture.asset("assets/icons/Trash.svg"),
         ],
       ),
     ),
     child: CartCard(cart: snapshot.data.stage[index]),
   ),
 );
      });
        } else {
          return const Text('Empty data');
        }
      } else {
        return Text('State: ${snapshot.connectionState}');
      }
    },
  );
  }
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
  Future <dynamic> getUserDetails () async {

    SharedPreferences prefs =   await SharedPreferences.getInstance();
    String  id = prefs.getString('id');
    print("home : " + id);
    return Services.getUser(id);
  }
}
