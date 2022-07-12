import 'package:flutter/material.dart';
import 'package:stage/Home_aikidoka/body.dart';


import 'package:stage/components/coustom_bottom_nav_bar.dart';

import '../../enums.dart';
import 'package:stage/screens/home/components/body.dart';

class Home_aikido extends StatelessWidget {
  static String routeName = "/home_aikido";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body_aikidoka(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
