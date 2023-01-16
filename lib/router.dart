import 'package:checkwan/launcher.dart';
import 'package:checkwan/screen/forgotpassword.dart';
import 'package:checkwan/screen/homepage.dart';
import 'package:checkwan/screen/homescreen.dart';
import 'package:checkwan/screen/loginscreen.dart';
import 'package:checkwan/screen/register.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  '/home': (BuildContext context) => HomeScreen(),
  '/login': (BuildContext context) => LoginScreen(),
  '/homepage': (BuildContext context) => HomePage(),
  '/forgotpassword': (BuildContext context) => Forgotpassword(),
  '/launcher': (BuildContext context) => Launcher(),
};
