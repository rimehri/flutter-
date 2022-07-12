 import 'package:flutter/material.dart';

import '../../../size_config.dart';
import 'package:stage/screens/home/components/categories.dart';
import 'package:stage/screens/home/components/discount_banner.dart';
import 'package:stage/screens/home/components/home_header.dart';
import 'package:stage/screens/home/components/popular_product.dart';
import 'package:stage/screens/home/components/special_offers.dart';
import 'package:stage/screens/Dashboard/menu.dart';

import 'package:stage/components/coustom_bottom_nav_bar.dart';

import 'package:stage/enums.dart';
class Body_aikidoka extends StatelessWidget {
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


              SizedBox(height: getProportionateScreenWidth(30)),
              SpecialOffers(),
              SizedBox(height: getProportionateScreenWidth(30)),
              PopularProducts(),
              SizedBox(height: getProportionateScreenWidth(30)),


            ],

          ),
        ),
      ),
    );
  }
}
