 import 'package:flutter/material.dart';

import '../../../size_config.dart';
import 'categories.dart';
import 'discount_banner.dart';
import 'home_header.dart';
import 'popular_product.dart';
import 'special_offers.dart';
import 'package:stage/screens/Dashboard/menu.dart';

import 'package:stage/components/coustom_bottom_nav_bar.dart';

import 'package:stage/enums.dart';
class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Container(
      color: Colors.white,
      child: SafeArea(

        child: SingleChildScrollView(
          child: Column(
            children: [

              SizedBox(height: getProportionateScreenHeight(20)),
              HomeHeader(),
              SizedBox(height: getProportionateScreenWidth(10)),

              DiscountBanner(),
              SizedBox(height: getProportionateScreenWidth(10)),
              Categories(),
              Dashboard(),

              SizedBox(height: getProportionateScreenWidth(30)),


            ],

          ),
        ),
      ),
    );
  }
}
