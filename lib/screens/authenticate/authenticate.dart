
import 'package:bus_on_the_way/Registration/register.dart';
import 'package:bus_on_the_way/screens/authenticate/studentSign_in.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  final String? text;

  Authenticate({this.text});
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toogleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    if (showSignIn) {
      return SignIn(toogleView: toogleView, height: height);
    } else {
      return Register(toogleView: toogleView, height: height);
    }
  }
}
