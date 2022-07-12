import 'package:flutter/material.dart';


import '../Profile.dart';
import 'profile_menu.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(

      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [

          SizedBox(height: 20),
          ProfileMenu(
            text: "Stages",
            icon: "assets/icons/User Icon.svg",
            press: () => {
              Navigator.pushReplacementNamed(context, ProfilePage.routeName)

            },
          ),

          ProfileMenu(
            text: "Grades",
            icon: "assets/icons/Settings.svg",
            press: () {},
          ),

          ProfileMenu(
            text: "Log Out",
            icon: "assets/icons/Log out.svg",
            press: () {},
          ),
        ],
      ),
    );
  }
}
