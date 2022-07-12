import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../size_config.dart';

class DiscountBanner extends StatefulWidget {
  const DiscountBanner({
    Key key,
  }) : super(key: key);

  @override
  _DiscountBannerState createState() => _DiscountBannerState();
}

class _DiscountBannerState extends State<DiscountBanner> {
  SharedPreferences sharedPreferences;
  String id_user;
  String name;
  Future<Null> getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString("name");
      id_user = prefs.getString("id");

      print(name);
    });

    print("rimeh"+id_user);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 90,
      width: double.infinity,
      margin: EdgeInsets.all(getProportionateScreenWidth(10)),
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(30),
        vertical: getProportionateScreenWidth(30),
      ),
      decoration: BoxDecoration(
        color: Color.fromRGBO(168, 40, 40, 1,),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text.rich(
        TextSpan(
          style: TextStyle(color: Colors.white),
          children: [
            TextSpan(text: "Welcome Back \n"),
            TextSpan(
              text: name,
              style: TextStyle(
                fontSize: getProportionateScreenWidth(24),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );

  }

  @override
  void initState() {
    getSharedPrefs();


    super.initState();
  }

  }
