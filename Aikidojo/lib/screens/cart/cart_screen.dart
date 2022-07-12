import 'package:flutter/material.dart';
import 'package:stage/models/Cart.dart';


import 'components/body.dart';
import 'package:stage/screens/add_training/add.dart';

class CartScreen extends StatelessWidget {
  static String routeName = "/cart";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
      floatingActionButton: FloatingActionButton(
    onPressed: ()=>{
    Navigator.pushReplacementNamed(context, addScreen.routeName)
    },child: Icon(Icons.add),)
      //bottomNavigationBar: CheckoutCard(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          Text(
            "Your Training ",
            style: TextStyle(color: Colors.black),
          ),
          Text(
            "${demoCarts.length} items",
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}
