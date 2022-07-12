import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:stage/Home_aikidoka/home_screen.dart';

import 'package:stage/screens/Dashboard/menu.dart';
import 'package:stage/screens/add_training/add.dart';
import 'package:stage/screens/cart/cart_screen.dart';
import 'package:stage/screens/complete_profile/complete_profile_screen.dart';
import 'package:stage/screens/forgot_password/forgot_password_screen.dart';
import 'package:stage/screens/grade/add_grade.dart';
import 'package:stage/screens/grade/list_grade.dart';
import 'package:stage/screens/home/home_screen.dart';
import 'package:stage/screens/profile/UIprofil.dart';
import 'package:stage/screens/login_success/login_success_screen.dart';
import 'package:stage/screens/otp/otp_screen.dart';
import 'package:stage/profileDetails/Profile.dart';
import 'package:stage/screens/profile/profile_screen.dart';
import 'package:stage/screens/scanner/scan.dart';
import 'package:stage/screens/sign_in/sign_in_screen.dart';
import 'package:stage/screens/sign_up/sign_up_screen.dart';
import 'package:stage/screens/training/liste_stage.dart';
import 'package:stage/screens/forgot_password/Update_Password.dart';
import 'package:stage/screens/club/add_club.dart';

import 'components/Drawer.dart';
import 'screens/splash/splach_screen.dart';


// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  Home_aikido.routeName: (context) => Home_aikido(),
  addScreen.routeName:(context) => addScreen(),
  grade.routeName:(context) => grade(),
  Scan.routeName:(context) => Scan(),
  addgrade.routeName:(context) => addgrade(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  ProfilePage.routeName: (context) => ProfilePage(),
  add_club.routeName: (context) => add_club(),
  Dashboard.routeName: (context) => Dashboard(),
  ProfileUI2.routeName: (context) => ProfileUI2(),
  UpdatePasswordPage.routeName:(context) => UpdatePasswordPage(),

  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  DRAWER.routeName: (context) => DRAWER(),



ri.routeName:(context) => ri(),
  OtpScreen.routeName: (context) => OtpScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  CartScreen.routeName: (context) => CartScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),



};
