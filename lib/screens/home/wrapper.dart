
import 'package:bus_on_the_way/screens/authenticate/authenticate.dart';
import 'package:bus_on_the_way/screens/home/home.dart';
import 'package:bus_on_the_way/screens/studentHome/studentHome.dart';
import 'package:flutter/material.dart';
import 'package:bus_on_the_way/screens/home/home.dart';
import 'package:provider/provider.dart';
import 'package:bus_on_the_way/models/newUser.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<newUser?>(context);
    double height = MediaQuery.of(context).size.height;
    //print(user);
    if(user == null) {
      return Authenticate();
    } else {
      return StudentHome(height: height,);
    }
    //return either Home or Authenticate widget
   
  }
}