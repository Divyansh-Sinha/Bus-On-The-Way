import 'package:bus_on_the_way/screens/authenticate/authenticate.dart';
import 'package:bus_on_the_way/screens/driverHome/driverHome.dart';
import 'package:bus_on_the_way/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:bus_on_the_way/screens/home/home.dart';
import 'package:provider/provider.dart';
import 'package:bus_on_the_way/models/newUser.dart';

class DriverWrapper extends StatelessWidget {
  final String? text;
  dynamic context;
  DriverWrapper({this.text});
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    final user = Provider.of<newUser?>(context);
    //print(user);
    if (user == null) {
      return Authenticate(text: this.text);
    } else {
      return DriverHome(height: height);
    }
    //return either Home or Authenticate widget
  }
}
